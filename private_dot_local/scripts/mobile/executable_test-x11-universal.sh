#!/bin/bash

# Universal X11 Forwarding Test
# Tests X11 forwarding on Linux, reports status on macOS
# Usage: ./test-x11-universal.sh

set -e

echo "🧪 Testing X11 forwarding configuration..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
print_status "Detected OS: $OS"

# macOS specific tests
test_macos() {
    print_status "macOS detected - X11 forwarding not needed for local display"
    print_status "Checking Android Studio installation..."
    
    if [ -d "/Applications/Android Studio.app" ]; then
        print_success "Android Studio is installed"
    else
        print_warning "Android Studio not found in /Applications"
        print_status "Install with: brew install --cask android-studio"
    fi
    
    print_status "Checking Android SDK..."
    if [ -d "$HOME/Library/Android/sdk" ]; then
        print_success "Android SDK found at $HOME/Library/Android/sdk"
    else
        print_warning "Android SDK not found"
        print_status "Run install script first: ~/.local/scripts/mobile/install-mobile-dev.sh"
    fi
    
    print_success "✅ macOS environment check completed"
    print_status "You can run Android emulator locally without X11 forwarding"
}

# Linux specific tests
test_linux() {
    print_status "Linux detected - testing X11 forwarding..."
    
    # Check if DISPLAY is set
    if [ -z "$DISPLAY" ]; then
        print_error "DISPLAY environment variable not set!"
        print_error "Connect with X11 forwarding: ssh -X user@host"
        exit 1
    else
        print_success "DISPLAY is set to: $DISPLAY"
    fi
    
    # Check if X11 applications are available
    if command -v xeyes &> /dev/null; then
        print_success "X11 applications are installed"
    else
        print_error "X11 applications not found!"
        print_error "Run install script first: ~/.local/scripts/mobile/install-mobile-dev.sh"
        exit 1
    fi
    
    # Test basic X11 functionality
    print_status "Testing X11 display connection..."
    if xset q &> /dev/null; then
        print_success "X11 display connection is working"
    else
        print_error "Cannot connect to X11 display!"
        print_error "Check XQuartz is running on your macOS host"
        exit 1
    fi
    
    # Test with a simple X11 application
    print_status "Launching test application (xeyes)..."
    print_warning "A window with eyes should appear on your macOS screen"
    print_warning "Close the window to continue..."
    
    xeyes &
    XEYES_PID=$!
    
    # Wait a bit for the window to appear
    sleep 3
    
    # Check if the process is still running
    if kill -0 $XEYES_PID 2>/dev/null; then
        print_success "X11 application launched successfully!"
        print_status "Window should be visible on your macOS desktop"
        
        # Clean up
        kill $XEYES_PID 2>/dev/null
        wait $XEYES_PID 2>/dev/null
    else
        print_error "X11 application failed to launch!"
        print_error "Check XQuartz settings and SSH connection"
        exit 1
    fi
    
    # Check Android emulator
    print_status "Checking Android emulator..."
    ANDROID_HOME="$HOME/Android/sdk"
    if [ -f "$ANDROID_HOME/emulator/emulator" ]; then
        print_success "Android emulator is installed"
    else
        print_warning "Android emulator not found"
        print_status "Run install script first: ~/.local/scripts/mobile/install-mobile-dev.sh"
    fi
    
    print_success "✅ X11 forwarding is working correctly!"
}

# Show help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Tests X11 forwarding configuration and mobile development setup."
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message"
    echo ""
    echo "On macOS: Checks Android Studio and SDK installation"
    echo "On Linux: Tests X11 forwarding and Android emulator setup"
}

# Main execution
main() {
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        "")
            # No arguments, run tests
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
    
    if [ "$OS" = "macos" ]; then
        test_macos
    elif [ "$OS" = "linux" ]; then
        test_linux
    else
        print_error "Unsupported OS: $OS"
        exit 1
    fi
    
    echo ""
    echo "🎯 Next steps:"
    echo "  ~/.local/scripts/mobile/launch-android-emulator.sh    # Launch emulator"
    echo "  ~/.local/scripts/mobile/start-android-studio.sh       # Launch Android Studio"
}

main "$@"