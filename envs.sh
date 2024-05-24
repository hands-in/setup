#!/bin/bash

# Set up environment variables system-wide
sudo tee /etc/profile.d/hands-in-envs.sh > /dev/null << 'EOF'
export OP_CONFIG_DIR="/config/op"
export OP_ACCOUNT="handsin.1password.com"
export GH_PACKAGE_TOKEN="op://development/github/GH_PACKAGE_TOKEN"
EOF

echo "Environment variables set up system-wide."
