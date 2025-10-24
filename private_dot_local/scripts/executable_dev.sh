#!/bin/bash
# Container SSH script with proper git signing setup
# Usage: ./dev.sh

CONTAINER_HOST="dev-container"
SSH_KEY="$HOME/.ssh/id_ed25519"

ensure_ssh_key_loaded() {
    # Check if ssh-agent is running
    if [ -z "$SSH_AUTH_SOCK" ]; then
        echo "❌ ssh-agent is not running. Please start it first:"
        echo "   eval \$(ssh-agent -s)"
        exit 1
    fi
    
    # Check if key is already loaded in ssh-agent
    local key_fingerprint=$(ssh-keygen -lf "$SSH_KEY" 2>/dev/null | awk '{print $2}')
    
    if ! ssh-add -l 2>/dev/null | grep -q "$key_fingerprint"; then
        echo "SSH key not loaded. Adding to ssh-agent..."
        if ssh-add "$SSH_KEY"; then
            echo "✓ SSH key loaded successfully"
        else
            echo "❌ Failed to load SSH key"
            exit 1
        fi
    fi
}

get_ssh_public_key() {
    # Use the public key file directly 
    cat "$HOME/.ssh/id_ed25519.pub"
}

get_opencode_auth() {
    local auth_file="$HOME/.local/share/opencode/auth.json"
    if [ -f "$auth_file" ]; then
        cat "$auth_file"
    else
        echo ""
    fi
}

get_git_config_value() {
    local key="$1"
    git config --global --get "$key" 2>/dev/null || echo ""
}

setup_container_config() {
    echo "Setting up git config for container environment..."
    
    local ssh_key=$(get_ssh_public_key)
    local git_name=$(get_git_config_value "user.name")
    local git_email=$(get_git_config_value "user.email")
    local github_user=$(get_git_config_value "github.user")
    local temp_gitconfig=$(mktemp)

    cat > "$temp_gitconfig" << EOF
[user]
  name = ${git_name:-"Giygas"}
  email = ${git_email:-"user@example.com"}
  useConfigOnly = true
  signingkey = $ssh_key
[github]
  user = ${github_user:-"Giygas"}
[commit]
  gpgsign = true
[gpg]
  format = ssh
  sshprogram = ssh
[init]
  defaultBranch = main
EOF
    
    # Push gitconfig file
    scp -q "$temp_gitconfig" "$CONTAINER_HOST":/home/dev/.gitconfig
    rm -f "$temp_gitconfig"
    echo "✓ .gitconfig pushed"

    # Copy wakatime config file
    if [ -f "$HOME/.wakatime.cfg" ]; then
        scp -q "$HOME/.wakatime.cfg" "$CONTAINER_HOST":/home/dev/.wakatime.cfg 
        echo "✓ .wakatime.cfg pushed"
    else
        echo "⚠ .wakatime.cfg not found, skipping"
    fi
    
    # Copy opencode auth file
    local opencode_auth=$(get_opencode_auth)   
    if [ -n "$opencode_auth" ]; then
        # Create directory and file in container
        ssh "$CONTAINER_HOST" "mkdir -p /home/dev/.local/share/opencode"
        echo "$opencode_auth" | ssh "$CONTAINER_HOST" "cat > /home/dev/.local/share/opencode/auth.json"
        echo "✓ opencode auth.json pushed"
    else
        echo "⚠ opencode auth.json not found, skipping"
    fi
}

setup_port_forwarding() {
    echo "Setting up port forwarding tunnels..."

    # Check if SSH tunnel is already running
    if pgrep -f "ssh -f -N dev-container" > /dev/null; then
        echo "✓ Port forwarding tunnels already running"
        echo "  Access at: http:localhost:8984, http:localhost:8002, http:localhost:8001"
        return
    fi

    # Start SSH with forwarding from config (background, no command)
    ssh -f -N "$CONTAINER_HOST"

    if [ $? -eq 0 ]; then
        echo "✓ Port forwarding tunnels established"
        echo "  Access your apps at:"
        echo "    - http:localhost:8984"
        echo "    - http:localhost:8002"
        echo "    - http:localhost:8001"
    else
        echo "❌ Failed to establish port forwarding tunnels"
    fi
}

cleanup_port_forwarding() {
    echo "Cleaning up port forwarding tunnels..."
    pkill -f "ssh -f -N dev-container"
    echo "✓ Port forwarding tunnels stopped"
}


enter_container() {
    echo "Entering dev container..."
    
    ensure_ssh_key_loaded
    setup_container_config
    setup_port_forwarding
    
    echo "Launching WezTerm with cleanup monitor..."
    
    # Launch monitor script in background
    (
        # Launch WezTerm
        wezterm connect "$CONTAINER_HOST" > /dev/null 2>&1
        
        # When WezTerm exits, cleanup runs
        cleanup_port_forwarding
        cleanup_container
    ) &
    
    disown
    
    echo "✓ WezTerm launched and detached"
    echo "Cleanup will run automatically when WezTerm closes"
}

cleanup_container() {
    echo "Cleaning up container git config..."
    ssh "$CONTAINER_HOST" "rm -f /home/dev/.gitconfig /home/dev/.wakatime.cfg /home/dev/.local/share/opencode/auth.json"
    echo "✓ Cleanup completed"
}

# Main execution
enter_container
