#!/bin/bash
# WSL to Windows Configuration Sync Script
# This script syncs editor configurations from WSL to Windows

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get Windows user profile path
WINDOWS_USER_PROFILE="/mnt/c/Users/${USER}"
if [ ! -d "$WINDOWS_USER_PROFILE" ]; then
    # Try to find the actual Windows username
    WINDOWS_USER_PROFILE=$(ls -d /mnt/c/Users/*/ 2>/dev/null | grep -v "Public\|Default\|All Users" | head -n 1)
    WINDOWS_USER_PROFILE=${WINDOWS_USER_PROFILE%/}
fi

if [ ! -d "$WINDOWS_USER_PROFILE" ]; then
    echo -e "${RED}Error: Could not find Windows user profile directory${NC}"
    echo "Please set WINDOWS_USER_PROFILE environment variable manually"
    exit 1
fi

echo -e "${GREEN}Found Windows user profile: $WINDOWS_USER_PROFILE${NC}"

# Base directory for dotfiles in WSL
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WSL_CONFIG_DIR="$DOTFILES_DIR/wsl"

echo -e "${YELLOW}Syncing configurations from WSL to Windows...${NC}"

# Function to create directory if it doesn't exist
ensure_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo -e "${GREEN}Created directory: $1${NC}"
    fi
}

# Function to sync files
sync_files() {
    local src="$1"
    local dest="$2"
    local desc="$3"
    
    if [ -d "$src" ] || [ -f "$src" ]; then
        ensure_dir "$(dirname "$dest")"
        cp -r "$src" "$dest"
        echo -e "${GREEN}✓ Synced $desc${NC}"
    else
        echo -e "${YELLOW}⚠ Skipping $desc (source not found)${NC}"
    fi
}

# Sync Cursor settings
CURSOR_APPDATA="$WINDOWS_USER_PROFILE/AppData/Roaming/Cursor/User"
if [ -d "$WSL_CONFIG_DIR/cursor" ]; then
    echo -e "\n${YELLOW}Syncing Cursor configuration...${NC}"
    sync_files "$WSL_CONFIG_DIR/cursor/settings.json" "$CURSOR_APPDATA/settings.json" "Cursor settings"
    sync_files "$WSL_CONFIG_DIR/cursor/extensions.json" "$CURSOR_APPDATA/extensions.json" "Cursor extensions"
fi

# Sync Zed settings (if Zed is installed on Windows)
ZED_CONFIG="$WINDOWS_USER_PROFILE/AppData/Roaming/Zed"
if [ -d "$WSL_CONFIG_DIR/zed" ]; then
    echo -e "\n${YELLOW}Syncing Zed configuration...${NC}"
    sync_files "$WSL_CONFIG_DIR/zed/settings.json" "$ZED_CONFIG/settings.json" "Zed settings"
    sync_files "$WSL_CONFIG_DIR/zed/keymap.json" "$ZED_CONFIG/keymap.json" "Zed keymap"
fi

# Sync Rider settings (JetBrains)
# Note: Rider versions may vary, so we'll try to find the latest
JETBRAINS_CONFIG="$WINDOWS_USER_PROFILE/AppData/Roaming/JetBrains"
if [ -d "$WSL_CONFIG_DIR/rider" ] && [ -d "$JETBRAINS_CONFIG" ]; then
    echo -e "\n${YELLOW}Syncing Rider configuration...${NC}"
    
    # Find latest Rider directory
    RIDER_DIR=$(ls -d "$JETBRAINS_CONFIG"/Rider* 2>/dev/null | sort -V | tail -n 1)
    
    if [ -n "$RIDER_DIR" ]; then
        sync_files "$WSL_CONFIG_DIR/rider/editor.xml" "$RIDER_DIR/options/editor.xml" "Rider editor settings"
        echo -e "${YELLOW}Note: For full Rider sync, use JetBrains Settings Sync feature${NC}"
    else
        echo -e "${YELLOW}⚠ Rider not found. Settings will be synced when Rider is installed.${NC}"
    fi
fi

echo -e "\n${GREEN}Configuration sync completed!${NC}"
echo -e "${YELLOW}Note: Restart editors for changes to take effect.${NC}"
