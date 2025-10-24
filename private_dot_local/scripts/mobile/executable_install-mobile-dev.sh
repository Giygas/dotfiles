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
        libasound2t64 \
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
    
    AVD_NAME="pixel_6_api_36"
    
    if ! "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" list avd | grep -q "$AVD_NAME"; then
        echo "no" | "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" create avd \
            -n "$AVD_NAME" \
            -k "system-images;android-34;google_apis;x86_64" \
            -d "pixel_6" \
            --force
        print_success "Created AVD: $AVD_NAME"
    else
        print_success "AVD '$AVD_NAME' already exists"
    fi
}

# Verify SSH X11 configuration
verify_ssh_x11() {
    if [ "$OS" = "linux" ]; then
        print_status "Verifying SSH X11 configuration..."
        
        # Check SSH config
        local x11_forwarding=$(grep "^X11Forwarding" /etc/ssh/sshd_config 2>/dev/null || echo "not found")
        local x11_offset=$(grep "^X11DisplayOffset" /etc/ssh/sshd_config 2>/dev/null || echo "not found")
        local x11_localhost=$(grep "^X11UseLocalhost" /etc/ssh/sshd_config 2>/dev/null || echo "not found")
        
        print_status "SSH X11 settings:"
        echo "  X11Forwarding: $x11_forwarding"
        echo "  X11DisplayOffset: $x11_offset"
        echo "  X11UseLocalhost: $x11_localhost"
        
        if [[ "$x11_forwarding" == *"yes"* ]]; then
            print_success "SSH X11 forwarding is enabled"
        else
            print_warning "SSH X11 forwarding may not be properly configured"
        fi
    fi
}

# Configure X11 for Linux
configure_x11() {
    if [ "$OS" = "linux" ]; then
        print_status "Configuring X11 environment..."
        
        # Set up user environment variables with proper X11 authority handling
        cat >> ~/.bashrc << 'EOF'

# X11 Forwarding Setup
export XAUTHORITY=~/.Xauthority
if [ -n "$DISPLAY" ] && [ ! -f "$XAUTHORITY" ]; then
    touch "$XAUTHORITY"
    chmod 600 "$XAUTHORITY"
fi

# Function to set up X11 authority when needed
setup_x11_auth() {
    if [ -n "$DISPLAY" ] && command -v xauth >/dev/null 2>&1; then
        # Extract display info for xauth
        local display_info=$(echo $DISPLAY | sed "s/localhost://" | cut -d: -f2)
        if [ -n "$display_info" ]; then
            # Try to get the cookie from SSH environment
            if [ -n "$SSH_AUTH_SOCK" ]; then
                # This will be set by SSH when connecting with -X
                echo "X11 forwarding detected - setting up authority"
            fi
        fi
    fi
}

# Run X11 setup on shell startup
setup_x11_auth
EOF

        cat >> ~/.zshrc << 'EOF'

# X11 Forwarding Setup
export XAUTHORITY=~/.Xauthority
if [ -n "$DISPLAY" ] && [ ! -f "$XAUTHORITY" ]; then
    touch "$XAUTHORITY"
    chmod 600 "$XAUTHORITY"
fi

# Function to set up X11 authority when needed
setup_x11_auth() {
    if [ -n "$DISPLAY" ] && command -v xauth >/dev/null 2>&1; then
        # Extract display info for xauth
        local display_info=$(echo $DISPLAY | sed "s/localhost://" | cut -d: -f2)
        if [ -n "$display_info" ]; then
            # Try to get the cookie from SSH environment
            if [ -n "$SSH_AUTH_SOCK" ]; then
                # This will be set by SSH when connecting with -X
                echo "X11 forwarding detected - setting up authority"
            fi
        fi
    fi
}

# Run X11 setup on shell startup
setup_x11_auth
EOF
        
        # Configure SSH daemon for X11 forwarding
        print_status "Configuring SSH daemon for X11 forwarding..."
        
        # Enable X11 forwarding in SSH config
        sudo sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config || true
        sudo sed -i 's/#X11Forwarding yes/X11Forwarding yes/' /etc/ssh/sshd_config || true
        sudo sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config || true
        
        sudo sed -i 's/#X11DisplayOffset 10/X11DisplayOffset 10/' /etc/ssh/sshd_config || true
        sudo sed -i 's/X11DisplayOffset 10/X11DisplayOffset 10/' /etc/ssh/sshd_config || true
        
        sudo sed -i 's/#X11UseLocalhost yes/X11UseLocalhost yes/' /etc/ssh/sshd_config || true
        sudo sed -i 's/X11UseLocalhost no/X11UseLocalhost yes/' /etc/ssh/sshd_config || true
        
        # Restart SSH service to apply changes
        print_status "Restarting SSH service..."
        if command -v systemctl >/dev/null 2>&1 && [ -d /run/systemd/system ]; then
            sudo systemctl restart sshd
        elif command -v service >/dev/null 2>&1; then
            sudo service ssh restart
        elif command -v /etc/init.d/ssh >/dev/null 2>&1; then
            sudo /etc/init.d/ssh restart
        else
            print_warning "Could not restart SSH service automatically"
            print_warning "You may need to restart it manually"
            print_warning "Try: sudo service ssh restart or sudo /etc/init.d/ssh restart"
        fi
        
        print_success "SSH X11 forwarding configured"
        
        # Verify configuration
        verify_ssh_x11
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
        echo "  1. On Mac, run X11 setup: ~/.local/scripts/mobile/setup_X11_mac.sh"
        echo "  2. Connect with X11: ssh -X user@host"
        echo "  3. Test X11 forwarding: ssh -X user@host 'echo \$DISPLAY'"
        echo "  4. Test with X11 app: ssh -X user@host 'xclock'"
        echo "  5. Launch emulator: ~/.local/scripts/mobile/launch-android-emulator.sh"
    else
        echo "  1. Launch Android Studio from Applications"
        echo "  2. Or launch emulator: ~/.local/scripts/mobile/launch-android-emulator.sh"
    fi
    
    if command -v pnpm &> /dev/null; then
        echo "  6. Create project: pnpm create expo my-app"
    else
        echo "  6. Create project: npx create-expo-app my-app"
    fi
}

main "$@"
