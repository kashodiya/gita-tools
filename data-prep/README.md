# Data Prep

A data preparation tool for processing Bhagavad Gita text data from the main gita repository.

## Purpose

This project is designed to:
- Process and clean raw Bhagavad Gita data files
- Transform data into different formats for various use cases
- Validate data integrity and consistency
- Prepare datasets for other tools in the gita-tools monorepo

## Data Source

This project uses data from the main gita repository, which is automatically cloned during setup and available at `$GITA_DATA_PATH/data/`.

## Usage

```bash
# Source the environment to access gita data
source /workspace/gita-tools/.openhands/env.sh

# Run the data prep tool
cd /workspace/gita-tools/data-prep
uv run main.py
```

## Development

This project uses `uv` for dependency management and Python environment handling.

```bash
# Install dependencies
uv sync

# Add new dependencies
uv add <package-name>

# Run the project
uv run main.py
```

## JupyterLab

JupyterLab is included for interactive data exploration and analysis.

### Installing JupyterLab

```bash
# Install JupyterLab using the provided script
/workspace/gita-tools/.openhands/install-jupyter.sh
```

### Starting JupyterLab

```bash
# Quick start (automatically installs if needed)
/workspace/gita-tools/.openhands/start-jupyter.sh

# Or manually:
# Source the environment to access gita data
source /workspace/gita-tools/.openhands/env.sh

# Start JupyterLab (no token/password required)
cd /workspace/gita-tools/data-prep
uv run jupyter lab --ip=0.0.0.0 --port=50809 --no-browser --allow-root --ServerApp.token='' --ServerApp.password=''
```

### Access JupyterLab

Once started, JupyterLab will be available at:
- http://localhost:50809/lab

### Sample Notebook

The project includes `gita_data_exploration.ipynb` which demonstrates how to:
- Load and explore the Gita data files
- Work with verses, chapters, and translations
- Analyze the data structure

### Environment Variables in Jupyter

To access the Gita data in Jupyter notebooks, the `GITA_DATA_PATH` environment variable should be set. You can do this by:

1. Starting Jupyter from a shell where the environment is sourced
2. Or setting it directly in the notebook:
   ```python
   import os
   os.environ['GITA_DATA_PATH'] = '/tmp/gita-repo'
   ```
