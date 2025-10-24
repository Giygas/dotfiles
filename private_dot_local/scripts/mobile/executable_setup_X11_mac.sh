#!/bin/bash
# X11 Setup Script for macOS
# This script sets up XQuartz and configures it for X11 forwarding

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
XQUARTZ_APP="/Applications/Utilities/XQuartz.app"
X11_BIN_PATH="/opt/X11/bin"
SSH_CONFIG="$HOME/.ssh/config"

# Extract Windows IP from SSH config or use default
extract_windows_ip() {
    if [[ -f "$SSH_CONFIG" ]]; then
        local ip=$(grep -A 10 "Host dev-container" "$SSH_CONFIG" | grep "HostName" | awk '{print $2}' | head -1)
        if [[ -n "$ip" ]]; then
            echo "$ip"
            return 0
        fi
    fi
    echo "192.168.1.10"  # Default fallback
}

WINDOWS_IP="${1:-$(extract_windows_ip)}"  # Allow override as first argument

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Homebrew is installed
check_homebrew() {
    if ! command_exists brew; then
        log_error "Homebrew is not installed. Please install it first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    log_success "Homebrew is installed"
}

# Install XQuartz if not present
install_xquartz() {
    if [[ -d "$XQUARTZ_APP" ]]; then
        log_success "XQuartz is already installed"
        return 0
    fi

    log_info "Installing XQuartz..."
    if brew install --cask xquartz; then
        log_success "XQuartz installed successfully"
    else
        log_error "Failed to install XQuartz"
        exit 1
    fi
}

# Start XQuartz
start_xquartz() {
    log_info "Starting XQuartz..."
    
    # Check if XQuartz is already running
    if pgrep -f "Xquartz" > /dev/null; then
        log_success "XQuartz is already running"
        setup_display_environment
        return 0
    fi

    # Start XQuartz
    open -a XQuartz
    
    # Wait for XQuartz to start and set up DISPLAY
    local max_attempts=30
    local attempt=1
    
    while [[ $attempt -le $max_attempts ]]; do
        if pgrep -f "Xquartz" > /dev/null; then
            log_success "XQuartz started successfully"
            setup_display_environment
            return 0
        fi
        
        log_info "Waiting for XQuartz to start... (attempt $attempt/$max_attempts)"
        sleep 2
        ((attempt++))
    done
    
    log_error "XQuartz failed to start within expected time"
    exit 1
}

# Setup DISPLAY environment variable
setup_display_environment() {
    log_info "Setting up DISPLAY environment..."
    
    # Ensure X11 PATH is available
    export PATH="$X11_BIN_PATH:$PATH"
    
    # Wait for DISPLAY to be available
    local max_attempts=10
    local attempt=1
    
    while [[ $attempt -le $max_attempts ]]; do
        # Try to find the DISPLAY variable
        if [[ -z "${DISPLAY:-}" ]]; then
            # Try the most common XQuartz DISPLAY first
            export DISPLAY=":0"
            
            # If that doesn't work, try other patterns
            if ! xhost >/dev/null 2>&1; then
                # Try socket-based display
                local socket_display=$(find /private/tmp/com.apple.launchd.*/org.macosforge.xquartz:0 2>/dev/null | head -1)
                if [[ -n "$socket_display" ]]; then
                    export DISPLAY="$socket_display"
                fi
            fi
        fi
        
        # Test if DISPLAY works
        if xhost >/dev/null 2>&1; then
            log_success "DISPLAY set to: $DISPLAY"
            return 0
        fi
        
        log_info "Waiting for DISPLAY to be available... (attempt $attempt/$max_attempts)"
        sleep 1
        ((attempt++))
    done
    
    log_warning "Could not set DISPLAY automatically. Setting to :0 as fallback"
    export DISPLAY=":0"
    return 1
}

# Setup X11 PATH in shell profile
setup_x11_path() {
    local shell_profile=""
    local path_export="export PATH=\"$X11_BIN_PATH:\$PATH\""
    
    # Determine shell profile
    if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == */zsh ]]; then
        shell_profile="$HOME/.zshrc"
    elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == */bash ]]; then
        shell_profile="$HOME/.bash_profile"
    else
        log_warning "Unknown shell, please manually add $X11_BIN_PATH to your PATH"
        return 1
    fi

    # Check if PATH is already configured
    if grep -q "$X11_BIN_PATH" "$shell_profile" 2>/dev/null; then
        log_success "X11 PATH already configured in $shell_profile"
    else
        # Add X11 PATH to shell profile
        log_info "Adding X11 PATH to $shell_profile..."
        {
            echo ""
            echo "# XQuartz PATH"
            echo "if [ -d \"$X11_BIN_PATH\" ]; then"
            echo "    $path_export"
            echo "fi"
        } >> "$shell_profile"
        log_success "X11 PATH added to $shell_profile"
    fi

    # Apply PATH changes to current session directly
    log_info "Applying PATH changes to current session..."
    export PATH="$X11_BIN_PATH:$PATH"
    log_success "X11 PATH applied to current session"
}

# Verify xhost command
verify_xhost() {
    log_info "Verifying xhost command..."
    
    # First try to add to current session PATH
    export PATH="$X11_BIN_PATH:$PATH"
    
    if command_exists xhost; then
        log_success "xhost command found at $(which xhost)"
        return 0
    else
        log_error "xhost command not found even after PATH setup"
        return 1
    fi
}

