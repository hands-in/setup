#!/bin/bash

# URL of the .bashrc file in the public Git repository
BASHRC_URL="https://raw.githubusercontent.com/hands-in/setup/main/.bashrc"

# Backup existing .bashrc file if it exists
if [ -f "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc file..."
    cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

# Download .bashrc from the repository
echo "Downloading .bashrc from Hands In GitHub..."
curl -fsSL "$BASHRC_URL" >> "$HOME/.bashrc"
source "$HOME/.bashrc"

echo "Hands In Bashrc Installation complete."
