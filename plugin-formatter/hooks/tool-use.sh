#!/bin/bash
# tool-use hook for plugin-formatter
# Auto-validates when plugin files are modified

# Get tool information from environment variables
TOOL_NAME="${TOOL_NAME:-}"
TOOL_PARAMS="${TOOL_PARAMS:-}"

# Only act on Write and Edit tools
if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
  exit 0
fi

# Check if a plugin file is being modified
if echo "$TOOL_PARAMS" | grep -qE "(plugin\.json|skill\.md|\.claude-plugin)"; then

  # Extract file path from tool parameters
  FILE_PATH=$(echo "$TOOL_PARAMS" | grep -oP '"file_path":\s*"\K[^"]+' | head -1)

  if [ -z "$FILE_PATH" ]; then
    exit 0
  fi

  # Determine if this is a plugin file
  if echo "$FILE_PATH" | grep -q "\.claude-plugin/plugin\.json$"; then
    echo "💡 Tip: Plugin JSON modified - run /validate-plugin to check compliance"
    echo "   Or use /check-schema for detailed validation"
  fi

  if echo "$FILE_PATH" | grep -q "skill\.md$"; then
    echo "💡 Tip: Skill file modified - ensure frontmatter is complete"
    echo "   Run /validate-plugin to verify formatting"
  fi

  if echo "$FILE_PATH" | grep -qE "(commands/.*\.md|hooks/.*\.sh)$"; then
    echo "💡 Tip: Command/Hook file modified - validate with /validate-plugin"
  fi

  # Check for common issues
  if [ "$TOOL_NAME" = "Write" ] && echo "$FILE_PATH" | grep -q "plugin\.json$"; then
    # Check if content has author as string (common mistake)
    CONTENT=$(echo "$TOOL_PARAMS" | grep -oP '"content":\s*"\K.*(?=",\s*"file_path")' || true)
    if echo "$CONTENT" | grep -q '"author":\s*"[^"]*"'; then
      echo "⚠️  Warning: Author field should be an object, not a string"
      echo "   Example: {\"name\": \"Your Name\", \"email\": \"you@example.com\"}"
    fi
  fi

fi

# Check for naming convention violations in new files
if [ "$TOOL_NAME" = "Write" ]; then
  FILE_PATH=$(echo "$TOOL_PARAMS" | grep -oP '"file_path":\s*"\K[^"]+' | head -1)
  FILE_NAME=$(basename "$FILE_PATH")

  # Check if filename violates naming conventions
  if echo "$FILE_NAME" | grep -qE '[A-Z_]'; then
    SUGGESTED_NAME=$(echo "$FILE_NAME" | tr '[:upper:]' '[:lower:]' | tr '_' '-')
    echo "⚠️  Naming Convention: File name should be lowercase-with-hyphens"
    echo "   Current: $FILE_NAME"
    echo "   Suggested: $SUGGESTED_NAME"
    echo "   Use /fix-naming to rename automatically"
  fi
fi

# Always allow the operation
exit 0
