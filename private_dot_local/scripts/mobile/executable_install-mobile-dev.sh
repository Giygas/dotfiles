#!/bin/bash

# Universal Mobile Development Environment Setup
# Works on both macOS and Linux containers
# Usage: ./install-mobile-dev.sh

set -e

echo "📱 Installing mobile development environment..."

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
    
    # Create directories
    mkdir -p "$ANDROID_SDK_ROOT"
    mkdir -p "$(dirname "$ANDROID_AVD_HOME")"
    
    print_status "Android SDK path: $ANDROID_SDK_ROOT"
}

# Function to check if a package is already installed
check_package() {
    local package=$1
    if command -v $package &> /dev/null; then
        echo "✅ $package is already installed"
        return 0
    else
        return 1
    fi
}

# Determine package manager
setup_package_manager() {
    if command -v pnpm &> /dev/null; then
        PKG_MANAGER="pnpm"
        PKG_INSTALL="pnpm add -g"
        echo "Using pnpm for installation..."
    elif command -v npm &> /dev/null; then
        PKG_MANAGER="npm"
        PKG_INSTALL="npm install -g"
        echo "Using npm for installation..."
    elif command -v brew &> /dev/null; then
        PKG_MANAGER="brew"
        echo "Using Homebrew for system packages..."
    else
        print_error "No supported package manager found (npm, pnpm, brew)"
        exit 1
    fi
}

# Install Node.js packages
install_node_packages() {
    print_status "Installing Node.js mobile development packages..."
    
    PACKAGES=(
        "@expo/cli:expo"
        "eas-cli:eas"
        "react-native-cli:react-native"
        "@react-native-community/cli:react-native"
        "typescript:tsc"
        "ts-node:ts-node"
        "nodemon:nodemon"
    )

    for package_info in "${PACKAGES[@]}"; do
        package_name=$(echo $package_info | cut -d: -f1)
        command_name=$(echo $package_info | cut -d: -f2)
        
        if ! check_package $command_name; then
            echo "Installing $package_name..."
            $PKG_INSTALL $package_name
        fi
    done
}

