#!/bin/bash

# Universal Android Studio Launcher
# Works on both macOS and Linux with X11 forwarding
# Usage: ./start-android-studio.sh

set -e

echo "🎯 Launching Android Studio..."

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

# Set Android SDK paths based on OS
setup_android_paths() {
    if [ "$OS" = "macos" ]; then
        export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
        export ANDROID_HOME="$ANDROID_SDK_ROOT"
    else
        export ANDROID_SDK_ROOT="$HOME/Android/sdk"
        export ANDROID_HOME="$ANDROID_SDK_ROOT"
    fi
    
    export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
}

# Check X11 forwarding on Linux
check_x11() {
    if [ "$OS" = "linux" ]; then
        if [ -z "$DISPLAY" ]; then
            print_error "DISPLAY environment variable not set!"
            print_error "Connect with X11 forwarding: ssh -X user@host"
            exit 1
        fi
        print_status "Using DISPLAY: $DISPLAY"
    fi
}

# Check if Android Studio is installed
check_android_studio() {
    if [ "$OS" = "macos" ]; then
        if [ ! -d "/Applications/Android Studio.app" ]; then
            print_error "Android Studio not found!"
            print_error "Install with: brew install --cask android-studio"
            print_error "Or run: ~/.local/scripts/mobile/install-mobile-dev.sh"
            exit 1
        fi
        print_success "Found Android Studio in /Applications"
    else
        if [ ! -f "/opt/android-studio/bin/studio.sh" ]; then
            print_error "Android Studio not found!"
            print_error "Run ~/.local/scripts/mobile/install-mobile-dev.sh first"
            exit 1
        fi
        print_success "Found Android Studio in /opt/android-studio"
    fi
}

# Launch Android Studio
launch_android_studio() {
    print_status "Starting Android Studio..."
    print_warning "This may take a moment to initialize..."
    
    if [ "$OS" = "macos" ]; then
        # Launch Android Studio on macOS
        open -a "Android Studio"
        print_success "Android Studio launched on macOS"
    else
        # Set environment variables for X11 forwarding
        export DISPLAY="$DISPLAY"
        export XAUTHORITY="$XAUTHORITY"
        
        # Set Java environment
        export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
        
        # Set performance optimizations for remote display
        export _JAVA_AWT_WM_NONREPARENTING=1
        export SWT_GTK3=0
        
        # Launch Android Studio on Linux
        /opt/android-studio/bin/studio.sh
        
        print_success "Android Studio launched with X11 forwarding"
        print_status "The Android Studio window should appear on your macOS display"
    fi
}

# Show help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Launches Android Studio with platform-specific optimizations."
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message"
    echo ""
    echo "On macOS: Launches Android Studio normally"
    echo "On Linux: Launches Android Studio with X11 forwarding"
}

# Main execution
main() {
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        "")
            # No arguments, launch Android Studio
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
    
    setup_android_paths
    check_x11
    check_android_studio
    launch_android_studio
}

main "$@"