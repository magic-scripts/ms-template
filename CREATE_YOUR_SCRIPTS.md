# Creating Your Own Magic Scripts

This guide will help you create your own Magic Scripts collection using this template.

## 🚀 Quick Setup

### 1. Fork this template repository

```bash
git clone git@github.com:magic-scripts/ms-template.git my-scripts
cd my-scripts
```

### 2. Customize the registry

Edit `example.msreg` to include your own commands (2-tier system):

```bash
# Add your commands - pointing to .msver files
command|mycommand|https://raw.githubusercontent.com/your-username/my-scripts/main/registry/mycommand.msver|My custom command|utilities
```

Create `registry/mycommand.msver` files for each command:

```bash
# Format: version|version_name|download_url|checksum|install_script|uninstall_script|update_script
# Version information
# install_script, uninstall_script, and update_script are optional (use empty string if not needed)
# update_script is executed when updating TO this version (e.g., 1.0.0 -> 1.0.1 runs 1.0.1's update_script)
version|1.0.0|https://raw.githubusercontent.com/your-username/my-scripts/main/scripts/mycommand.sh|a1b2c3d4|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/install.sh|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/uninstall.sh|
version|1.0.1|https://raw.githubusercontent.com/your-username/my-scripts/main/scripts/mycommand.sh|b2c3d4e5|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/install.sh|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/uninstall.sh|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/update.sh
version|dev|https://raw.githubusercontent.com/your-username/my-scripts/main/scripts/mycommand.sh|dev|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/install.sh|https://raw.githubusercontent.com/your-username/my-scripts/main/installer/uninstall.sh|

# Configuration keys
config|MY_CONFIG|default_value|Description of my config|category|mycommand
```

### 3. Create your scripts

Add your automation scripts to the `scripts/` directory. Follow the example pattern in `scripts/msworld.sh`:

- Use proper shebang (`#!/bin/sh`)
- Include help and version options
- Use configuration variables from the Magic Scripts system
- Follow consistent naming and color coding

### 4. Create installer scripts (optional)

Create `installer/install.sh`, `installer/uninstall.sh`, and `installer/update.sh`:

- **install.sh**: Run during command installation (setup configurations, create directories, etc.)
- **uninstall.sh**: Run during command removal (cleanup configurations, remove data, etc.)  
- **update.sh**: Run when updating TO a specific version (migrate data, update configurations, etc.)

The `update.sh` script is executed with these arguments:
```bash
update.sh <command_name> <old_version> <new_version> <script_path> <wrapper_path> <registry_name>
```

See `installer/update.sh` for a complete example with version migration patterns.

### 5. Install Magic Scripts

If you haven't already, install the Magic Scripts system:

```bash
curl -fsSL https://raw.githubusercontent.com/magic-scripts/ms/main/setup.sh | sh
```

### 6. Register your custom registry

```bash
# Add your custom registry to Magic Scripts
ms reg add my-scripts https://raw.githubusercontent.com/your-username/my-scripts/main/example.msreg

# Update to fetch the latest registry
ms upgrade

# Install your commands
ms install mycommand
```

## 📁 Template Structure

```
ms-template/
├── README.md              # Standard project documentation
├── CREATE_YOUR_SCRIPTS.md # This customization guide
├── example.msreg          # Master registry (2-tier system)
├── registry/
│   └── msworld.msver      # Version tree for msworld command
├── scripts/
│   └── msworld.sh         # Example script showing best practices
├── installer/
│   ├── install.sh         # Installation script
│   ├── uninstall.sh       # Uninstallation script  
│   └── update.sh          # Update script (version migrations)
└── man/
    └── msworld.1          # Man page documentation
```

## 📝 Example: msworld Command

The template includes `msworld` - a simple command that demonstrates:

- ✅ Using configuration values (`MAGICSCRIPT_WORLD`)
- ✅ Command-line argument handling
- ✅ Help and version options
- ✅ Colorful, user-friendly output
- ✅ Error handling

### Usage

```bash
# Use default world from configuration
msworld

# Display specific world information
msworld mars

# Show current configuration
msworld --config
```

## 🎯 Best Practices

### Script Structure

1. **Standard Header**:
```bash
#!/bin/sh
set -e

# Script metadata
SCRIPT_NAME="mycommand"
SCRIPT_VERSION="1.0.0"
SCRIPT_DESCRIPTION="Description of my command"
```

2. **Color Constants**:
```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
```

3. **Configuration Loading**:
```bash
# Load Magic Scripts configuration system
if [ -f "$HOME/.local/share/magicscripts/core/config.sh" ]; then
    . "$HOME/.local/share/magicscripts/core/config.sh"
fi
```

4. **Help and Version Options**:
```bash
case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--version)
        echo "$SCRIPT_NAME v$SCRIPT_VERSION"
        exit 0
        ;;
esac
```

### Registry Management

- **Use semantic versioning**: 1.0.0, 1.1.0, 2.0.0
- **Generate proper checksums**: Use `mschecksum` for consistency
- **Test thoroughly**: Ensure all versions work correctly
- **Document changes**: Include clear version descriptions

### Documentation

- **Man pages**: Create `.1` files in `man/` directory
- **Clear examples**: Show practical usage scenarios  
- **Configuration docs**: Document all available config keys
- **Integration guides**: Show how to use with other tools

## 🔧 Testing Your Scripts

### Local Testing

```bash
# Test your script directly
./scripts/mycommand.sh --help
./scripts/mycommand.sh test-args

# Test installation
ms install mycommand
mycommand --version
```

### Registry Testing

```bash
# Add local registry for testing
ms reg add test file:///path/to/your/example.msreg

# Test installation from registry
ms install -r test mycommand
```

## 📦 Publishing

### 1. Prepare Release

```bash
# Update version in .msver file
# Generate checksum
mschecksum scripts/mycommand.sh

# Update README.md with new version info
```

### 2. Create GitHub Release

```bash
# Tag the release
git tag v1.0.0
git push origin v1.0.0

# Create GitHub release with release notes
```

### 3. Update Registry URLs

Ensure all URLs in your `.msver` and `.msreg` files point to the correct locations:
- Use `main` branch for stable releases
- Use `develop` branch for development versions
- Update checksums for all changed files

## 🤝 Contributing Back

Consider contributing your useful scripts back to the Magic Scripts ecosystem:

1. **Follow standards**: Use the established patterns and conventions
2. **Test thoroughly**: Ensure cross-platform compatibility  
3. **Document well**: Provide clear usage examples
4. **Submit PR**: Open pull request to the main Magic Scripts registry

## 🔗 Resources

- **[Magic Scripts Core](https://github.com/magic-scripts/ms)** - Main system
- **[Registry System Documentation](https://github.com/magic-scripts/ms/docs/REGISTRY.md)** - How registries work
- **[Configuration System](https://github.com/magic-scripts/ms/docs/CONFIGURATION.md)** - Managing settings
- **[Development Guide](https://github.com/magic-scripts/ms/docs/DEVELOPMENT.md)** - Advanced development topics

---

Happy scripting! 🚀