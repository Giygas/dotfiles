#!/bin/bash
# Simple X11 connection script
# Usage: ./connect-x11.sh

echo "🖥️  Connecting to dev container with X11 forwarding..."
echo ""
echo "📋 Make sure you have:"
echo "   1. Installed XQuartz: brew install --cask xquartz"
echo "   2. Enabled 'Allow connections from network clients' in XQuartz preferences"
echo "   3. Restarted XQuartz after enabling network connections"
echo ""

# Connect with X11 forwarding
ssh -X dev@localhost -p 2222