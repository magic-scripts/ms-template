#!/bin/bash

# msworld Uninstall Script
# This is an uninstall script - use this if you need to clean up anything during removal

echo "This is an uninstall script - use this if you need to clean up anything during removal"

# Man page is now managed by Magic Scripts core system via msver file
# No need to handle man page removal here

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