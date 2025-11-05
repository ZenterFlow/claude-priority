#!/bin/bash
# user-prompt-submit hook for claude-prioritise
# Provides context-aware suggestions based on user messages

# Read user message
USER_MESSAGE=$(cat)
MESSAGE_LOWER=$(echo "$USER_MESSAGE" | tr '[:upper:]' '[:lower:]')

# Detect status/priority related queries
if echo "$MESSAGE_LOWER" | grep -qE "(what.*work|show.*status|project.*status|what.*priority|what.*next)"; then
  echo "💡 Quick command: /show-status for instant project status"
fi

# Detect backlog/ideas related queries
if echo "$MESSAGE_LOWER" | grep -qE "(add.*backlog|new.*idea|todo|task.*add)"; then
  echo "💡 Quick command: /update-backlog to add items efficiently"
fi

# Detect prioritization queries
if echo "$MESSAGE_LOWER" | grep -qE "(priorit|order|important|urgent)"; then
  echo "💡 Quick command: /prioritize to analyze and reorder backlog"
fi

# Detect reporting queries
if echo "$MESSAGE_LOWER" | grep -qE "(report|summary|weekly|sprint|progress)"; then
  echo "💡 Quick command: /generate-report for automated reports"
fi

# Detect GitHub-related queries
if echo "$MESSAGE_LOWER" | grep -qE "(github|issue|pull request|pr )"; then
  echo "💡 GitHub MCP is available - ask about issues, PRs, or commits"
fi

# Detect "resume" or "continue" - suggest checking status
if echo "$MESSAGE_LOWER" | grep -qE "^(resume|continue|where|what.*left)"; then
  echo "📋 Context: Check persistence/log.md, todo.md, and ideas.md"
  echo "💡 Quick command: /show-status to see where you left off"
fi

# Provide context if message is very short
MESSAGE_LENGTH=${#USER_MESSAGE}
if [ "$MESSAGE_LENGTH" -lt 5 ]; then
  echo "💡 Available commands:"
  echo "   /show-status - Project status summary"
  echo "   /update-backlog - Add backlog items"
  echo "   /prioritize - Analyze priorities"
  echo "   /generate-report - Create reports"
fi

# Always allow the message
exit 0
