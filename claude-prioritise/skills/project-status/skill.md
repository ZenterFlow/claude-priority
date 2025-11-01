---
name: project-status
description: Assess project activity, surface priorities, and maintain persistent backlog
license: MIT
---

# SKILL: project-status
One-command project status, priority surfacing and persistent backlog grooming.

## Purpose
Provide developers with instant context about:
- Current project status (what's done, in progress, not started)
- Last activity from persistent logs
- Suggested next steps based on priorities
- Synchronized backlog with GitHub

## Activation Triggers
- "What should I work on?"
- "Show project status"
- "Update backlog"
- "What's next?"
- "/prioritise"

## Behaviour

### 1. Persistent Storage
Maintains three key files in `persistence/` directory:
- **log.md**: Continuous activity log
- **ideas.md**: Backlog of ideas and features
- **todo.md**: Current task list with status

### 2. Status Assessment
1. Pull latest from GitHub
2. Read persistent files (log, ideas, todos)
3. Sync ideas into todo list
4. Extract last activity from log
5. Generate priority suggestions

### 3. Report Format
```
📊  Current status: 7 done, 2 in progress, 4 not started
🎯  Last activity:  Added OAuth wrapper to GitHubSkill
🚀  Suggested next steps:
- Write unit tests for MarkdownSkill
- Add marketplace icon in 3 sizes
- Update README with gif demo
```

### 4. Automatic Sync
- Ensures persistent files exist
- Syncs ideas from ideas.md into todo.md
- Appends activity log on each run
- Integrates with GitHub for latest context

## Workflow Steps
1. **Initialize**: Create persistence files if missing
2. **Sync**: Pull latest from GitHub
3. **Read**: Load log, ideas, and todos
4. **Process**: Sync ideas to todos, extract last activity
5. **Prioritize**: Generate top 3 suggested next steps
6. **Report**: Format and display status
7. **Log**: Append run to activity log

## Integration Points
- GitHub sync for up-to-date context
- Persistent markdown files for continuity
- Console output piping to log.md
- Compatible with existing project workflows

## Example Session

**User**: "What should I work on?"

**Skill**:
```
📊  Current status: 5 done, 1 in progress, 8 not started

🎯  Last activity:  Completed marketplace.json setup

🚀  Suggested next steps:
- Create plugin-formatter agent file
- Set up claude-prioritise plugin structure
- Test marketplace installation
```

## Version
v1.0.0 - Initial release for Claude Code Plugin Marketplace