# Configure X11 security
configure_x11_security() {
    log_info "Configuring X11 security for Windows IP: $WINDOWS_IP"
    
    # Ensure X11 PATH is available for this function
    export PATH="$X11_BIN_PATH:$PATH"
    
    # Add Windows IP to xhost access list
    if xhost + "$WINDOWS_IP" 2>/dev/null; then
        log_success "Added $WINDOWS_IP to X11 access control list"
    else
        log_warning "Failed to add $WINDOWS_IP to xhost. You may need to run this manually:"
        echo "   xhost + $WINDOWS_IP"
        echo ""
        log_info "Debugging info:"
        echo "  DISPLAY: ${DISPLAY:-'not set'}"
        echo "  PATH: $PATH"
        echo "  xhost location: $(which xhost 2>/dev/null || echo 'not found')"
    fi

    # Show current access list
    log_info "Current X11 access list:"
    xhost 2>/dev/null || echo "  (unable to access xhost)"
}

# Verify DISPLAY variable
verify_display() {
    log_info "Checking DISPLAY variable..."
    
    if [[ -n "${DISPLAY:-}" ]]; then
        log_success "DISPLAY is set to: $DISPLAY"
    else
        log_warning "DISPLAY is not set. XQuartz may still be starting..."
        log_info "Try running this script again in a few seconds"
    fi
}

# Test X11 forwarding
test_x11() {
    log_info "Testing X11 forwarding..."
    
    # Install xeyes if not present (optional test)
    if command_exists xeyes; then
        log_info "Running xeyes test (close the window to continue)..."
        xeyes &
        local xeyes_pid=$!
        
        # Wait a bit then kill xeyes
        sleep 3
        kill $xeyes_pid 2>/dev/null || true
        log_success "X11 test completed successfully"
    else
        log_info "xeyes not found. Install with: brew install xeyes"
        log_info "Then run 'xeyes' to test X11 forwarding"
    fi
}

# Quick fix function (integrated from fix_display.sh)
quick_display_fix() {
    log_info "Running quick DISPLAY fix..."
    
    # Check if XQuartz is running
    if ! pgrep -f "Xquartz" > /dev/null; then
        log_info "Starting XQuartz..."
        open -a XQuartz
        sleep 3
    fi
    
    # Set DISPLAY and PATH
    export DISPLAY=":0"
    export PATH="$X11_BIN_PATH:$PATH"
    
    log_success "DISPLAY set to: $DISPLAY"
    log_info "You can now run X11 applications or connect to your dev container"
}

# Show next steps
show_next_steps() {
    log_success "X11 setup completed!"
    echo ""
    log_info "Configuration summary:"
    echo "  Windows IP: $WINDOWS_IP"
    echo "  DISPLAY: ${DISPLAY:-'not set'}"
    echo "  X11 PATH: $X11_BIN_PATH"
    echo ""
    log_info "Next steps:"
    echo "1. Connect to your dev container: ~/.local/scripts/dev.sh"
    echo "2. In the container, run mobile dev setup:"
    echo "   ~/.local/scripts/mobile/install-mobile-dev.sh"
    echo "3. Test X11 forwarding in the container:"
    echo "   - ssh -X dev-container 'echo \$DISPLAY'"
    echo "   - ssh -X dev-container 'xclock'"
    echo "   - ~/.local/scripts/mobile/start-android-studio.sh"
    echo ""
    log_info "If DISPLAY issues occur:"
    echo "   - Run: ~/.local/scripts/mobile/setup_X11_mac.sh --fix"
    echo "   - Or manually: export DISPLAY=:0"
    echo ""
    log_info "To allow connections from different IPs:"
    echo "   xhost + <IP_ADDRESS>"
    echo ""
    log_info "To reset X11 security:"
    echo "   xhost -"
}

# Main execution
main() {
    # Handle --fix flag
    if [[ "${1:-}" == "--fix" ]]; then
        quick_display_fix
        return 0
    fi
    
    log_info "Starting X11 setup for macOS..."
    echo ""
    
    # Check if custom Windows IP provided
    if [[ "${1:-}" != "" && "${1:-}" != "--fix" ]]; then
        WINDOWS_IP="$1"
        log_info "Using custom Windows IP: $WINDOWS_IP"
    fi
    
    # Run setup steps
    check_homebrew
    install_xquartz
    start_xquartz
    setup_x11_path
    verify_xhost
    configure_x11_security
    verify_display
    test_x11
    show_next_steps
}

# Handle script arguments
case "${1:-}" in
    -h|--help)
        echo "Usage: $0 [WINDOWS_IP] [--fix]"
        echo ""
        echo "Sets up XQuartz and configures X11 forwarding for development containers."
        echo ""
        echo "Arguments:"
        echo "  WINDOWS_IP    IP address of the Windows machine (default: extracted from SSH config)"
        echo ""
        echo "Options:"
        echo "  -h, --help    Show this help message"
        echo "  --fix         Quick fix for DISPLAY variable issues"
        echo ""
        echo "Examples:"
        echo "  $0                    # Full setup with auto-detected IP"
        echo "  $0 192.168.1.15      # Full setup with custom IP"
        echo "  $0 --fix             # Quick DISPLAY fix only"
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac