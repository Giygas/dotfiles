#!/bin/bash
# Container SSH script with proper git signing setup using wezterm ssh
# Usage: ./devx.sh

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

check_port_available() {
    local port=$1
    if lsof -i ":$port" >/dev/null 2>&1; then
        return 1  # Port is in use
    else
        return 0  # Port is available
    fi
}

setup_port_forwarding() {
    echo "Setting up port forwarding tunnels..."

    # Check if SSH tunnel is already running
    if pgrep -f "ssh -f -N dev-container" > /dev/null; then
        echo "✓ Ports already established, access at:"
        echo "  - http:localhost:8984"
        echo "  - http:localhost:8985"
        echo "  - http:localhost:8002"
        echo "  - http:localhost:8001"
        return
    fi

    # Check if required ports are available
    local ports=(8984 8985 8002 8001)
    local occupied_ports=()
    
    for port in "${ports[@]}"; do
        if ! check_port_available "$port"; then
            occupied_ports+=("$port")
        fi
    done
    
    if [ ${#occupied_ports[@]} -gt 0 ]; then
        echo "✓ Ports already established, access at:"
        echo "  - http:localhost:8984"
        echo "  - http:localhost:8985"
        echo "  - http:localhost:8002"
        echo "  - http:localhost:8001"
        return
    fi

    # Start SSH with forwarding from config (background, no command)
    ssh -f -N "$CONTAINER_HOST"

    if [ $? -eq 0 ]; then
        echo "✓ Port forwarding tunnels established"
        echo "  Access your apps at:"
        echo "    - http:localhost:8984"
        echo "    - http:localhost:8985"
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
    
    # Check if tunnels already exist before setting up
    local tunnels_existed=false
    if pgrep -f "ssh -f -N dev-container" > /dev/null; then
        tunnels_existed=true
    fi
    
    setup_port_forwarding
    
    echo "Connecting to dev container..."
    
    # Set up cleanup trap
    trap 'cleanup_port_forwarding; cleanup_container' EXIT
    
    # Connect directly in current pane
    if pgrep -f "ssh -f -N dev-container" > /dev/null; then
        # Use regular SSH with X11 forwarding when tunnels exist
        if [ "$tunnels_existed" = true ]; then
            echo "Using existing tunnels..."
        else
            echo "Using newly established tunnels..."
        fi
        # Set DISPLAY variable for X11 forwarding
        DISPLAY=:0 ssh -Y -A -i ~/.ssh/id_ed25519 dev@192.168.1.10 -p 2222
    else
        # Use normal SSH config when no tunnels exist
        echo "Establishing new connection..."
        # Set DISPLAY variable for X11 forwarding
        DISPLAY=:0 ssh -Y "$CONTAINER_HOST"
    fi
    
    # Cleanup will run automatically when SSH exits due to trap
}

cleanup_container() {
    echo "Cleaning up container git config..."
    ssh "$CONTAINER_HOST" "rm -f /home/dev/.gitconfig /home/dev/.wakatime.cfg /home/dev/.local/share/opencode/auth.json"
    echo "✓ Cleanup completed"
}

# Main execution
enter_container
