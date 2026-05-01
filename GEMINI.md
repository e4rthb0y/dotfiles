# Gemini Agent Protocol

Welcome to the dotfiles workspace. This project is optimized for agentic collaboration.

## Core Integration: GitHub
This workspace features a robust GitHub integration for task management, identity, and contributions.

### Mandatory Environment Setup
Before performing any git operations or using the `gh` CLI, you MUST source the environment setup script:
```bash
source bin/agent-env.sh
```
This script automatically:
1. Authenticates using the workspace's GitHub App.
2. Exports `GITHUB_TOKEN` and `GH_TOKEN`.
3. Configures your Git identity (`user.name`, `user.email`) to match the authenticated bot.

### Skills & Workflows
Refer to `.gemini/skills/github/SKILL.md` for detailed instructions on:
- Claiming and managing issues.
- Synchronizing project status.
- Creating pull requests and handling handoffs.

### Project Context
- **Neovim Configuration**: See `nvim/AGENTS.md` for nvim-specific protocols.
- **Architecture**: See `.agents/docs/architecture.md`.
