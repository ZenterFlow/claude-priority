#!/bin/bash
# validate-naming.sh
# Validates that all directories and skill names follow lowercase-with-hyphens convention

set -e

PLUGIN_DIR="${1:-.}"
ERRORS=0
WARNINGS=0

echo "🔍 Validating naming conventions in: $PLUGIN_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Pattern for valid names: lowercase letters, numbers, and hyphens only
VALID_PATTERN='^[a-z0-9-]+$'

# Check plugin directory name
PLUGIN_NAME=$(basename "$PLUGIN_DIR")
if ! [[ "$PLUGIN_NAME" =~ $VALID_PATTERN ]]; then
  echo "❌ Plugin directory '$PLUGIN_NAME' violates naming convention"
  echo "   Must be lowercase-with-hyphens (pattern: ^[a-z0-9-]+$)"
  ((ERRORS++))
else
  echo "✅ Plugin directory name valid: $PLUGIN_NAME"
fi

# Check plugin.json name field
if [ -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
  PLUGIN_JSON_NAME=$(grep -oP '"name":\s*"\K[^"]+' "$PLUGIN_DIR/.claude-plugin/plugin.json" | head -1)
  if ! [[ "$PLUGIN_JSON_NAME" =~ $VALID_PATTERN ]]; then
    echo "❌ Plugin.json name '$PLUGIN_JSON_NAME' violates naming convention"
    ((ERRORS++))
  elif [ "$PLUGIN_JSON_NAME" != "$PLUGIN_NAME" ]; then
    echo "⚠️  Plugin.json name '$PLUGIN_JSON_NAME' doesn't match directory '$PLUGIN_NAME'"
    ((WARNINGS++))
  else
    echo "✅ Plugin.json name valid and matches directory"
  fi
fi

# Check skill directories
echo ""
echo "Checking skill directories..."
if [ -d "$PLUGIN_DIR/skills" ]; then
  for skill_dir in "$PLUGIN_DIR/skills"/*/ ; do
    if [ -d "$skill_dir" ]; then
      SKILL_NAME=$(basename "$skill_dir")

      if ! [[ "$SKILL_NAME" =~ $VALID_PATTERN ]]; then
        echo "❌ Skill directory '$SKILL_NAME' violates naming convention"
        echo "   Should be: $(echo "$SKILL_NAME" | tr '[:upper:]' '[:lower:]' | tr '_' '-')"
        ((ERRORS++))
      else
        echo "✅ Skill directory valid: $SKILL_NAME"

        # Check skill.md frontmatter name
        if [ -f "$skill_dir/skill.md" ]; then
          # Extract frontmatter name (between --- markers)
          FRONTMATTER_NAME=$(sed -n '/^---$/,/^---$/p' "$skill_dir/skill.md" | grep -oP '^name:\s*\K.+' | tr -d ' ')

          if [ -n "$FRONTMATTER_NAME" ] && [ "$FRONTMATTER_NAME" != "$SKILL_NAME" ]; then
            echo "  ⚠️  Frontmatter name '$FRONTMATTER_NAME' doesn't match directory '$SKILL_NAME'"
            ((WARNINGS++))
          elif [ -n "$FRONTMATTER_NAME" ]; then
            echo "  ✅ Frontmatter name matches directory"
          else
            echo "  ⚠️  No frontmatter name found in skill.md"
            ((WARNINGS++))
          fi
        fi
      fi
    fi
  done
else
  echo "⚠️  No skills/ directory found"
  ((WARNINGS++))
fi

# Check agent files
echo ""
echo "Checking agent files..."
if [ -d "$PLUGIN_DIR/agents" ]; then
  for agent_file in "$PLUGIN_DIR/agents"/*.md ; do
    if [ -f "$agent_file" ]; then
      AGENT_NAME=$(basename "$agent_file" .md)

      if ! [[ "$AGENT_NAME" =~ $VALID_PATTERN ]]; then
        echo "❌ Agent file '$AGENT_NAME.md' violates naming convention"
        ((ERRORS++))
      else
        echo "✅ Agent file valid: $AGENT_NAME.md"
      fi
    fi
  done
else
  echo "⚠️  No agents/ directory found"
  ((WARNINGS++))
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "❌ Errors: $ERRORS"
echo "⚠️  Warnings: $WARNINGS"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo ""
  echo "✅ All naming conventions are valid!"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo ""
  echo "✅ No blocking errors, but $WARNINGS warnings should be reviewed"
  exit 0
else
  echo ""
  echo "❌ Found $ERRORS naming convention errors that must be fixed"
  exit 1
fi
