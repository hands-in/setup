#!/bin/bash

# URL of the .bashrc file in the public Git repository
BASHRC_URL="https://raw.githubusercontent.com/hands-in/setup/main/.bashrc"
ENVS_URL="https://raw.githubusercontent.com/hands-in/setup/main/envs.sh"

# Backup existing .bashrc file if it exists
if [ -f "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc file..."
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

# Download .bashrc from the repository
echo "Downloading .bashrc from GitHub..."
curl -fsSL "$BASHRC_URL" >> "$HOME/.bashrc"
source "$HOME/.bashrc"

# Set up environment variables system-wide
# sudo tee /etc/profile.d/handsin.sh > /dev/null << 'EOF'
# export OP_ACCOUNT="handsin.1password.com"
# export GH_PACKAGE_TOKEN="op://development/github/GH_PACKAGE_TOKEN"
# export OP_CONFIG_DIR="/config/op"
# EOF

echo "Installation complete."
