#!/bin/bash

# Container SSH script with proper git signing setup
# Usage: ./dev.sh

CONTAINER_HOST="dev-container"

get_ssh_public_key() {
    # Extract the actual SSH public key from your key
    ssh-keygen -y -f "$HOME/.ssh/id_ed25519"
}

get_git_config_value() {
    local key="$1"
    git config --global --get "$key" 2>/dev/null || echo ""
}

setup_container_gitconfig() {
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

    scp "$temp_gitconfig" "$CONTAINER_HOST":/home/dev/.gitconfig
    rm -f "$temp_gitconfig"

    echo "✓ Container git config done"
    # Copy wakatime config file
    scp "$HOME/.wakatime.cfg" "$CONTAINER_HOST":/home/dev/.wakatime.cfg
    echo "✓ Container wakatime config done"
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
    ssh "$CONTAINER_HOST" "rm -f /home/dev/.wakatime.cfg"
    echo "✓ Cleanup completed"
}

# Main execution
enter_container

