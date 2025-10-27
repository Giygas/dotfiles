#!/bin/bash
# Container SSH script with proper git signing setup using wezterm ssh
# Usage: ./devx.sh

CONTAINER_HOST="dev-container"
SSH_KEY="$HOME/.ssh/id_ed25519"
TEMP_SSH_CONFIG=""

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

check_ports_occupied() {
    local ports=(8984 8985 8002 8001 8000 5173)
    for port in "${ports[@]}"; do
        if lsof -i ":$port" >/dev/null 2>&1; then
            return 0  # At least one port is occupied
        fi
    done
    return 1  # All ports are free
}

create_temp_ssh_config() {
    TEMP_SSH_CONFIG=$(mktemp)
    # Create temp config without LocalForward lines
    grep -v "LocalForward" ~/.ssh/config > "$TEMP_SSH_CONFIG"
    echo "✓ Created temporary SSH config without port forwarding"
}

cleanup_temp_ssh_config() {
    # Only cleanup if this is the last devx instance running
    # Count only bash processes running devx.sh, excluding the current process
    local devx_count=$(pgrep -f "bash.*devx.sh" | grep -v "^$$" | wc -l)
    
    if [ "$devx_count" -eq 0 ]; then
        if [ -n "$TEMP_SSH_CONFIG" ] && [ -f "$TEMP_SSH_CONFIG" ]; then
            rm -f "$TEMP_SSH_CONFIG"
            TEMP_SSH_CONFIG=""
            echo "✓ Cleaned up temporary SSH config (last instance)"
        fi
    else
        echo "ℹ️  Keeping temporary SSH config (other devx instances still running: $devx_count)"
    fi
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
    
    # Determine which SSH config to use
    local ssh_config_option=""
    if [ -n "$TEMP_SSH_CONFIG" ]; then
        ssh_config_option="-F $TEMP_SSH_CONFIG"
    fi
    
    # Push gitconfig file
    scp -q $ssh_config_option "$temp_gitconfig" "$CONTAINER_HOST":/home/dev/.gitconfig
    rm -f "$temp_gitconfig"
    echo "✓ .gitconfig pushed"

    # Copy wakatime config file
    if [ -f "$HOME/.wakatime.cfg" ]; then
        scp -q $ssh_config_option "$HOME/.wakatime.cfg" "$CONTAINER_HOST":/home/dev/.wakatime.cfg 
        echo "✓ .wakatime.cfg pushed"
    else
        echo "⚠ .wakatime.cfg not found, skipping"
    fi
    
    # Copy opencode auth file
    local opencode_auth=$(get_opencode_auth)   
    if [ -n "$opencode_auth" ]; then
        # Create directory and file in container
        ssh $ssh_config_option "$CONTAINER_HOST" "mkdir -p /home/dev/.local/share/opencode"
        echo "$opencode_auth" | ssh $ssh_config_option "$CONTAINER_HOST" "cat > /home/dev/.local/share/opencode/auth.json"
        echo "✓ opencode auth.json pushed"
    else
        echo "⚠ opencode auth.json not found, skipping"
    fi
}



setup_port_forwarding() {
    echo "Setting up port forwarding tunnels..."
    
    if [ -n "$TEMP_SSH_CONFIG" ]; then
        echo "✓ Port forwarding will be handled by existing processes"
    else
        echo "✓ Port forwarding will be established via SSH config"
    fi
    
    echo "  Access your apps at:"
    echo "    - http:localhost:8984"
    echo "    - http:localhost:8985"
    echo "    - http:localhost:8002"
    echo "    - http:localhost:8001"
    echo "    - http:localhost:8000"
    echo "    - http:localhost:5173"
}




enter_container() {
    echo "Entering dev container..."
    
    ensure_ssh_key_loaded
    
    # Check ports FIRST before any SSH connections
    if check_ports_occupied; then
        echo "⚠️  Ports are already in use, creating temporary SSH config without forwarding"
        create_temp_ssh_config
    fi
    
    setup_container_config
    setup_port_forwarding
    
    echo "Connecting to dev container..."
    
    # Set up cleanup trap
    trap 'cleanup_temp_ssh_config; cleanup_container' EXIT
    
    # Determine which SSH config to use
    local ssh_config_option=""
    if [ -n "$TEMP_SSH_CONFIG" ]; then
        ssh_config_option="-F $TEMP_SSH_CONFIG"
        echo "Establishing connection without port forwarding (ports already in use)..."
    else
        echo "Establishing connection with port forwarding..."
    fi
    
    # Set DISPLAY variable for X11 forwarding
    DISPLAY=:0 ssh -Y $ssh_config_option "$CONTAINER_HOST"
    
    # Cleanup will run automatically when SSH exits due to trap
}

cleanup_container() {
    # Only cleanup container config if this is the last devx instance
    # Count only bash processes running devx.sh, excluding the current process
    local devx_count=$(pgrep -f "bash.*devx.sh" | grep -v "^$$" | wc -l)
    
    if [ "$devx_count" -eq 0 ]; then
        echo "Cleaning up container git config (last instance)..."
        
        # For cleanup, always try to normal SSH config first since that's what
        # likely created the port forwards. Fall back to temp config if needed.
        if ssh "$CONTAINER_HOST" "rm -f /home/dev/.gitconfig /home/dev/.wakatime.cfg /home/dev/.local/share/opencode/auth.json" 2>/dev/null; then
            echo "✓ Cleanup completed"
        elif [ -n "$TEMP_SSH_CONFIG" ] && ssh -F "$TEMP_SSH_CONFIG" "$CONTAINER_HOST" "rm -f /home/dev/.gitconfig /home/dev/.wakatime.cfg /home/dev/.local/share/opencode/auth.json" 2>/dev/null; then
            echo "✓ Cleanup completed (using temp config)"
        else
            echo "⚠️  Could not connect for cleanup (ports may still be in use)"
            echo "   Config files will be cleaned up on next run"
        fi
    else
        echo "ℹ️  Keeping container config (other devx instances still running: $devx_count)"
    fi
}

# Main execution
enter_container
