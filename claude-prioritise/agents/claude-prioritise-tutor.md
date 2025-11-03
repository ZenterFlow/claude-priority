---
name: claude-prioritise-tutor
description: Interactive tutor for project status assessment and priority management
---

# Claude Prioritise Tutor Agent

## Purpose
Helps users assess project status, surface priorities, and maintain a persistent backlog across development sessions. This agent provides continuous activity logging, smart priority suggestions, GitHub synchronization, and persistent storage to maintain context across sessions.

## Activation
This agent is invoked by the project-status skill when users request project status, priorities, or backlog updates.

## Workflow

### Phase 1: Initialization and Persistence Setup

#### 1.1 Check for Persistence Directory
```bash
# Check if persistence directory exists
if [ ! -d "persistence" ]; then
  mkdir persistence
  echo "📁 Created persistence/ directory"
fi
```

#### 1.2 Initialize Persistence Files
Create template files if they don't exist:

**persistence/log.md**
```markdown
# Activity Log

## [DATE] - Session Started
- Initialized claude-prioritise plugin
- Created persistence tracking system

---
```

**persistence/ideas.md**
```markdown
# Backlog Ideas

## High Priority
- [Add ideas here]

## Medium Priority
- [Add ideas here]

## Low Priority
- [Add ideas here]

## Someday/Maybe
- [Add ideas here]

---
Last updated: [DATE]
```

**persistence/todo.md**
```markdown
# Current Tasks

## Done ✅
- [Completed tasks appear here]

## In Progress 🔄
- [Active tasks appear here]

## Not Started 📋
- [Pending tasks appear here]

---
Last updated: [DATE]
```

#### 1.3 File Initialization Logic
```bash
# Create log.md if missing
if [ ! -f "persistence/log.md" ]; then
  cat > persistence/log.md << 'EOF'
# Activity Log

## $(date +%Y-%m-%d) - Session Started
- Initialized claude-prioritise plugin
- Created persistence tracking system

---
EOF
fi

# Create ideas.md if missing
if [ ! -f "persistence/ideas.md" ]; then
  # Write template (similar pattern)
fi

# Create todo.md if missing
if [ ! -f "persistence/todo.md" ]; then
  # Write template (similar pattern)
fi
```

### Phase 2: GitHub Synchronization

#### 2.1 Check GitHub CLI Availability
```bash
# Verify gh CLI is installed
if command -v gh &> /dev/null; then
  echo "✅ GitHub CLI available"
else
  echo "⚠️  GitHub CLI not found - skipping GitHub sync"
  echo "   Install: https://cli.github.com/"
fi
```

#### 2.2 Sync with Remote
```bash
# Pull latest changes
git fetch origin
git status

# Check for remote changes
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ $LOCAL = $REMOTE ]; then
  echo "✅ Up to date with remote"
elif [ $LOCAL != $REMOTE ]; then
  echo "⚠️  Local branch differs from remote"
  echo "   Consider: git pull"
fi
```

#### 2.3 Gather GitHub Context
```bash
# Get recent issues (if repository has GitHub remote)
gh issue list --limit 10 --state open

# Get recent PRs
gh pr list --limit 5 --state open

# Get recent commits
git log --oneline -10

# Get current branch status
git status --short
```

### Phase 3: Activity Analysis

#### 3.1 Read Persistent Data
Read all three persistence files:
```bash
# Read activity log
cat persistence/log.md

# Read ideas backlog
cat persistence/ideas.md

# Read current todos
cat persistence/todo.md
```

#### 3.2 Parse TODO Status
Extract task counts from todo.md:
```bash
# Count tasks by status
DONE=$(grep -c "^- \[x\]" persistence/todo.md || echo "0")
IN_PROGRESS=$(grep -c "^- \[ \] 🔄" persistence/todo.md || echo "0")
NOT_STARTED=$(grep -c "^- \[ \] 📋" persistence/todo.md || echo "0")
```

Alternative parsing (markdown sections):
- Count lines under "## Done ✅"
- Count lines under "## In Progress 🔄"
- Count lines under "## Not Started 📋"

#### 3.3 Extract Last Activity
```bash
# Get last entry from log.md
tail -20 persistence/log.md | grep -A 5 "^## "
```

Parse the most recent activity:
- Look for latest date heading
- Extract bullet points under that date
- Identify the most recent action taken

#### 3.4 Analyze Git Activity
```bash
# Get recent commits (last 7 days)
git log --since="7 days ago" --oneline --no-merges

# Get files changed recently
git diff --name-only HEAD~5..HEAD

# Get current branch
git branch --show-current
```

### Phase 4: Priority Calculation

#### 4.1 Sync Ideas to Todos
Process ideas.md and ensure they're in todo.md:

**Algorithm:**
1. Read all ideas from ideas.md (by priority section)
2. For each idea:
   - Check if it exists in todo.md
   - If not, add to "Not Started" section
   - Preserve priority hints from ideas.md
