# Neovim Configuration: Premium DX

A high-performance, standalone Neovim configuration optimized for **Neovim 0.12+**. This setup leverages core primitives to provide a "Premium" developer experience with minimal plugin bloat.

## 🚀 Key Features (Neovim 0.12+)

- **Native UI2:** A complete redesign of the core messaging system. No more "Press ENTER" prompts. Includes native command-line syntax highlighting and a buffer-based pager for long messages.
- **Async Tree-sitter:** Highlighting is now asynchronous. Massive files load instantly with regex and "pop" into Tree-sitter in the background.
- **Parser Management:** Leveraging the `main` branch of `nvim-treesitter` for a lightweight, modern experience.
- **Structural Awareness:** Includes `treesitter-context` for sticky function/class headers and native incremental selection (`v_an` / `v_in`).
- **Semantic Token Balancing:** Refined integration between LSP semantic tokens and Tree-sitter structural highlights.
- **Automated Agent Protocol:** Built-in documentation and backlog system for seamless collaboration with AI agents.

## 📦 Installation

### Prerequisites

1. **Neovim 0.12.0+**
2. **tree-sitter CLI** (Required for parser compilation):
   - `brew install tree-sitter`
   - `pacman -S tree-sitter`
   - `cargo install tree-sitter-cli`
3. **Nerd Font** (Optional, but recommended for icons)

### Setup

1. Clone this repository into your Neovim config directory:
   ```bash
   git clone https://github.com/your-repo/nvim.git ~/.config/nvim
   ```
2. Launch Neovim:
   ```bash
   nvim
   ```
3. Run `:TSUpdate` to install/update the essential parsers.

## 🛠️ Configuration Structure

- `lua/config/`: Core settings, keymaps, and providers.
- `lua/lsp/`: LSP server configurations and UI settings.
- `lua/plugins/`: Plugin specifications managed by `lazy.nvim`.
- `.agents/`: Backlog and documentation for AI collaborators.

## ⌨️ Essential Keybindings

- `<leader>a`: Toggle Aerial (Code outline)
- `gd`: Go to Definition
- `K`: LSP Hover
- `v_an`: Expand selection (Around node)
- `v_in`: Shrink selection (Inside node)
- `:Inspect`: View highlight groups at cursor
- `:InspectTree`: View AST for the current buffer

## 🤖 AI Collaboration

This project implements a streamlined **Gemini Agent Protocol**. AI collaborators should start by reading `AGENTS.md` and the `.agents/TODO.md` backlog.
