#!/bin/bash

# Quick start script for JupyterLab in the data-prep project
# This script sources the environment and starts JupyterLab with the correct configuration

echo "Starting JupyterLab for gita-tools data exploration..."

# Source the environment to access gita data
source /workspace/gita-tools/.openhands/env.sh

# Navigate to data-prep directory
cd /workspace/gita-tools/data-prep

# Check if JupyterLab is installed
if ! uv run jupyter --version > /dev/null 2>&1; then
    echo "JupyterLab not found. Installing..."
    /workspace/gita-tools/.openhands/install-jupyter.sh
fi

echo "Starting JupyterLab on port 50809..."
echo "Access at: http://localhost:50809/lab"
echo "Press Ctrl+C to stop the server"
echo ""

# Start JupyterLab (no token/password required)
uv run jupyter lab --ip=0.0.0.0 --port=50809 --no-browser --allow-root --ServerApp.token='' --ServerApp.password=''
