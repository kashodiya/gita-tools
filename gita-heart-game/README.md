# Gita Heart Game

## Project Description

An interactive game designed for devotees and students who wish to deepen their knowledge of the Bhagavad Gita through engaging gameplay. This browser-based game helps players memorize and understand Gita verses through various challenging activities.

## Game Features

- [ ] **Verse Completion Challenge**: Players are presented with one line from a random Gita verse and must complete the remaining three lines. Each verse consists of four parts (padas).
- [ ] **Verse Identification**: Players are shown a complete verse and must correctly identify its chapter and verse number.
- [ ] **Audio Rewards**: Upon successfully completing any verse-based challenge, players can listen to the authentic Sanskrit recitation of that verse.
- [ ] **Chapter Sequence Game**: Players are presented with chapter names in random order and must arrange them in the correct sequence (1-18). 

## Data Access

This project has access to comprehensive Bhagavad Gita data through the `GITA_DATA_PATH` environment variable:

### Available Data Files
- **Verses**: `/tmp/gita-repo/data/verse.json` - Complete Sanskrit verses with transliterations
- **Translations**: `/tmp/gita-repo/data/translation.json` - Translations in multiple languages
- **Commentaries**: `/tmp/gita-repo/data/commentary.json` - Detailed commentaries from various scholars
- **Chapters**: `/tmp/gita-repo/data/chapters.json` - Chapter information and metadata
- **Authors**: `/tmp/gita-repo/data/authors.json` - Information about translators and commentators
- **Languages**: `/tmp/gita-repo/data/languages.json` - Supported language codes (English, Hindi, Sanskrit)
- **Audio**: `/tmp/gita-repo/data/verse_recitation/` - Audio recitation files organized by chapters (1-18)

## Installation

The game runs directly in the browser with no installation required. Players can access and play the game immediately through any modern web browser.

## Development

The game is built using Godot engine with web export capabilities, allowing it to run seamlessly in browsers.

## Game Flow

- **Challenge Selection**: Players are presented with a menu to choose which type of challenge they want to attempt.
- **Continuous Play**: Once engaged in a specific game mode, players can continue playing consecutive rounds of the same challenge type without returning to the main menu.

## Usage

[Usage instructions to be added]

## Contributing

[Contributing guidelines to be added]
