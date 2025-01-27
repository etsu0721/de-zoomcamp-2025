#!/bin/bash

# Define the output directory (absolute path)
OUTPUT_DIR="/Users/elijahsutton/Projects/de-zoomcamp-2025"

# Export environment requirements in pip compatible format
pip list --format=freeze > "$OUTPUT_DIR/requirements_pip.txt"
echo "Pip requirements saved to $OUTPUT_DIR/requirements_pip.txt"

# Export environment requirements in Conda compatible format
conda list --export > "$OUTPUT_DIR/requirements_conda.txt"
echo "Conda requirements saved to $OUTPUT_DIR/requirements_conda.txt"
