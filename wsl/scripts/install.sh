#!/bin/bash
# WSL Dotfiles Installation Script
# This script sets up symlinks for editor configurations in WSL

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}WSL Dotfiles Installation Script${NC}"
echo -e "${GREEN}=================================${NC}\n"

# Get the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WSL_CONFIG_DIR="$DOTFILES_DIR/wsl"

echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}\n"

# Function to create symlink
create_symlink() {
    local src="$1"
    local dest="$2"
    local desc="$3"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Remove existing file/symlink if it exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ]; then
            echo -e "${YELLOW}Removing existing symlink: $dest${NC}"
            rm "$dest"
        else
            # Backup existing file
            backup="$dest.backup.$(date +%Y%m%d_%H%M%S)"
            echo -e "${YELLOW}Backing up existing file to: $backup${NC}"
            mv "$dest" "$backup"
        fi
    fi
    
    # Create symlink
    ln -s "$src" "$dest"
    echo -e "${GREEN}✓ Linked $desc${NC}"
}

# Function to prompt user
prompt_install() {
    local name="$1"
    echo -e "\n${YELLOW}Install $name configuration? (y/n)${NC}"
    read -r response
    [[ "$response" =~ ^[Yy]$ ]]
}

# Install Zed configuration
if prompt_install "Zed"; then
    ZED_CONFIG_DIR="$HOME/.config/zed"
    create_symlink "$WSL_CONFIG_DIR/zed/settings.json" "$ZED_CONFIG_DIR/settings.json" "Zed settings"
    create_symlink "$WSL_CONFIG_DIR/zed/keymap.json" "$ZED_CONFIG_DIR/keymap.json" "Zed keymap"
fi

# Install Cursor configuration (VSCode-based)
if prompt_install "Cursor"; then
    CURSOR_CONFIG_DIR="$HOME/.config/Cursor/User"
    create_symlink "$WSL_CONFIG_DIR/cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json" "Cursor settings"
    create_symlink "$WSL_CONFIG_DIR/cursor/extensions.json" "$CURSOR_CONFIG_DIR/extensions.json" "Cursor extensions"
fi

# Install Rider configuration
if prompt_install "Rider"; then
    echo -e "${YELLOW}Finding JetBrains Rider configuration directory...${NC}"
    JETBRAINS_CONFIG="$HOME/.config/JetBrains"
    
    # Try to find existing Rider directory or create a generic one
    if [ -d "$JETBRAINS_CONFIG" ]; then
        RIDER_DIR=$(ls -d "$JETBRAINS_CONFIG"/Rider* 2>/dev/null | sort -V | tail -n 1)
    fi
    
    if [ -z "$RIDER_DIR" ]; then
        echo -e "${YELLOW}No existing Rider configuration found.${NC}"
        echo -e "${YELLOW}Settings will be available after first Rider launch.${NC}"
        RIDER_DIR="$JETBRAINS_CONFIG/Rider2024.1"
    fi
    
    mkdir -p "$RIDER_DIR/options"
    create_symlink "$WSL_CONFIG_DIR/rider/editor.xml" "$RIDER_DIR/options/editor.xml" "Rider editor settings"
    
    echo -e "${BLUE}Note: For complete Rider configuration, use JetBrains Settings Sync${NC}"
fi

echo -e "\n${GREEN}Installation complete!${NC}\n"
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. Review the configurations in $WSL_CONFIG_DIR"
echo -e "  2. To sync with Windows, run: $WSL_CONFIG_DIR/scripts/sync-to-windows.sh"
echo -e "  3. To sync from Windows, run the PowerShell script on Windows"
echo -e "  4. Install GitHub Copilot extensions/plugins in your editors"
echo -e "\n${YELLOW}GitHub Copilot setup:${NC}"
echo -e "  - Cursor/VSCode: Install 'GitHub Copilot' extension"
echo -e "  - Rider: Install 'GitHub Copilot' plugin from marketplace"
echo -e "  - Zed: Copilot is configured, sign in via command palette"
