# Contributing to Dotfiles

Thank you for your interest in contributing to this dotfiles repository!

## How to Contribute

### Adding New Editor Configurations

1. Create a new directory under `wsl/` with the editor name (e.g., `wsl/vscode/`)

2. Add configuration files for that editor:
   ```
   wsl/your-editor/
   ├── README.md          # Setup and usage instructions
   ├── settings.json      # Main configuration (if applicable)
   └── ...                # Other config files
   ```

3. Update `wsl/scripts/install.sh` to include installation steps

4. Update `wsl/scripts/sync-to-windows.sh` to sync the new configs

5. Update `wsl/README.md` to document the new editor

### Modifying Existing Configurations

1. Edit the configuration files directly in `wsl/<editor>/`

2. Test your changes thoroughly

3. Document any significant changes in the README

4. Submit a pull request with a clear description

### Testing Your Changes

Before submitting:

1. Test the installation script:
   ```bash
   ./wsl/scripts/install.sh
   ```

2. Verify sync scripts work:
   ```bash
   ./wsl/scripts/sync-to-windows.sh
   ```

3. Ensure JSON/XML files are valid:
   ```bash
   python3 -m json.tool wsl/editor/settings.json
   ```

4. Check shell scripts for syntax errors:
   ```bash
   bash -n wsl/scripts/your-script.sh
   ```

### Code Style

- Use 2 spaces for indentation in JSON, YAML, and shell scripts
- Use meaningful variable names
- Add comments for complex logic
- Follow existing patterns in the repository

### Commit Messages

Use clear and descriptive commit messages:

- `Add <editor> configuration`
- `Update <editor> settings for <feature>`
- `Fix sync script for <issue>`

### Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/add-new-editor`)
3. Make your changes
4. Commit with clear messages
5. Push to your fork
6. Open a pull request

### Documentation

All new features should include:

- README in the editor-specific directory
- Updates to main `wsl/README.md`
- Comments in complex scripts or configurations

### Questions?

Open an issue if you have questions or suggestions!

## Code of Conduct

- Be respectful and constructive
- Help others learn and improve
- Focus on what's best for the community

Thank you for contributing!
