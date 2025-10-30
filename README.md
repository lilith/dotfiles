# dotfiles
Config and dotfiles for various editors and development tools

## Overview

This repository contains configuration files (dotfiles) for development environments, with a focus on WSL (Windows Subsystem for Linux) and cross-platform syncing to Windows.

## Contents

### WSL Configurations

The `wsl/` directory contains configurations for:

- **Zed** - Modern code editor with AI assistance
- **Cursor** - AI-powered fork of VS Code  
- **Rider** - JetBrains IDE for .NET development
- **GitHub Copilot** - AI pair programmer integration for all editors

For detailed setup instructions, see [wsl/README.md](./wsl/README.md)

## Quick Start

### Installation

1. Clone this repository:
   ```bash
   cd ~
   git clone https://github.com/lilith/dotfiles.git
   cd dotfiles
   ```

2. Run the WSL installation script:
   ```bash
   ./wsl/scripts/install.sh
   ```

3. Follow the prompts to install configurations for your preferred editors

### Syncing Between WSL and Windows

**WSL to Windows:**
```bash
./wsl/scripts/sync-to-windows.sh
```

**Windows to WSL (PowerShell):**
```powershell
.\wsl\scripts\sync-from-windows.ps1
```

## Features

- 🔄 **Bidirectional Sync**: Sync configurations between WSL and Windows
- 🤖 **AI Integration**: Pre-configured GitHub Copilot support
- ⚙️ **Multiple Editors**: Support for Zed, Cursor, and Rider
- 📝 **Consistent Settings**: Unified configuration across editors
- 🔗 **Symlink Management**: Easy installation with automatic backups

## Documentation

- [WSL Setup Guide](./wsl/README.md) - Complete guide for WSL configurations
- [GitHub Copilot Setup](./wsl/copilot/README.md) - Copilot configuration guide
- [Rider Configuration](./wsl/rider/README.md) - JetBrains Rider specific setup

## License

See [LICENSE](./LICENSE) file for details. 
