# GitHub Project & Issue Management Skill

This skill enables agents to autonomously manage their development lifecycle by integrating with GitHub Issues, Projects, and Pull Requests.

## Prerequisites
- The `gh` CLI must be installed.
- The agent MUST source the environment setup script before performing any GitHub or Git operations:
  ```bash
  source bin/agent-env.sh
  ```

## Workflows

### 1. Task Discovery & Selection
- **List Assigned Issues**: `gh issue list --assignee "@me"`
- **List Backlog**: `gh issue list`
- **View Project Items**: `gh project item-list <project-number> --owner <owner>`
- **View Issue Details**: `gh issue view <id>`

### 2. Task Lifecycle
- **Claim a Task**: `gh issue edit <id> --add-assignee "@me"`
- **Start Progress**: Add a comment to the issue: `gh issue comment <id> --body "Starting work on this task. Follow progress in PR [link]."`
- **Update Status**: If using Projects, use `gh project item-edit` to move items to "In Progress".

### 3. Development & Submission
- **Branching**: Always create a feature branch: `git checkout -b feature/issue-<id>`.
- **Committing**: Use conventional commits. The environment script handles your identity.
- **Pull Request**: Create a PR once the task is ready for review:
  ```bash
  gh pr create --title "Fix: [Task Name]" --body "Fixes #<id>\n\n### Changes\n- [ ] ..." --draft
  ```
- **Handoffs**: If stopping mid-task, push the branch and leave a detailed comment on the issue with the current state of work.

## Security & Best Practices
- **Token Protection**: Never print `GITHUB_TOKEN` or `GH_TOKEN`.
- **PR-First**: Never push directly to main/master branches.
- **Identity Consistency**: Always verify identity with `git config user.name` after sourcing the env script.
