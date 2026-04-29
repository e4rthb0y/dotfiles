# Project Architecture

This document outlines the design and organization of this standalone Neovim configuration.

## Directory Structure

```text
.
├── init.lua              # Entrypoint
├── lua/
│   ├── config/           # Core Neovim settings
│   │   ├── base.lua      # Options and UI2 enablement
│   │   ├── maps.lua      # Global keybindings
│   │   └── providers.lua # External provider (Python/Node) setup
│   ├── lsp/              # LSP logic
│   │   ├── completion.lua# nvim-cmp setup
│   │   ├── servers.lua   # Mason and lspconfig server list
│   │   ├── ui.lua        # Diagnostic and hover UI
│   │   └── settings/     # Per-server custom settings
│   └── plugins/          # Plugin specifications (Lazy.nvim)
│       ├── tree-sitter.lua # Main Treesitter config (main branch)
│       ├── lsp.lua       # Main LSP plugin config
│       └── snacks.lua    # UI and utility features
├── .agents/              # AI Agent workspace
│   ├── TODO.md           # Active backlog
│   └── docs/             # Granular technical specs
├── README.md             # Human documentation
└── AGENTS.md             # Agent protocol documentation
```

## Key Design Principles

1. **Portability:** The configuration uses `vim.fn.exepath` to find binaries, making it easy to clone and use on any machine without hardcoded paths.
2. **Native-First:** We prioritize Neovim 0.12's core features (UI2, built-in Treesitter, native folding) over plugin alternatives to keep the setup fast and stable.
3. **Modular Plugins:** Each plugin has its own file in `lua/plugins/` for easy management and troubleshooting.
4. **LSP/Treesitter Balance:** We use the native Treesitter engine for structural syntax and LSP for contextual semantic tokens, balancing the two via highlight priorities.

## Dependency Management

- **Plugins:** Managed by `lazy.nvim`.
- **LSP/Formatters:** Managed by `mason.nvim` and `mason-lspconfig.nvim`.
- **Parsers:** Managed by `nvim-treesitter` (main branch) with `auto_install = true`. Requires the `tree-sitter` CLI on the system path.