# macOS specific setup
setup_macos() {
    print_status "Setting up mobile development on macOS..."
    
    # Install Java if not present
    if ! command -v java &> /dev/null; then
        print_status "Installing Java..."
        brew install openjdk@17
        echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17' >> ~/.zshrc
        echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17' >> ~/.bashrc
    fi
    
    # Install Android Studio if not present
    if [ ! -d "/Applications/Android Studio.app" ]; then
        print_status "Installing Android Studio..."
        brew install --cask android-studio
    fi
    
    # Install Android command line tools
    if [ ! -d "$ANDROID_SDK_ROOT/cmdline-tools" ]; then
        print_status "Installing Android command line tools..."
        cd /tmp
        wget -q https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip
        unzip -q commandlinetools-mac-*.zip
        mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools/latest"
        mv cmdline-tools/* "$ANDROID_SDK_ROOT/cmdline-tools/latest/"
        rm commandlinetools-mac-*.zip
        cd ~
    fi
}

# Linux specific setup
setup_linux() {
    print_status "Setting up mobile development on Linux..."
    
    # Update package lists
    sudo apt-get update
    
    # Install system dependencies
    print_status "Installing system dependencies..."
    sudo apt-get install -y --no-install-recommends \
        curl \
        wget \
        unzip \
        openjdk-17-jdk \
        python3 \
        python3-pip \
        git
    
    # Install X11 dependencies for emulator display
    print_status "Installing X11 dependencies..."
    sudo apt-get install -y --no-install-recommends \
        x11-apps \
        xorg \
        openbox \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
        libxrandr2 \
        libxinerama1 \
        libxcursor1 \
        libxdamage1 \
        libxfixes3 \
        libxcomposite1 \
        libasound2 \
        libpangocairo-1.0-0 \
        libatk1.0-0 \
        libcairo-gobject2 \
        libgtk-3-0 \
        libgdk-pixbuf2.0-0
    
    # Install Android Studio
    if [ ! -d "/opt/android-studio" ]; then
        print_status "Installing Android Studio..."
        cd /tmp
        wget -q https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.3.1.18/android-studio-2023.3.1.18-linux.tar.gz
        sudo tar -xzf android-studio-*.tar.gz -C /opt/
        rm android-studio-*.tar.gz
        cd ~
    fi
    
    # Install Android command line tools
    if [ ! -d "$ANDROID_SDK_ROOT/cmdline-tools" ]; then
        print_status "Installing Android command line tools..."
        cd /tmp
        wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
        unzip -q commandlinetools-linux-*.zip
        mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools/latest"
        mv cmdline-tools/* "$ANDROID_SDK_ROOT/cmdline-tools/latest/"
        rm commandlinetools-linux-*.zip
        cd ~
    fi
}

# Setup Android SDK components
setup_android_sdk() {
    print_status "Setting up Android SDK components..."
    
    # Set environment variables
    if [ "$OS" = "macos" ]; then
        echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.zshrc
        echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.zshrc
        
        echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
        echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.bashrc
        
        export JAVA_HOME=/opt/homebrew/opt/openjdk@17
    else
        echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
        echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.bashrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.bashrc
        
        echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.zshrc
        echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.zshrc
        echo "export PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.zshrc
        
        export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
    fi
    
    export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
    
    # Install Android SDK components
    print_status "Installing Android SDK components..."
    yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" \
        "platform-tools" \
        "platforms;android-34" \
        "build-tools;34.0.0" \
        "emulator" \
        "system-images;android-34;google_apis;x86_64" \
        "system-images;android-34;google_apis_playstore;x86_64"
    
    # Accept licenses
    print_status "Accepting Android SDK licenses..."
    yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --licenses
}

# Create Android Virtual Device
create_avd() {
    print_status "Creating Android Virtual Device..."
    
    AVD_NAME="pixel_4_api_34"
    
    if ! "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" list avd | grep -q "$AVD_NAME"; then
        echo "no" | "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" create avd \
            -n "$AVD_NAME" \
            -k "system-images;android-34;google_apis;x86_64" \
            -d "pixel_4" \
            --force
        print_success "Created AVD: $AVD_NAME"
    else
        print_success "AVD '$AVD_NAME' already exists"
    fi
}

# Configure X11 for Linux
configure_x11() {
    if [ "$OS" = "linux" ]; then
        print_status "Configuring X11 environment..."
        echo 'export DISPLAY=$DISPLAY' >> ~/.bashrc
        echo 'export XAUTHORITY=$XAUTHORITY' >> ~/.bashrc
        echo 'export DISPLAY=$DISPLAY' >> ~/.zshrc
        echo 'export XAUTHORITY=$XAUTHORITY' >> ~/.zshrc
    fi
}

# Main installation flow
main() {
    setup_android_paths
    setup_package_manager
    install_node_packages
    
    if [ "$OS" = "macos" ]; then
        setup_macos
    elif [ "$OS" = "linux" ]; then
        setup_linux
    fi
    
    setup_android_sdk
    create_avd
    configure_x11
    
    print_success "✅ Mobile development environment installed!"
    print_warning "⚠️  Restart your shell or run 'source ~/.bashrc' (or ~/.zshrc)"
    
    echo ""
    echo "🎯 Next steps:"
    if [ "$OS" = "linux" ]; then
        echo "  1. On Mac, install XQuartz: brew install --cask xquartz"
        echo "  2. Connect with X11: ssh -X user@host"
        echo "  3. Test X11: ~/.local/scripts/mobile/test-x11.sh"
        echo "  4. Launch emulator: ~/.local/scripts/mobile/launch-android-emulator.sh"
    else
        echo "  1. Launch Android Studio from Applications"
        echo "  2. Or launch emulator: ~/.local/scripts/mobile/launch-android-emulator.sh"
    fi
    
    if command -v pnpm &> /dev/null; then
        echo "  5. Create project: pnpm create expo my-app"
    else
        echo "  5. Create project: npx create-expo-app my-app"
    fi
}

main "$@"