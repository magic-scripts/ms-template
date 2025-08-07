#!/bin/sh

# Magic Scripts World Greeting
# Simple example script that demonstrates configuration usage

VERSION="1.0.0"
SCRIPT_NAME="msworld"

show_help() {
    echo "$SCRIPT_NAME v$VERSION"
    echo "Simple world greeting script"
    echo ""
    echo "Usage:"
    echo "  $SCRIPT_NAME              Show greeting with configured word"
    echo "  $SCRIPT_NAME [word]       Show greeting with specified word"
    echo "  $SCRIPT_NAME --help       Show this help message"  
    echo "  $SCRIPT_NAME --version    Show version information"
    echo ""
    echo "Configuration:"
    echo "  Set your default word: ms config set MAGICSCRIPT_WORLD hello"
    echo ""
    echo "Examples:"
    echo "  $SCRIPT_NAME              # Uses configured word (default: sup)"
    echo "  $SCRIPT_NAME goodbye      # Shows: goodbye, world!"
}

show_version() {
    echo "$SCRIPT_NAME v$VERSION"
}

# Handle command line arguments
case "$1" in
    -h|--help|help)
        show_help
        exit 0
        ;;
    -v|--version|version)
        show_version
        exit 0
        ;;
    "")
        # Use configured word or default
        word=$(ms config get MAGICSCRIPT_WORLD 2>/dev/null || echo "sup")
        ;;
    *)
        # Use provided word
        word="$1"
        ;;
esac

# Output the greeting
echo "$word, world!"