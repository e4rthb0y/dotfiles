#!/usr/bin/env bash

# This script should be sourced: source bin/agent-env.sh

# Resolve the physical path of this script to handle symlinks correctly
REAL_PATH=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPT_DIR=$(cd "$(dirname "$REAL_PATH")" && pwd)
DOTFILES_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
AUTH_SCRIPT="$DOTFILES_DIR/integrations/github/auth/run.sh"

if [ ! -f "$AUTH_SCRIPT" ]; then
    echo "Error: GitHub auth script not found at $AUTH_SCRIPT" >&2
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] && exit 1 || return 1
fi

# Get Auth Data in JSON format
if ! AUTH_JSON=$("$AUTH_SCRIPT") || [ -z "$AUTH_JSON" ]; then
    echo "Error: Failed to obtain GitHub authentication data." >&2
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] && exit 1 || return 1
fi

# Parse JSON using jq
GITHUB_TOKEN=$(echo "$AUTH_JSON" | jq -r '.token')
GIT_AUTHOR_NAME=$(echo "$AUTH_JSON" | jq -r '.name')
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL=$(echo "$AUTH_JSON" | jq -r '.email')
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

export GITHUB_TOKEN
export GIT_AUTHOR_NAME
export GIT_COMMITTER_NAME
export GIT_AUTHOR_EMAIL
export GIT_COMMITTER_EMAIL

# Configure git to use GitHub CLI as a credential helper if gh is available
if command -v gh >/dev/null 2>&1; then
    # gh auth setup-git requires an interactive session or specific config
    # We set GITHUB_TOKEN which gh CLI respects
    export GH_TOKEN="$GITHUB_TOKEN"
    
    # Set local git config for the session
    git config user.name "$GIT_AUTHOR_NAME"
    git config user.email "$GIT_AUTHOR_EMAIL"
    
    echo "Agent environment configured for: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
else
    echo "Warning: GitHub CLI (gh) not found. Some functionality may be limited."
fi
