# Gemini Agent Protocol: Neovim Config

Welcome, AI Collaborator. This project is optimized for agentic development. To maintain consistency across sessions, you MUST follow the **Streamlined Gemini Agent Protocol**.

## 1. Context Entrypoint
- **Roadmap:** Read `.agents/TODO.md` to see the current backlog and pending tasks.
- **History:** Run `git log -n 5` to see what was recently completed.
- **Architecture:** Read `.agents/docs/architecture.md` to understand the code structure.
- **Handoffs:** Check the current task in `TODO.md` for any `> Note:` blocks left by the previous agent.

## 2. Startup Sequence
1. **Verify Environment:** Run `./init.sh` to ensure `nvim` and `tree-sitter` CLI are healthy.
2. **Review Backlog:** Pick the top-most unchecked task in `.agents/TODO.md`.

## 3. Execution Cycle
1. **Implement:** Write targeted, surgical code changes.
2. **Verify:** Run the `Test` command specified for the task in `TODO.md`.
3. **Commit:** Use conventional commits (e.g., `feat: implemented feature X`).

## 4. Session Shutdown
1. **Update Backlog:** Mark the task as completed in `.agents/TODO.md` (e.g., change `[ ]` to `[x]`).
2. **Leave Handoffs:** If you are stopping mid-task, add a `> Note:` block under the task in `TODO.md`.
3. **Final Commit:** Ensure all changes are committed before ending the session.

## 5. Security & Principles
- **Root Lock:** Never read/write files outside of this directory.
- **No Hardcoding:** Ensure all paths are dynamically resolved (use `vim.fn.exepath`).
- **Convention First:** Adhere to the existing Lua structure and `lazy.nvim` patterns.
- **Native over Plugin:** Prefer Neovim 0.12 core features over adding new plugins.
