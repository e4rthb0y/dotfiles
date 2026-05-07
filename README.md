# dotfiles

Premium development environment substrate optimized for **Principal Engineers** and **AI Agents**.

This workspace is intended to provide a high-performance, transparent, and agent-aware configuration for shell, editor, and productivity tools.

## Core Pillars

- **Neovim (Premium DX)**: A high-performance, standalone Neovim configuration (0.12+) optimized for asynchronous performance and structural awareness. [Read more in `nvim/README.md`](./nvim/README.md).
- **Productivity Stack**: Integrated **Taskwarrior** and **Timewarrior** for seamless task management and time tracking with automated hooks.
- **Shell & Multiplexing**: Tailored **Bash** and **Tmux** configurations for efficient navigation and environment persistence.
- **Agent-First Architecture**: Native support for AI collaborators via the **Gemini Agent Protocol**, including automated GitHub authentication and identity management.

## Installation

### Prerequisites

- **Git**
- **Bash** (v4.0+)
- **GitHub CLI (`gh`)**
- **Neovim 0.12.0+** (Recommended)

### Setup

1. **Clone the repository**:

    ```bash
    git clone --recursive https://github.com/e4rthb0y/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2. **Run the setup script**:

    ```bash
    ./setup.sh
    ```

    _The script will create symlinks in your `$HOME` directory and backup existing configurations._

3. **Source your environment**:
    ```bash
    source ~/.bashrc
    ```

### WSL Note

If you are using WSL, ensure your `/etc/wsl.conf` is configured correctly for interoperability (required for plugins like `auto-dark-mode`). See [wsl.md](./wsl.md) for details.

## Agentic Protocol

This repository is built for **Agentic Collaboration**. AI agents must adhere to the protocols defined in [GEMINI.md](./GEMINI.md).

### Quick Start for Agents

1. **Authentication**: Always source the environment setup script before any git or GitHub operations:
    ```bash
    source ~/.agent-env.sh
    ```
2. **Workflow**: Follow the lifecycle defined in `.gemini/skills/development-workflow/SKILL.md`.
3. **Neovim Context**: Refer to `nvim/AGENTS.md` when working within the Neovim configuration.

## Repository Structure

```text
├── nvim/           # Neovim configuration (Submodule)
├── taskw/          # Taskwarrior configuration and custom hooks
├── timew/          # Timewarrior configuration
├── bin/            # Shared utility scripts
├── integrations/   # Custom integrations (e.g., GitHub Auth)
├── .gemini/        # Agent skills and configurations (The skills subdirectory is a submodule)
├── setup.sh        # Main installation script
└── GEMINI.md       # Root Agent Protocol
```

---

_Curated with precision for the next generation of software engineering._
