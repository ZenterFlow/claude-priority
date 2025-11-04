#!/bin/bash
# tool-use hook for claude-prioritise
# Automatically logs significant actions to persistence/log.md

# Get tool information
TOOL_NAME="${TOOL_NAME:-}"
TOOL_PARAMS="${TOOL_PARAMS:-}"

# Only act on specific tools
if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ] && [ "$TOOL_NAME" != "Bash" ]; then
  exit 0
fi

# Get the file path if it's a Write/Edit operation
FILE_PATH=""
if [ "$TOOL_NAME" = "Write" ] || [ "$TOOL_NAME" = "Edit" ]; then
  FILE_PATH=$(echo "$TOOL_PARAMS" | grep -oP '"file_path":\s*"\K[^"]+' | head -1)
fi

# Check for git commits (auto-log to persistence)
if [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_PARAMS" | grep -q "git commit"; then
  echo "💡 Tip: This commit will be tracked in project history"
  echo "   Use /generate-report to see all commits in a report"
fi

# Detect modifications to persistence files
if echo "$FILE_PATH" | grep -q "persistence/"; then
  FILENAME=$(basename "$FILE_PATH" 2>/dev/null || echo "")

  case "$FILENAME" in
    "todo.md")
      echo "📋 Updating task list - changes will be reflected in /show-status"
      ;;
    "ideas.md")
      echo "💡 Updating backlog - use /prioritize to reorder items"
      ;;
    "log.md")
      echo "📝 Adding to activity log - available in /generate-report"
      ;;
  esac
fi

# Suggest using commands for common operations
if [ "$TOOL_NAME" = "Bash" ]; then
  # Detect manual status checks
  if echo "$TOOL_PARAMS" | grep -qE "(cat.*persistence|ls.*persistence)"; then
    echo "💡 Quick tip: Use /show-status for a formatted project status"
  fi

  # Detect GitHub operations
  if echo "$TOOL_PARAMS" | grep -qE "(gh |git log|git status)"; then
    echo "💡 Tip: GitHub data is available via MCP - try \"show my GitHub issues\""
  fi
fi

# Detect backlog-related edits
if [ "$TOOL_NAME" = "Edit" ] && echo "$FILE_PATH" | grep -q "ideas.md"; then
  echo "💡 Tip: Use /update-backlog to add items with automatic numbering"
fi

# Always allow the operation
exit 0
