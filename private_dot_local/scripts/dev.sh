#!/bin/bash

# Container SSH script with proper git signing setup
# Usage: ./dev.sh

CONTAINER_HOST="dev-container"

get_ssh_public_key() {
    # Extract the actual SSH public key from your key
    ssh-keygen -y -f "$HOME/.ssh/id_ed25519"
}

setup_container_gitconfig() {
    echo "Setting up git config for container environment..."
    
    local ssh_key=$(get_ssh_public_key)
    local temp_gitconfig=$(mktemp)
    
    cat > "$temp_gitconfig" << EOF
[user]
  name = Giygas
  email = gustavorossich@gmail.com
  useConfigOnly = true
  signingkey = $ssh_key
[github]
  user = Giygas
[commit]
  gpgsign = true
[gpg]
  format = ssh
  sshprogram = ssh
[init]
  defaultBranch = main
EOF

    scp "$temp_gitconfig" "$CONTAINER_HOST":/home/dev/.gitconfig
    rm -f "$temp_gitconfig"
    echo "✓ Container git config configured"
}

enter_container() {
    echo "Entering dev container..."
    trap "cleanup_container" EXIT
    setup_container_gitconfig
    ssh "$CONTAINER_HOST"
}

cleanup_container() {
    echo "Cleaning up container git config..."
    ssh "$CONTAINER_HOST" "rm -f /home/dev/.gitconfig"
    echo "✓ Cleanup completed"
}

# Main execution
enter_container

