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


# --- 4. Link Taskwarrior & Timewarrior ---
# Create necessary directory structures
mkdir -p "$HOME/.task/hooks"
mkdir -p "$HOME/.timewarrior"

# Link configuration files
if [ -f "$DOTFILES_DIR/taskw/taskrc" ]; then
    link_file "$DOTFILES_DIR/taskw/taskrc" "$HOME/.taskrc"
fi

if [ -f "$DOTFILES_DIR/timew/timewarrior.conf" ]; then
    link_file "$DOTFILES_DIR/timew/timewarrior.conf" "$HOME/.timewarrior/timewarrior.conf"
fi

if [ -f "$DOTFILES_DIR/taskw/hooks/on-modify.timewarrior" ]; then
    link_file "$DOTFILES_DIR/taskw/hooks/on-modify.timewarrior" "$HOME/.task/hooks/on-modify.timewarrior"

    chmod +x "$HOME/.task/hooks/on-modify.timewarrior"
    echo "Hook permissions set: ~/.task/hooks/on-modify.timewarrior is now executable."
fi

VM_SRC="$DOTFILES_DIR/taskw/hooks/value_matrix.py"
TASK_HOOKS_DIR="$HOME/.task/hooks"

# 2. Make the source of truth executable
if [ -f "$VM_SRC" ]; then
    chmod +x "$VM_SRC"

    ln -sf "$VM_SRC" "$TASK_HOOKS_DIR/on-add.value_matrix.py"
    chmod +x "$HOME/.task/hooks/on-add.value_matrix.py"
    ln -sf "$VM_SRC" "$TASK_HOOKS_DIR/on-modify.value_matrix.py"
    chmod +x "$HOME/.task/hooks/on-modify.value_matrix.py"

    echo "Value Matrix Hook is now executable."
fi

# Link the entire nvim directory
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "Setup complete! Restart your terminal."
