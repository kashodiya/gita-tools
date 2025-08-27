#!/bin/bash

# Setup script for gita-tools repository
# This script runs automatically when OpenHands starts working with the repository

echo "Setting up gita-tools environment..."

# Create a temp directory for cloning the gita repository
TEMP_DIR="/tmp/gita-repo"

# Remove existing temp directory if it exists
if [ -d "$TEMP_DIR" ]; then
    echo "Removing existing temp directory..."
    rm -rf "$TEMP_DIR"
fi

# Clone the gita repository to get data files
echo "Cloning gita repository for data files..."
git clone https://github.com/gita/gita.git "$TEMP_DIR"

if [ $? -eq 0 ]; then
    echo "Successfully cloned gita repository to $TEMP_DIR"
    echo "Data files are available at: $TEMP_DIR"
    
    # List the contents to show what's available
    echo "Available files and directories:"
    ls -la "$TEMP_DIR"
else
    echo "Failed to clone gita repository"
    exit 1
fi

# Set environment variable for easy access to the data files
export GITA_DATA_PATH="$TEMP_DIR"
echo "Environment variable GITA_DATA_PATH set to: $GITA_DATA_PATH"

# Create a source-able environment file for persistent access
ENV_FILE="/workspace/gita-tools/.openhands/env.sh"
echo "#!/bin/bash" > "$ENV_FILE"
echo "export GITA_DATA_PATH=\"$TEMP_DIR\"" >> "$ENV_FILE"
chmod +x "$ENV_FILE"
echo "Created environment file at: $ENV_FILE"
echo "To use in other sessions, run: source $ENV_FILE"

# Optional: Install JupyterLab for data exploration
# Uncomment the following line if you want to automatically install JupyterLab
# /workspace/gita-tools/.openhands/install-jupyter.sh

echo "Setup completed successfully!"
echo ""
echo "Optional: To install JupyterLab for data exploration, run:"
echo "  /workspace/gita-tools/.openhands/install-jupyter.sh"
