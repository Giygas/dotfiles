#!/bin/bash

# Universal Android Emulator Launcher
# Works on both macOS and Linux with X11 forwarding
# Usage: ./launch-android-emulator.sh [avd_name]

set -e

echo "🚀 Launching Android emulator..."

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
        export ANDROID_AVD_HOME="$HOME/.android/avd"
    else
        export ANDROID_SDK_ROOT="$HOME/Android/sdk"
        export ANDROID_HOME="$ANDROID_SDK_ROOT"
        export ANDROID_AVD_HOME="$HOME/.android/avd"
    fi
    
    export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
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

# Check if emulator exists
check_emulator() {
    if [ ! -f "$ANDROID_HOME/emulator/emulator" ]; then
        print_error "Android emulator not found!"
        print_error "Run ~/.local/scripts/mobile/install-mobile-dev.sh first"
        exit 1
    fi
    print_success "Found Android emulator"
}

# List available AVDs
list_avds() {
    print_status "Available Android Virtual Devices:"
    "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" list avd
}

# Launch emulator
launch_emulator() {
    local avd_name=${1:-"pixel_4_api_34"}
    
    # Check if AVD exists
    if ! "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" list avd | grep -q "$avd_name"; then
        print_error "Android Virtual Device '$avd_name' not found!"
        print_status "Available AVDs:"
        list_avds
        exit 1
    fi
    
    print_success "Launching AVD: $avd_name"
    
    # Set emulator options based on OS
    EMULATOR_OPTS=()
    EMULATOR_OPTS+=("-avd" "$avd_name")
    EMULATOR_OPTS+=("-no-snapshot")
    EMULATOR_OPTS+=("-no-audio")
    
    if [ "$OS" = "linux" ]; then
        # Linux with X11 forwarding optimizations
        EMULATOR_OPTS+=("-no-boot-anim")
        EMULATOR_OPTS+=("-gpu" "swiftshader_indirect")
        EMULATOR_OPTS+=("-scale" "0.7")
        EMULATOR_OPTS+=("-dpi-device" "160")
        EMULATOR_OPTS+=("-memory" "2048")
        EMULATOR_OPTS+=("-cores" "2")
        print_warning "Launching with X11 forwarding optimizations..."
    else
        # macOS optimizations
        EMULATOR_OPTS+=("-gpu" "host")
        EMULATOR_OPTS+=("-memory" "4096")
        EMULATOR_OPTS+=("-cores" "4")
    fi
    
    print_status "Starting emulator with options: ${EMULATOR_OPTS[*]}"
    print_warning "This may take a few minutes to boot..."
    
    # Launch emulator
    "$ANDROID_HOME/emulator/emulator" "${EMULATOR_OPTS[@]}"
    
    print_success "Emulator launched successfully!"
    
    if [ "$OS" = "linux" ]; then
        print_status "The emulator window should appear on your remote display"
        print_warning "If you don't see the emulator, check:"
        print_warning "  1. XQuartz is running (on macOS)"
        print_warning "  2. You connected with 'ssh -X user@host'"
        print_warning "  3. No firewall blocking X11 connections"
    else
        print_status "The emulator window should appear on your macOS desktop"
    fi
}

# Show help
show_help() {
    echo "Usage: $0 [AVD_NAME]"
    echo ""
    echo "Launches Android emulator with platform-specific optimizations."
    echo ""
    echo "Arguments:"
    echo "  AVD_NAME    Name of the Android Virtual Device (default: pixel_4_api_34)"
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message"
    echo "  -l, --list  List available AVDs"
    echo ""
    echo "Examples:"
    echo "  $0                    # Launch default AVD"
    echo "  $0 pixel_6_api_34     # Launch specific AVD"
    echo "  $0 --list             # List available AVDs"
}

# Main execution
main() {
    setup_android_paths
    
    # Parse arguments
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        -l|--list)
            list_avds
            exit 0
            ;;
        "")
            # No arguments, use default AVD
            ;;
        *)
            # Use provided AVD name
            ;;
    esac
    
    check_x11
    check_emulator
    launch_emulator "$@"
}

main "$@"