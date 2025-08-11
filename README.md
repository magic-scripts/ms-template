# ms-template - Magic Scripts Project Template

Template repository for creating custom Magic Scripts collections with example implementations and best practices.

## ✨ Features

- 🎯 **Complete Template**: Ready-to-use project structure for Magic Scripts
- ⚡ **Example Command**: Fully implemented `msworld` command showing best practices
- 🔧 **Installer Scripts**: Example install, uninstall, and update scripts with migration patterns
- 📋 **Registry System**: 2-tier registry configuration with versioning support

## 🚀 Installation

### Via Magic Scripts (Recommended)

```bash
# Install Magic Scripts system
curl -fsSL https://raw.githubusercontent.com/magic-scripts/ms/main/setup.sh | sh

# Install example command from template
ms reg add template https://raw.githubusercontent.com/magic-scripts/ms-template/main/example.msreg
ms upgrade
ms install msworld
```

### Fork for Your Own Project

```bash
# Fork this repository and clone
git clone git@github.com:your-username/my-scripts.git
cd my-scripts
```

## 📖 Usage

### Example Command (msworld)

```bash
# Use default world from configuration  
msworld

# Display specific world information
msworld mars

# Show current configuration
msworld --config
```

### Template Customization

See **[CREATE_YOUR_SCRIPTS.md](CREATE_YOUR_SCRIPTS.md)** for complete customization guide.

### Quick Customization

```bash
# 1. Edit registry file
nano example.msreg

# 2. Create your command scripts
cp scripts/msworld.sh scripts/mycommand.sh

# 3. Update version information
nano registry/mycommand.msver

# 4. Test locally
./scripts/mycommand.sh --help
```

### Options

| Option | Description | Default |
|--------|-------------|---------|
| `-h, --help` | Show help message | - |
| `-v, --version` | Show version information | - |
| `--config` | Show current configuration | - |

## ⚙️ Configuration

msworld uses the Magic Scripts configuration system:

```bash
# View configuration
ms config list | grep msworld

# Set configuration
ms config set MAGICSCRIPT_WORLD "hello"
```

### Available Configuration Keys

| Key | Description | Default | Category |
|-----|-------------|---------|----------|
| `MAGICSCRIPT_WORLD` | Default word for world greeting | `sup` | environment |

## 📚 Examples & Use Cases

### Learning Magic Scripts Development

This template demonstrates:
- Script structure and best practices
- Configuration system integration
- Registry and versioning setup
- Installer script patterns

```bash
# Study the example implementation
cat scripts/msworld.sh
cat installer/install.sh
cat registry/msworld.msver
```

### Creating Custom Automation

Use this template to build your own automation tools:

```bash
# Example: Database management scripts
# Example: Deployment automation
# Example: Development environment setup
```

## 🔧 Integration

### With Magic Scripts Ecosystem

ms-template integrates seamlessly with:
- **Magic Scripts Core**: Registry and configuration system
- **Other Commands**: Can reference shared configuration
- **CI/CD Systems**: Installable in automated environments

### Development Workflow

```bash
# Local development and testing
ms reg add local file:///path/to/your/example.msreg
ms install mycommand
mycommand test
```

## 🛠️ Development

### Building Your Scripts

```bash
git clone https://github.com/your-username/my-scripts.git
cd my-scripts
# Edit scripts in scripts/ directory
# Update registry files in registry/ directory
# Test with Magic Scripts system
```

### Template Structure

```
ms-template/
├── README.md              # This file
├── CREATE_YOUR_SCRIPTS.md # Detailed customization guide  
├── example.msreg          # Registry configuration
├── registry/              # Version definitions
├── scripts/               # Executable scripts
├── installer/             # Install/uninstall/update hooks
└── man/                   # Documentation
```

### Testing

```bash
# Test example command
msworld --version
msworld mars

# Test registry system
ms reg list
ms search msworld
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🔗 Related Projects

- **[magic-scripts/ms](https://github.com/magic-scripts/ms)** - Magic Scripts core system
- **[magic-scripts/licgen](https://github.com/magic-scripts/licgen)** - License generator
- **[magic-scripts/projinit](https://github.com/magic-scripts/projinit)** - Project initializer

---

Part of the [Magic Scripts](https://github.com/magic-scripts/ms) ecosystem.