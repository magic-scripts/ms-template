# Magic Scripts Template

This is a template repository for creating your own Magic Scripts collection. Use this as a starting point to build your custom automation scripts and commands.

## 🚀 Getting Started

### 1. Fork this template repository

```bash
git clone git@github.com:magic-scripts/ms-template.git my-scripts
cd my-scripts
```

### 2. Customize the registry

Edit `example.msreg` to include your own commands (2-tier system):

```bash
# Add your commands - pointing to .msver files
command|mycommand|https://raw.githubusercontent.com/your-username/my-scripts/main/mycommand.msver|My custom command|utilities|dev
```

Create `mycommand.msver` files for each command:

```bash
# Version information
version|1.0.0|https://raw.githubusercontent.com/your-username/my-scripts/main/scripts/mycommand.sh|a1b2c3d4
version|dev|https://raw.githubusercontent.com/your-username/my-scripts/develop/scripts/mycommand.sh|dev

# Configuration keys
config|MY_CONFIG|default_value|Description of my config|category|mycommand
```

### 3. Create your scripts

Add your automation scripts to the `scripts/` directory. Follow the example pattern in `scripts/msworld.sh`:

- Use proper shebang (`#!/bin/sh`)
- Include help and version options
- Use configuration variables from the Magic Scripts system
- Follow consistent naming and color coding

### 4. Install Magic Scripts

If you haven't already, install the Magic Scripts system:

```bash
curl -fsSL https://raw.githubusercontent.com/magic-scripts/ms/main/core/installer/install.sh | sh
```

### 5. Register your custom registry

```bash
# Add your custom registry to Magic Scripts
ms reg add my-scripts https://raw.githubusercontent.com/your-username/my-scripts/main/example.msreg

# Update to fetch the latest registry
ms upgrade

# Install commands from your registry
ms install msworld
```

## 📁 Template Structure

```
ms-template/
├── README.md              # This file
├── example.msreg          # Master registry (2-tier system)
├── msworld.msver          # Version tree for msworld command
└── scripts/
    └── msworld.sh         # Example script showing best practices
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
msworld config

# Get help
msworld --help
```

### Configuration

The `msworld` command uses the `MAGICSCRIPT_WORLD` configuration:

```bash
# Set default world
ms config set MAGICSCRIPT_WORLD mars

# View current setting
ms config get MAGICSCRIPT_WORLD
```

## 🚀 Complete Installation & Testing Guide

### Quick Test of Template (5 minutes)

Want to see how this works right away? Here's how to test the `msworld` example:

```bash
# 1. Clone this template
git clone https://github.com/magic-scripts/ms-template.git
cd ms-template

# 2. Install Magic Scripts (if you haven't already)
curl -fsSL https://raw.githubusercontent.com/magic-scripts/ms/main/core/installer/install.sh | sh

# 3. Add this template as a registry (use local file path for testing)
ms reg add template file://$(pwd)/example.msreg

# 4. Update registries and install the example command
ms upgrade
ms install msworld

# 5. Test the command!
msworld                   # Shows: sup, world! (default)
msworld goodbye           # Shows: goodbye, world!
msworld fxxk              # Shows: fxxk, world! (😈)
```

### Set Configuration Values

```bash
# See available configurations
ms config list -r

# Set the default greeting word
ms config set MAGICSCRIPT_WORLD hello

# Now msworld will show: hello, world!
msworld

# Get configuration value
ms config get MAGICSCRIPT_WORLD

# See all your configurations
ms config list
```

### Understanding How Config Works

The Magic Scripts config system works like this:

1. **Registry defines config keys**: `example.msreg` defines `MAGICSCRIPT_WORLD`
2. **User sets values**: `ms config set MAGICSCRIPT_WORLD hello`  
3. **Scripts access config**: Script calls `ms config get MAGICSCRIPT_WORLD`
4. **Fallback to defaults**: If not set, uses default from registry

```bash
# Proper way to access config in your scripts (through Magic Scripts system):
word=$(ms config get MAGICSCRIPT_WORLD 2>/dev/null || echo "sup")

# This ensures proper permission validation and registry integration
echo "$word, world!"
```

## 🛠 Creating Your Own Commands

### 1. Write your script

Create a new script in `scripts/` directory:

```bash
#!/bin/sh

VERSION="1.0.0"
SCRIPT_NAME="mycommand"

# Access configuration values through Magic Scripts system
my_setting=$(ms config get MY_CONFIG 2>/dev/null || echo "default_fallback")

# Always support --version and --help
case "$1" in
    -v|--version) echo "$SCRIPT_NAME v$VERSION"; exit 0 ;;
    -h|--help) 
        echo "Usage: $SCRIPT_NAME [options]"
        echo "Options:"
        echo "  -v, --version    Show version"
        echo "  -h, --help       Show help"
        exit 0
        ;;
esac

# Your script logic here...
echo "Running with MY_CONFIG: $my_setting"
```

