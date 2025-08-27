# Gita Tools

A monorepo containing multiple projects and tools related to the Bhagavad Gita.

## Overview

This repository houses various tools, utilities, and applications that work with Bhagavad Gita data. The monorepo structure allows for shared resources, consistent development practices, and coordinated releases across related projects.

## Repository Structure

This is a monorepo containing multiple independent but related projects:

```
gita-tools/
├── .openhands/              # OpenHands configuration
│   └── microagents/         # Microagent documentation
├── gita-heart-game/         # Interactive Gita learning game
│   ├── godot-project/       # Godot game source code
│   │   ├── scenes/          # Game scenes
│   │   ├── scripts/         # Game logic scripts
│   │   ├── data/            # Gita JSON data files
│   │   └── web-build/       # Exported web version
│   └── README.md
├── data-prep/               # Data processing utilities
├── docs/                    # GitHub Pages deployment
│   └── index.html           # Web game files
├── index.html               # Main landing page
└── README.md
```

## Data Sources

This project utilizes data from the [gita/gita](https://github.com/gita/gita) repository, which provides:

- Verse texts and translations
- Chapter information
- Commentary from various authors
- Audio recitations
- Multi-language support

## Getting Started

### Prerequisites

- Git
- Python 3.8+ (for Python-based projects)
- Node.js (for JavaScript-based projects)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kashodiya/gita-tools.git
   cd gita-tools
   ```

2. Navigate to specific project directories for individual setup instructions.

## Projects

### 🎮 Gita Heart Game
**Interactive web-based learning game for the Bhagavad Gita**

- **Location**: `gita-heart-game/`
- **Live Demo**: [Play Online](https://kashodiya.github.io/gita-tools/)
- **Technology**: Godot Engine 4.3, WebAssembly
- **Features**:
  - Multiple game modes (Verse Completion, Verse Identification, Chapter Sequence)
  - Multi-language support (Sanskrit, English, Hindi)
  - Optional scoring system
  - 700+ verses with authentic data
  - Runs in any modern web browser

**Quick Start**: Open `index.html` in your browser or visit the live demo above.

### 📊 Data Preparation Tools
**Utilities for processing and preparing Gita data**

- **Location**: `data-prep/`
- **Purpose**: Scripts and tools for data extraction, transformation, and validation
- **Technology**: Python, JSON processing

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Bhagavad Gita API](https://github.com/gita/gita) for providing the foundational data
- The open-source community for tools and libraries used in this project

## Contact

For questions or suggestions, please open an issue in this repository.
