#!/bin/bash

# msworld Install Script
# This is an install script - use this if you need to set up anything during installation

echo "This is an install script - use this if you need to set up anything during installation"

# Create man page for msworld
MANDIR="/usr/local/share/man/man1"
if [[ ! -d "$MANDIR" ]]; then
    echo "Creating man directory: $MANDIR"
    sudo mkdir -p "$MANDIR"
fi

# Create msworld.1 man page
echo "Installing man page for msworld..."
sudo tee "$MANDIR/msworld.1" > /dev/null << 'EOF'
.TH MSWORLD 1 "$(date +'%B %Y')" "msworld 1.0.0" "User Commands"
.SH NAME
msworld \- A magical world greeting script
.SH SYNOPSIS
.B msworld
[\fIOPTION\fR]...
.SH DESCRIPTION
msworld is a magical script that greets the world with customizable messages.
It demonstrates the magic scripts framework capabilities.
.SH OPTIONS
.TP
.B \-h, \-\-help
Display help information and exit
.TP
.B \-v, \-\-version
Display version information and exit
.SH ENVIRONMENT
.TP
.B MAGICSCRIPT_WORLD
Default greeting word (default: "sup")
.SH EXAMPLES
.TP
.B msworld
Greet the world with default message
.SH AUTHOR
Written by Magic Scripts Team
.SH SEE ALSO
.BR ms (1)
EOF

# Update man database
echo "Updating man database..."
sudo mandb -q 2>/dev/null || true

echo "msworld install script completed successfully"
