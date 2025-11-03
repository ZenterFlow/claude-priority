#!/bin/bash
# user-prompt-submit hook for plugin-formatter
# Suggests validation commands based on user intent

# Read user message from stdin
USER_MESSAGE=$(cat)
MESSAGE_LOWER=$(echo "$USER_MESSAGE" | tr '[:upper:]' '[:lower:]')

# Validation queries
if echo "$MESSAGE_LOWER" | grep -qE "(validate|check|verify|lint).*plugin"; then
  echo "💡 Quick command: /validate-plugin for comprehensive checks"
  exit 0
fi

# Naming issues
if echo "$MESSAGE_LOWER" | grep -qE "(fix.*nam|renam|kebab|lowercase|camel.*case)"; then
  echo "💡 Quick command: /fix-naming to auto-fix naming conventions"
  exit 0
fi

# Schema/JSON validation
if echo "$MESSAGE_LOWER" | grep -qE "(schema|json.*valid|plugin.*json|check.*json)"; then
  echo "💡 Quick command: /check-schema for JSON validation"
  exit 0
fi

# Creating new plugin
if echo "$MESSAGE_LOWER" | grep -qE "(new plugin|create plugin|generate.*plugin|plugin.*template|start.*plugin)"; then
  echo "💡 Quick command: /generate-template to create plugin structure"
  exit 0
fi

# Format/formatting queries
if echo "$MESSAGE_LOWER" | grep -qE "(format.*plugin|plugin.*standard|plugin.*guideline)"; then
  echo "💡 This plugin enforces Claude Code marketplace standards"
  echo "   Use /validate-plugin to check compliance"
  exit 0
fi

# Error/issue queries
if echo "$MESSAGE_LOWER" | grep -qE "(plugin.*error|plugin.*issue|plugin.*problem|fix.*plugin)"; then
  echo "💡 Start with /validate-plugin to identify issues"
  echo "   Then use /fix-naming or /check-schema as needed"
  exit 0
fi

# Help queries
if echo "$MESSAGE_LOWER" | grep -qE "^(help|how|what.*command)" && echo "$MESSAGE_LOWER" | grep -q "plugin"; then
  echo "💡 Available commands:"
  echo "   /validate-plugin - Comprehensive validation"
  echo "   /fix-naming - Auto-fix naming issues"
  echo "   /check-schema - Validate JSON schemas"
  echo "   /generate-template - Create new plugin"
  exit 0
fi

# Marketplace/publishing queries
if echo "$MESSAGE_LOWER" | grep -qE "(publish|marketplace|submit.*plugin|ready.*publish)"; then
  echo "💡 Before publishing: /validate-plugin to ensure compliance"
  echo "   All plugins must pass validation before submission"
  exit 0
fi

# Always allow the message
exit 0
