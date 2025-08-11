#!/bin/sh

# Example update script for Magic Scripts commands
# This script is executed when updating TO this version
# 
# Arguments:
# $1 = command name
# $2 = old version  
# $3 = new version
# $4 = script path
# $5 = wrapper path
# $6 = registry name

set -e

COMMAND_NAME="$1"
OLD_VERSION="$2" 
NEW_VERSION="$3"
SCRIPT_PATH="$4"
WRAPPER_PATH="$5"
REGISTRY_NAME="$6"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo "${BLUE}Running update script for $COMMAND_NAME${NC}"
echo "Updating from $OLD_VERSION to $NEW_VERSION"
echo ""

# Example: Migrate configuration files
CONFIG_DIR="$HOME/.local/share/magicscripts/config"
OLD_CONFIG="$CONFIG_DIR/${COMMAND_NAME}.old.conf"
NEW_CONFIG="$CONFIG_DIR/${COMMAND_NAME}.conf"

if [ -f "$NEW_CONFIG" ]; then
    echo "${YELLOW}Backing up existing configuration...${NC}"
    cp "$NEW_CONFIG" "$OLD_CONFIG"
fi

# Example: Clear cache if major version change
OLD_MAJOR=$(echo "$OLD_VERSION" | cut -d'.' -f1)
NEW_MAJOR=$(echo "$NEW_VERSION" | cut -d'.' -f1)

if [ "$OLD_MAJOR" != "$NEW_MAJOR" ]; then
    echo "${YELLOW}Major version change detected, clearing cache...${NC}"
    CACHE_DIR="$HOME/.local/share/magicscripts/cache/$COMMAND_NAME"
    if [ -d "$CACHE_DIR" ]; then
        rm -rf "$CACHE_DIR"
        mkdir -p "$CACHE_DIR"
        echo "${GREEN}Cache cleared${NC}"
    fi
fi

# Example: Run version-specific migrations
case "$NEW_VERSION" in
    "1.1.0")
        echo "${YELLOW}Running migration for v1.1.0...${NC}"
        # Add your migration logic here
        echo "${GREEN}Migration completed${NC}"
        ;;
    "2.0.0")
        echo "${YELLOW}Running migration for v2.0.0...${NC}"
        # Add your migration logic here
        echo "${GREEN}Migration completed${NC}"
        ;;
    *)
        echo "${BLUE}No specific migrations needed for $NEW_VERSION${NC}"
        ;;
esac

echo ""
echo "${GREEN}✅ Update script completed successfully${NC}"
echo "Your $COMMAND_NAME installation has been updated from $OLD_VERSION to $NEW_VERSION"