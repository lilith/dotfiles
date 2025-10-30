# JetBrains Rider Configuration for WSL

This directory contains configuration files for JetBrains Rider IDE.

## Setup Instructions

### Installation on WSL
1. Install Rider on Windows
2. Use WSL integration to open projects from WSL filesystem
3. Or install JetBrains Toolbox in WSL (requires X11/WSLg)

### Syncing Settings

#### Method 1: IDE Settings Sync (Recommended)
1. Open Rider
2. Go to File → Settings Repository or Settings Sync
3. Use JetBrains Account to sync settings across machines

#### Method 2: Manual Configuration
1. Copy configuration files from this directory to:
   - Windows: `%APPDATA%\JetBrains\Rider<version>\`
   - WSL: `~/.config/JetBrains/Rider<version>/`

### Key Configuration Files
- `editor.xml` - Editor settings (fonts, colors, formatting)
- `codestyles/` - Code style configurations
- `keymaps/` - Custom keyboard shortcuts

## Features Configured
- Darcula theme
- JetBrains Mono font
- 120 character line limit
- Soft margins at 80 and 120
- GitHub Copilot integration
- Code inspection settings
- Git integration

## GitHub Copilot Setup
1. Install GitHub Copilot plugin from JetBrains Marketplace
2. Go to Settings → Tools → GitHub Copilot
3. Sign in with GitHub account
4. Configure suggestions as needed

## WSL-Specific Notes
- Use `\\wsl$\` path to access WSL filesystem from Windows
- Configure terminal to use WSL bash
- Set up remote debugging if needed
