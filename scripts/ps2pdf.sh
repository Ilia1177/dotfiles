#!/bin/bash

# Check if Ghostscript is installed
if ! command -v gs &> /dev/null; then
    echo "Error: Ghostscript (gs) is not installed."
    echo "Install it with: brew install ghostscript"
    exit 1
fi

# Check if input file exists
if [ ! -f "$1" ]; then
    echo "Error: Input file '$1' not found."
    exit 1
fi

# Check if output filename is provided
if [ -z "$2" ]; then
    echo "Usage: ./ps2pdf.sh input.ps output.pdf"
    exit 1
fi

# Run Ghostscript conversion
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile="$2" "$1"

# Check if conversion succeeded
if [ $? -eq 0 ]; then
    echo "Success: PDF saved as '$2'"
else
    echo "Error: Conversion failed."
    exit 1
fi
