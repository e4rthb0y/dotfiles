# Agent Backlog

- [x] **Task:** Sanitize providers.lua
  - **Description:** Replace hardcoded macOS Python path with dynamic executable resolution (`vim.fn.exepath('python3')`) to ensure cross-platform portability.
  - **Test:** `nvim --headless -c "lua print(vim.g.python3_host_prog)" -c "q" 2>&1 | grep -v "Users"`

- [x] **Task:** Create README.md
  - **Description:** Write comprehensive human documentation for the standalone Neovim configuration, highlighting Neovim 0.12 features.
  - **Test:** `ls README.md`

- [x] **Task:** Create AGENTS.md
  - **Description:** Document the Streamlined Gemini Agent Protocol for future AI collaborators.
  - **Test:** `grep "Protocol" AGENTS.md`

- [x] **Task:** Create .agents/docs/architecture.md
  - **Description:** Detail the internal Lua structure of the project.
  - **Test:** `ls .agents/docs/architecture.md`

- [x] **Task:** Create init.sh
  - **Description:** Implement a health check script for the environment.
  - **Test:** `./init.sh`
