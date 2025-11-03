# Claude Prioritise

Intelligent project management with persistent tracking, GitHub integration, and automated workflow assistance.

## What This Plugin Provides

Comprehensive project status tracking, priority surfacing, and backlog management with slash commands, GitHub MCP integration, and context-aware hooks.

## Features

### Skills
- **project-status**: Assesses project status, surfaces priorities, and maintains persistent backlog

### Commands
- **`/show-status`**: Quick project status summary with tasks and priorities
- **`/update-backlog`**: Add new items to the ideas backlog with automatic numbering
- **`/prioritize`**: Analyze and re-order backlog items by priority (impact/effort/urgency)
- **`/generate-report`**: Create weekly/sprint reports from activity log

### GitHub Integration (MCP)
- Sync todo.md with GitHub Issues
- Track PR status in project reports
- Create issues from backlog items
- Link commits to tasks

### Hooks
- **user-prompt-submit**: Context-aware command suggestions based on user intent
- **tool-use**: Automatic workflow hints when editing persistence files

### Agent
- **claude-prioritise-tutor**: Interactive guide for project status and priority management

## Quick Start

### Check Status
```bash
# Quick status summary
/show-status

# Or natural language
What should I work on?
Show project status
```

### Manage Backlog
```bash
# Add items to backlog
/update-backlog

# Prioritize items
/prioritize

# Generate reports
/generate-report
```

### GitHub Integration

**Setup:**
1. Create GitHub Personal Access Token (repo, read:org, read:user scopes)
2. Set environment variable: `export GITHUB_TOKEN='your_token_here'`
3. Restart Claude Code

**Usage:**
- "Show my open GitHub issues"
- "Create issue from backlog item 5"
- "What PRs need review?"

## Persistence

The plugin automatically maintains state in `persistence/`:
- **log.md**: Continuous activity log (append-only)
- **ideas.md**: Backlog of ideas with status
- **todo.md**: Current task list

## Context-Aware Assistance

The hooks provide intelligent suggestions:
- Detects "what should I work on?" → suggests `/show-status`
- Detects backlog edits → suggests `/update-backlog`
- Detects priority questions → suggests `/prioritize`
- Detects GitHub queries → mentions MCP availability

## How to Use

1. **Check status**: `/show-status` or "What should I work on?"
2. **Add tasks**: `/update-backlog` or directly edit `persistence/ideas.md`
3. **Prioritize**: `/prioritize` to analyze and reorder
4. **Track progress**: Changes auto-tracked in `persistence/log.md`
5. **Generate reports**: `/generate-report` for weekly/sprint summaries

## Status

Active - 1 skill, 4 commands, 2 hooks, 1 MCP server, 1 agent

## Version

v3.1.0 (2025-11-03) - Added commands, GitHub MCP integration, and context-aware hooks