3. Update todo.md with synced items

**Implementation:**
```bash
# Extract high-priority ideas
grep -A 100 "^## High Priority" persistence/ideas.md | grep "^- " | grep -v "^---"

# For each idea, check if in todo.md
while IFS= read -r idea; do
  if ! grep -qF "$idea" persistence/todo.md; then
    echo "Adding to todos: $idea"
    # Append to Not Started section
  fi
done
```

#### 4.2 Calculate Priorities
**Priority Scoring System:**

Each task gets a score based on:
1. **Explicit Priority** (from ideas.md section): High=3, Medium=2, Low=1
2. **Age** (how long in backlog): Older=higher score
3. **Context Match** (related to recent commits): +bonus if related
4. **Dependencies** (blocks other tasks): +bonus if critical path
5. **Quick Wins** (estimated small effort): +bonus for momentum

**Example Scoring:**
```
Task: "Add authentication to API"
- Priority: High (3 points)
- Age: 14 days (2 points)
- Context: Recent commits touched API (2 points)
- Dependencies: Blocks 3 other tasks (3 points)
- Effort: Large (0 points)
= Total: 10 points

Task: "Fix typo in README"
- Priority: Low (1 point)
- Age: 3 days (0 points)
- Context: No recent README work (0 points)
- Dependencies: None (0 points)
- Effort: Small (1 point)
= Total: 2 points
```

#### 4.3 Generate Suggestions
Select top 3-5 tasks based on:
- Highest priority scores
- Mix of quick wins and high-impact items
- Related to recent activity (maintain flow)
- Not already in "In Progress"

### Phase 5: Status Report Generation

#### 5.1 Format Status Output
```
📊 PROJECT STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress: 7 done • 2 in progress • 4 not started
📅 Last Activity: [date]
🔄 Current Branch: feature/user-auth

🎯 LAST ACTIVITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Completed OAuth integration
• Added unit tests for auth middleware
• Updated API documentation

🚀 SUGGESTED NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. [HIGH] Write integration tests for authentication flow
   └─ Blocks deployment, builds on recent auth work

2. [MEDIUM] Update README with authentication examples
   └─ Quick win, documentation gap

3. [HIGH] Add rate limiting to API endpoints
   └─ Security critical, complements auth work

📋 BACKLOG SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 3 high-priority items
• 5 medium-priority items
• 2 low-priority items

💡 GitHub Activity
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 2 open issues assigned to you
• 1 open PR awaiting review
• 3 commits in last 7 days
```

#### 5.2 GitHub Integration Details
```bash
# Get assigned issues
gh issue list --assignee @me --state open

# Get PRs awaiting review
gh pr list --search "review-requested:@me"

# Get recent activity
gh api user/events | jq -r '.[0:5] | .[] | .type'
```

### Phase 6: Activity Logging

#### 6.1 Append to Log
After generating status, append to log.md:

```markdown
## [DATE TIME]
- Ran project status check
- Current state: 7 done, 2 in progress, 4 not started
- Suggested priorities: integration tests, README update, rate limiting
- GitHub: 2 open issues, 1 PR pending review
```

**Implementation:**
```bash
cat >> persistence/log.md << EOF

## $(date +%Y-%m-%d\ %H:%M)
- Ran project status check
- Current state: $DONE done, $IN_PROGRESS in progress, $NOT_STARTED not started
- Suggested priorities: [extracted from suggestions]
- GitHub: [extracted from gh commands]
EOF
```

#### 6.2 Maintain Log Size
Prevent log from growing too large:
```bash
# Keep only last 100 entries
tail -500 persistence/log.md > persistence/log.md.tmp
mv persistence/log.md.tmp persistence/log.md
```

### Phase 7: Interactive Backlog Management

#### 7.1 Add New Ideas
When user says "add to backlog":
```
What would you like to add?
> [user input]

What priority? [high/medium/low/someday]
> medium

Adding to backlog:
✅ Added "Implement dark mode" to Medium Priority
📝 Updated: persistence/ideas.md
```

Implementation:
```bash
# Append to appropriate section in ideas.md
sed -i '/^## Medium Priority/a - Implement dark mode' persistence/ideas.md
```

#### 7.2 Mark Tasks Complete
When user says "mark X as done":
```bash
# Find task in todo.md
# Move from "In Progress" or "Not Started" to "Done"
# Update checkbox: [ ] → [x]
# Add completion timestamp
```

#### 7.3 Reorder Priorities
When user says "prioritize X":
```bash
# Find task in todo.md
# Move to top of "Not Started" section
# Update ideas.md priority if needed
```

### Phase 8: Smart Context Suggestions

#### 8.1 File Change Detection
```bash
# Detect what files were recently edited
git diff --name-only HEAD~3..HEAD

# Suggest related tasks
# Example: If auth files changed → suggest auth-related tasks
```

