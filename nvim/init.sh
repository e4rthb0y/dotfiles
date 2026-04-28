#!/bin/bash
set -e

echo "Checking environment health..."

# Check Neovim version
NVIM_VERSION=$(nvim --version | head -n 1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
echo "Neovim version: $NVIM_VERSION"

# Check tree-sitter CLI
if command -v tree-sitter >/dev/null 2>&1; then
    echo "tree-sitter CLI: Found ($(tree-sitter --version))"
else
    echo "tree-sitter CLI: NOT FOUND (Required for Neovim 0.12 parsers)"
fi

# Check essential paths
[ -f "init.lua" ] && echo "init.lua: Found" || echo "init.lua: NOT FOUND"

echo "Environment check complete."
