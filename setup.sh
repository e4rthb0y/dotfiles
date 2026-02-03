#!/bin/bash

# Define variables
DOTFILES_DIR=~/dotfiles
BACKUP_DIR=~/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Backup directory created at $BACKUP_DIR"

# Function to create symlink
link_file() {
    local src="$1"
    local dest="$2"

    # If destination exists and is not a symlink, back it up
    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up existing $dest..."
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Create the symlink
    ln -sf "$src" "$dest"
    echo "Linked $src -> $dest"
}

# --- 1. Link Tmux ---
link_file "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

# --- 2. Link Shell (Bash) ---
# Detect if using Bash or Zsh and link accordingly
if [ -f "$DOTFILES_DIR/bashrc" ]; then
    link_file "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
    link_file "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
    source ~/.bashrc
fi

if [ -f "$DOTFILES_DIR/zshrc" ]; then
    link_file "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
fi

# --- 3. TPM Setup ---
# Ensure the folder structure exists
mkdir -p "$HOME/.tmux/plugins"

# --- 4. Link Neovim ---
# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Link the entire nvim directory
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "Setup complete! Restart your terminal."
