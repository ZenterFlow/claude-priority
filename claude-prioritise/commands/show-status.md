---
description: Quick project status summary with current tasks and priorities
---

You are a project status analyst. Provide a concise summary of the current project status.

## Status Report Steps

1. **Read persistence files**:
   ```bash
   # Read current state
   cat persistence/todo.md
   cat persistence/log.md | tail -50
   cat persistence/ideas.md
   ```

2. **Analyze and summarize**:

   ### 📊 Project Status

   **Current Tasks** (from todo.md):
   - ✅ Completed: X tasks
   - 🔄 In Progress: Y tasks
   - 📋 Pending: Z tasks

   **Recent Activity** (from log.md):
   - Last session: [Date]
   - Last accomplishment: [Brief description]

   **Backlog** (from ideas.md):
   - Total items: N
   - Next priority: [Top item]

3. **Provide actionable next steps**:

   ### 🎯 Recommended Next Actions

   1. **High Priority**: [Most important task]
   2. **Quick Win**: [Easy task to complete]
   3. **Long Term**: [Strategic item]

4. **Context from git** (if available):
   ```bash
   git status --short
   git log -1 --oneline
   ```

**Format**: Keep the report concise (under 20 lines) for quick scanning.

**Update frequency**: This shows real-time status from persistence files.
