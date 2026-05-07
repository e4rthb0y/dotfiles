# Agent Bin

This directory contains executable scripts and environment utilities specifically designed for AI agents operating in this workspace.

## Scripts

### `agent-env.sh`
The primary environment configuration script. It MUST be sourced by the agent at the start of every session.

**Usage:**
```bash
source bin/agent-env.sh
```

**What it does:**
1. Calls the GitHub authentication service (`integrations/github/auth/run.sh`).
2. Parses the authentication JSON.
3. Exports critical environment variables:
   - `GITHUB_TOKEN` & `GH_TOKEN`: For use with `git` and the `gh` CLI.
   - `GIT_AUTHOR_NAME` & `GIT_COMMITTER_NAME`: Set to the bot's display name.
   - `GIT_AUTHOR_EMAIL` & `GIT_COMMITTER_EMAIL`: Set to the bot's noreply email.
4. Updates local `git config` for the current workspace to ensure identity consistency.

## Best Practices
- **Do not execute**: Always **source** `agent-env.sh` so that variables persist in the current shell.
- **Custom Tools**: New agent-specific utilities (CLIs, wrappers) should be placed here and documented.