### 2. Add to registry

Add an entry to `example.msreg`:

```
command|mycommand|https://raw.githubusercontent.com/username/repo/main/mycommand.msver|My custom command|utilities|dev
```

Create `mycommand.msver`:

```
# Version information
version|1.0.0|https://raw.githubusercontent.com/username/repo/main/scripts/mycommand.sh|a1b2c3d4
version|dev|https://raw.githubusercontent.com/username/repo/develop/scripts/mycommand.sh|dev

# Configuration keys (optional)
config|MY_CONFIG|default_value|Configuration description|category|mycommand
```

### 4. Test and deploy

```bash
# Test locally first
./scripts/mycommand.sh

# Install msreg tool for registry management
ms install msreg

# Calculate checksum for your script
msreg checksum ./scripts/mycommand.sh
# Output: File: ./scripts/mycommand.sh
#         SHA256 (first 8 chars): a1b2c3d4

# Update your registry file with the calculated checksum
# Then push to your repository
git add .
git commit -m "Add mycommand script"
git push

# Update Magic Scripts to get latest changes
ms upgrade
ms install mycommand

# Test the installed command
mycommand --version
mycommand --help
```

## 🔧 Advanced: Using msreg for Registry Management

### Automatic Command Registration

Instead of manually editing registry files, you can use `msreg` to add commands automatically:

```bash
# Make sure msreg is installed
ms install msreg

# Add a new command to your registry (downloads and calculates checksum automatically)
msreg -f example.msreg add mycommand:1.0.0 https://raw.githubusercontent.com/your-username/your-repo/main/scripts/mycommand.sh

# msreg will prompt for:
# Description: Your command description
# Category: utilities
# Script path (relative to MAGIC_SCRIPT_DIR): scripts/mycommand.sh

# Result: Command automatically added to registry with correct checksum!
```

### Adding Configuration Keys

```bash
# Add configuration key for your command
msreg -f example.msreg config add MY_CONFIG "default_value" "Configuration description" "utilities" "mycommand"

# View all config keys in your registry
msreg -f example.msreg config list
```

### Registry Maintenance

```bash
# Remove a command
msreg -f example.msreg remove mycommand:1.0.0

# Remove a config key
msreg -f example.msreg config remove MY_CONFIG

# Remove config from specific command only
msreg -f example.msreg config remove MY_CONFIG mycommand
```

### Workflow Example

Here's a complete workflow using msreg:

```bash
# 1. Create your script
cat > scripts/hello.sh << 'EOF'
#!/bin/sh
VERSION="1.0.0"
echo "$(ms config get HELLO_NAME 2>/dev/null || echo 'World'), hello!"
case "$1" in -v|--version) echo "hello v$VERSION"; exit 0;; esac
EOF

chmod +x scripts/hello.sh

# 2. Test it locally
./scripts/hello.sh

# 3. Push to your repository first
git add scripts/hello.sh
git commit -m "Add hello script"
git push

# 4. Add to registry automatically
msreg -f example.msreg add hello:1.0.0 https://raw.githubusercontent.com/your-username/your-repo/main/scripts/hello.sh
# Enter description: "Simple hello greeting"
# Enter category: "demo"  
# Enter script path: "scripts/hello.sh"

# 5. Add config for the script
msreg -f example.msreg config add HELLO_NAME "World" "Name to greet" "demo" "hello"

# 6. Commit registry changes
git add example.msreg
git commit -m "Add hello command to registry"
git push

# 7. Test installation
ms upgrade
ms install hello
hello  # Output: World, hello!

# 8. Test configuration
ms config set HELLO_NAME "Magic Scripts"
hello  # Output: Magic Scripts, hello!
```

## 🎯 Best Practices

### Script Guidelines

- **Always** include `--help` and `--version` options
- **Use** configuration variables for user-customizable values  
- **Follow** consistent color coding (see `msworld.sh` example)
- **Handle** errors gracefully with meaningful messages
- **Make** scripts portable (use POSIX shell, avoid bashisms)
- **Document** your scripts with clear descriptions

### Registry Guidelines

- **Use** semantic versioning (1.0.0, 1.0.1, etc.)
- **Update** checksums when scripts change
- **Group** related configurations by category
- **Write** clear, concise descriptions
- **Test** URLs before committing

### Repository Guidelines

- **Keep** the main branch stable
- **Tag** releases with version numbers
- **Use** descriptive commit messages
- **Update** documentation when adding features
- **Test** scripts before publishing

## 🔗 Links

- [Magic Scripts Main Repository](https://github.com/magic-scripts/ms)
- [Documentation](https://github.com/magic-scripts/ms/blob/main/README.md)

## 📄 License

This template is released under the MIT License. You're free to use it for any purpose.
