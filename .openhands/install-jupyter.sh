
#!/bin/bash

# Jupyter Installation Script for gita-tools data-prep project
# This script installs JupyterLab in the data-prep project using uv

echo "Installing JupyterLab in data-prep project..."

# Navigate to the data-prep directory
cd /workspace/gita-tools/data-prep

# Check if uv is available
if ! command -v uv &> /dev/null; then
    echo "Error: uv is not installed or not in PATH"
    exit 1
fi

# Install JupyterLab using uv
echo "Adding JupyterLab dependency..."
uv add jupyterlab

if [ $? -eq 0 ]; then
    echo "JupyterLab installed successfully!"
    echo ""
    echo "To start JupyterLab:"
    echo "1. Source the environment to access gita data:"
    echo "   source /workspace/gita-tools/.openhands/env.sh"
    echo ""
    echo "2. Navigate to data-prep directory:"
    echo "   cd /workspace/gita-tools/data-prep"
    echo ""
    echo "3. Start JupyterLab (no token/password required):"
    echo "   uv run jupyter lab --ip=0.0.0.0 --port=50809 --no-browser --allow-root --ServerApp.token='' --ServerApp.password=''"
    echo ""
    echo "4. Access JupyterLab at: http://localhost:50809/lab"
else
    echo "Failed to install JupyterLab"
    exit 1
fi

