# WSL Dotfiles and Editor Configurations

This directory contains dotfiles and configuration files for various editors and tools in WSL (Windows Subsystem for Linux), with support for syncing to Windows.

## Supported Editors and Tools

- **Zed** - Modern code editor with AI assistance
- **Cursor** - AI-powered fork of VS Code
- **Rider** - JetBrains IDE for .NET development
- **GitHub Copilot** - AI pair programmer (supported across all editors)

## Directory Structure

```
wsl/
├── zed/              # Zed editor configuration
│   ├── settings.json
│   └── keymap.json
├── cursor/           # Cursor editor configuration
│   ├── settings.json
│   └── extensions.json
├── rider/            # JetBrains Rider configuration
│   ├── editor.xml
│   └── README.md
├── copilot/          # GitHub Copilot setup guide
│   └── README.md
└── scripts/          # Installation and sync scripts
    ├── install.sh
    ├── sync-to-windows.sh
    └── sync-from-windows.ps1
```

## Quick Start

### Installation on WSL

1. Clone this repository:
   ```bash
   cd ~
   git clone https://github.com/lilith/dotfiles.git
   cd dotfiles
   ```

2. Run the installation script:
   ```bash
   ./wsl/scripts/install.sh
   ```

3. Follow the prompts to install configurations for your preferred editors

### Syncing Between WSL and Windows

#### WSL to Windows

Run the sync script from WSL:
```bash
./wsl/scripts/sync-to-windows.sh
```

This will copy your WSL configurations to the Windows AppData directories.

#### Windows to WSL

Run the PowerShell script from Windows (as Administrator):
```powershell
# Navigate to the repository directory in Windows
cd \\wsl$\Ubuntu\home\<username>\dotfiles\wsl\scripts

# Run the sync script
.\sync-from-windows.ps1
```

Or specify a different WSL distribution:
```powershell
.\sync-from-windows.ps1 -WslDistro "Ubuntu-22.04"
```

## Editor-Specific Setup

### Zed

1. Install Zed: Visit [zed.dev](https://zed.dev)
2. Configurations will be automatically linked by the install script
3. Sign in to GitHub Copilot via Command Palette (Ctrl+Shift+P)

**Key Features Configured:**
- One Dark theme
- JetBrains Mono font
- GitHub Copilot integration
- Format on save
- Git integration

### Cursor

1. Download Cursor from [cursor.sh](https://cursor.sh)
2. Install recommended extensions via the extensions.json
3. Install GitHub Copilot extension

**Key Features Configured:**
- One Dark Pro theme
- Auto-save and format on save
- GitHub Copilot enabled
- Cursor AI chat enabled
- Python, JavaScript, TypeScript formatters

**Recommended Extensions:**
- GitHub Copilot & Copilot Chat
- Python & Black formatter
- ESLint & Prettier
- GitLens

### Rider

1. Install JetBrains Rider from [jetbrains.com/rider](https://www.jetbrains.com/rider/)
2. For WSL, you can use Rider on Windows with WSL integration
3. Install GitHub Copilot plugin from JetBrains Marketplace

**Setup Options:**

**Option 1: JetBrains Settings Sync (Recommended)**
- Go to File → Settings Sync (or Settings Repository)
- Sign in with JetBrains Account
- Enable sync across all machines

**Option 2: Manual Configuration**
- The install script will link editor settings
- For full configuration, copy files to Rider config directory

**WSL Integration:**
- Open projects from `\\wsl$\Ubuntu\` path in Windows Rider
- Configure WSL as remote development environment
- Use WSL terminal within Rider

### GitHub Copilot

GitHub Copilot works across all supported editors. See [copilot/README.md](./copilot/README.md) for setup instructions.

**General Setup:**
1. Ensure you have a GitHub Copilot subscription
2. Install the appropriate extension/plugin for your editor
3. Sign in with your GitHub account
4. Configure suggestions as needed

## Configuration Management

### Customizing Configurations

All configuration files are in this repository. To customize:

1. Edit the configuration files directly in `wsl/<editor>/`
2. If using symlinks (via install.sh), changes will be reflected in your editor
3. Commit and push changes to sync across machines

### Adding New Configurations

To add configurations for additional editors:

1. Create a new directory under `wsl/`
2. Add configuration files
3. Update `install.sh` to include installation steps
4. Update sync scripts to include the new editor
5. Update this README

## Troubleshooting

### Symlinks Not Working

If symlinks aren't working:
```bash
# Check if symlink was created
ls -la ~/.config/zed/settings.json

# Recreate symlink manually
ln -sf ~/dotfiles/wsl/zed/settings.json ~/.config/zed/settings.json
```

### Windows Sync Issues

If sync to Windows fails:
- Ensure WSL can access Windows filesystem (`/mnt/c/` should be available)
- Check Windows user profile path matches your username
- Run scripts with appropriate permissions

### Editor Not Finding Configuration

Some editors may need to be restarted after configuration changes:
```bash
# Close all instances of the editor
pkill zed
pkill cursor

# Reopen the editor
```

## Best Practices

1. **Version Control**: Commit configuration changes to track your preferences over time
2. **Backups**: The install script automatically backs up existing configurations
3. **Regular Sync**: Sync configurations regularly if working on multiple machines
4. **Test Changes**: Test configuration changes before committing
5. **Documentation**: Document custom settings or plugins you add

## Additional Resources

- [Zed Documentation](https://zed.dev/docs)
- [Cursor Documentation](https://cursor.sh/docs)
- [Rider Documentation](https://www.jetbrains.com/rider/documentation/)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)

## Contributing

To improve these configurations:
1. Fork this repository
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## License

See the LICENSE file in the repository root.
