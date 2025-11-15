# Multi-Click Script

AutoHotkey script for automating repetitive click sequences.

## Setup

1. Install [AutoHotkey v1.1.37+](https://www.autohotkey.com/)
2. Copy `config.ini.example` to `config.ini`
3. Edit `config.ini` with your coordinates and timing
4. Run `multi-click.ahk`

## Usage

- **F1**: Start/Resume
- **F2**: Pause
- **F3**: Capture mouse position
- **F5**: Exit

## Configuration

Edit `config.ini`:
- Set `numClicks` to number of clicks per cycle
- Add `clickNX` and `clickNY` for each click position
- Adjust timing delays as needed

## Building Executable

Right-click `multi-click.ahk` → Compile Script