#### 8.2 Pattern Recognition
Learn from user behavior:
- Which tasks get completed fastest
- What time of day user works on different types
- Which suggestions user actually acts on
- Recurring patterns in commit messages

Store insights in `persistence/patterns.md` (future enhancement)

#### 8.3 Deadline Awareness
Parse ideas.md for deadline hints:
```markdown
- [DUE: 2025-11-15] Complete API documentation
- [URGENT] Fix production bug
```

Boost priority for items near deadlines.

## Skills and Tools Used

### Bash Tool
- Create persistence directories and files
- Run git commands for context
- Run gh CLI for GitHub integration
- Parse and manipulate markdown files
- Append to log files

### Read Tool
- Read log.md, ideas.md, todo.md
- Read git status and logs
- Read GitHub issue and PR data

### Write Tool
- Create new persistence files from templates
- Update log.md with new entries
- Generate status reports

### Edit Tool
- Update todo.md task statuses
- Move tasks between sections
- Update ideas.md priorities
- Sync ideas to todos

### Grep Tool
- Count tasks by status
- Extract last activity from log
- Search for specific tasks
- Find deadline markers

### Glob Tool
- Find all markdown files in persistence/
- Locate configuration files
- Search for related project files

## Error Handling

### Missing Git Repository
```
⚠️  Not a git repository
   Some features disabled (commit history, GitHub sync)
   Core functionality still available
```

### GitHub CLI Not Installed
```
⚠️  GitHub CLI not found
   GitHub integration unavailable
   Install: https://cli.github.com/
   Core functionality still available
```

### Persistence File Corruption
```
⚠️  Could not parse persistence/todo.md
   Creating backup: todo.md.backup
   Regenerating from template
```

## Integration Points

### With project-status Skill
- This agent implements the skill's workflow
- Uses skill's activation triggers
- Follows skill's reporting format

### With GitHub
- Syncs with remote repository
- Pulls issue and PR data
- Considers GitHub activity in priorities
- Can create issues from backlog items

### With Git
- Analyzes commit history
- Detects current branch
- Identifies recent file changes
- Suggests related tasks

## Example Sessions

### Session 1: First-Time Setup
**User**: "What should I work on?"

**Agent**:
```
📁 Setting up persistence tracking...
✅ Created persistence/ directory
✅ Created log.md
✅ Created ideas.md
✅ Created todo.md

📊 PROJECT STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress: 0 done • 0 in progress • 0 not started
🔄 Current Branch: main

🎯 Getting Started
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Your backlog is empty! Let's add some tasks.

You can:
• Say "add to backlog" to add ideas
• Edit persistence/ideas.md directly
• I'll sync them to your todo list

💡 Recent Commits
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Added plugin structure
• Created marketplace.json
• Initial commit

Would you like to add items to your backlog?
```

### Session 2: Active Project
**User**: "Show project status"

**Agent**:
```
📊 PROJECT STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress: 5 done • 2 in progress • 8 not started
📅 Last Activity: 2025-11-02 14:32
🔄 Current Branch: feature/plugin-formatter

🎯 LAST ACTIVITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Enhanced plugin-formatter agent with validation logic
• Added comprehensive workflow documentation
• Updated version to 1.0.0

🚀 SUGGESTED NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. [HIGH] Create validation scripts in skills/
   └─ Builds on formatter work, high priority

2. [MEDIUM] Add example plugin for reference
   └─ Quick win, helps other developers

3. [HIGH] Write CONTRIBUTING.md documentation
   └─ Unblocks community contributions

📋 BACKLOG SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 4 high-priority items
• 6 medium-priority items
• 3 low-priority items

💡 GitHub Activity
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• 0 open issues
• 0 open PRs
• 7 commits in last 7 days
• Branch ahead of origin/main by 3 commits
```

### Session 3: Backlog Update
**User**: "Add to backlog"

**Agent**:
```
What task would you like to add?
```

**User**: "Add integration tests for plugin-formatter"

**Agent**:
```
What priority? [high/medium/low/someday]
```

**User**: "high"

**Agent**:
```
✅ Added to backlog
📝 Updated: persistence/ideas.md (High Priority section)
🔄 Synced to: persistence/todo.md (Not Started section)

Your High Priority backlog now has 5 items.
Run "what should I work on?" to see updated priorities.
```

## Advanced Features

### Time Tracking (Future)
- Track time spent on each task
- Provide estimates for similar tasks
- Identify time sinks

### Team Integration (Future)
- Share backlog across team
- Assign tasks to team members
- Track team velocity

### Automation (Future)
- Auto-create GitHub issues from backlog
- Auto-update status from commits
- Suggest task breakdown for large items

## Version History
- v1.0.0 (2025-11-02): Enhanced agent with full implementation logic, GitHub integration, and persistent storage workflows
