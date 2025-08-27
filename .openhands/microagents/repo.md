# Gita Tools Repository

## Repository Type
This is a **mono repository** that contains more than one project.

## Overview
The `gita-tools` repository is structured as a monorepo to house multiple related projects that work with or are inspired by the Bhagavad Gita. This organizational approach allows for:

- Shared dependencies and tooling across projects
- Consistent development practices
- Easier maintenance and coordination between related tools
- Centralized documentation and issue tracking

## Projects
This monorepo contains multiple projects related to Gita tools and utilities. Each project may have its own specific purpose, dependencies, and documentation within their respective directories.

## Structure
As a monorepo, this repository is organized to support multiple independent but related projects under a single version control system, facilitating better collaboration and resource sharing.

## Data Files
The setup script automatically clones the main gita repository (https://github.com/gita/gita) to `/tmp/gita-repo` to provide access to comprehensive Bhagavad Gita data:

### Available Data Files (in `/tmp/gita-repo/data/`):
- `verse.json` - Complete Sanskrit verses with transliterations
- `translation.json` - Translations in multiple languages
- `commentary.json` - Detailed commentaries from various scholars
- `chapters.json` - Chapter information and metadata
- `authors.json` - Information about translators and commentators
- `languages.json` - Supported language codes and names
- `summary.md` - Summary of the data structure
- `verse_recitation/` - Audio recitation files organized by chapters (1-18)

### Environment Variable
These files are available at the path stored in the `GITA_DATA_PATH` environment variable, which is automatically set to `/tmp/gita-repo` during repository initialization.

### Usage
Projects in this monorepo can access these data files using the environment variable:
```bash
# Source the environment file to set GITA_DATA_PATH
source /workspace/gita-tools/.openhands/env.sh

echo $GITA_DATA_PATH  # Shows: /tmp/gita-repo
ls $GITA_DATA_PATH/data/  # Lists all available data files

# Example: Access specific data files
cat $GITA_DATA_PATH/data/languages.json
jq '.chapters[0]' $GITA_DATA_PATH/data/chapters.json
```

## JupyterLab Installation

For interactive data exploration, JupyterLab can be installed using the provided script:

```bash
# Install JupyterLab in the data-prep project
/workspace/gita-tools/.openhands/install-jupyter.sh

# Or manually install in any project directory
cd /workspace/gita-tools/your-project
uv add jupyterlab
```

The installation script will:
- Navigate to the data-prep project
- Install JupyterLab using uv
- Provide instructions for starting JupyterLab

## Setup Script

The `setup.sh` script in the `.openhands` folder performs the following tasks:

1. **Clone Gita Repository**: Downloads the main gita repository containing all the data files to `/tmp/gita-repo`
2. **Environment Configuration**: Creates an `env.sh` file that sets the `GITA_DATA_PATH` environment variable
3. **Data Validation**: Verifies that the data files are properly downloaded and accessible
4. **Optional JupyterLab**: Provides instructions for installing JupyterLab for data exploration

### Running Setup

```bash
# Make setup script executable and run it
chmod +x /workspace/gita-tools/.openhands/setup.sh
/workspace/gita-tools/.openhands/setup.sh
```

The setup script ensures that all projects in the monorepo have access to the same standardized Gita data source.

### Quick Start Scripts

Two convenience scripts are provided for JupyterLab:

1. **install-jupyter.sh** - Installs JupyterLab in the data-prep project
   ```bash
   /workspace/gita-tools/.openhands/install-jupyter.sh
   ```

2. **start-jupyter.sh** - Quick start script that automatically installs (if needed) and starts JupyterLab
   ```bash
   /workspace/gita-tools/.openhands/start-jupyter.sh
   ```

The start script will:
- Source the environment variables
- Navigate to the data-prep directory
- Check if JupyterLab is installed (install if needed)
- Start JupyterLab on port 50809 without authentication
- Provide access URL: http://localhost:50809/lab
