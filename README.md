# Gita Tools

A monorepo containing multiple projects and tools related to the Bhagavad Gita.

## Overview

This repository houses various tools, utilities, and applications that work with Bhagavad Gita data. The monorepo structure allows for shared resources, consistent development practices, and coordinated releases across related projects.

## Repository Structure

This is a monorepo containing multiple independent but related projects:

```
gita-tools/
├── .openhands/          # OpenHands configuration
│   └── microagents/     # Microagent documentation
├── [project-1]/         # Individual project directories
├── [project-2]/         # (to be added as projects are developed)
└── shared/              # Shared utilities and resources
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

*Projects will be documented here as they are added to the monorepo.*

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
