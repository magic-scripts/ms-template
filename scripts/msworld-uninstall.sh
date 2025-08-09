#!/bin/bash

# msworld Uninstall Script
# This is an uninstall script - use this if you need to clean up anything during removal

echo "This is an uninstall script - use this if you need to clean up anything during removal"

# Remove man page for msworld
MANDIR="/usr/local/share/man/man1"
MANPAGE="$MANDIR/msworld.1"

if [[ -f "$MANPAGE" ]]; then
    echo "Removing man page for msworld..."
    sudo rm -f "$MANPAGE"
    
    # Update man database
    echo "Updating man database..."
    sudo mandb -q 2>/dev/null || true
    
    echo "Man page removed successfully"
else
    echo "Man page not found, skipping removal"
fi

# Clean up any configuration or cache files if they exist
CONFIG_DIR="$HOME/.config/msworld"
if [[ -d "$CONFIG_DIR" ]]; then
    echo "Removing configuration directory: $CONFIG_DIR"
    rm -rf "$CONFIG_DIR"
fi

CACHE_DIR="$HOME/.cache/msworld"
if [[ -d "$CACHE_DIR" ]]; then
    echo "Removing cache directory: $CACHE_DIR"
    rm -rf "$CACHE_DIR"
fi

echo "msworld uninstall script completed successfully"