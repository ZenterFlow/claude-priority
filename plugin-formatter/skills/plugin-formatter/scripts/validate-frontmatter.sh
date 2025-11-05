#!/bin/bash
# validate-frontmatter.sh
# Validates frontmatter in all skill.md files

set -e

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INPUT VALIDATION (SECURITY: OWASP A03 - Injection Prevention)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PLUGIN_DIR="${1:-.}"

# Security: Prevent directory traversal
if [[ "$PLUGIN_DIR" == *".."* ]]; then
  echo "❌ Security Error: Directory traversal not allowed"
  exit 1
fi

# Security: Whitelist allowed path characters
if [[ ! "$PLUGIN_DIR" =~ ^[a-zA-Z0-9/_.-]+$ ]]; then
  echo "❌ Security Error: Invalid characters in path"
  exit 1
fi

# Validate directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "❌ Error: Directory does not exist: $PLUGIN_DIR"
  exit 1
fi

ERRORS=0
WARNINGS=0

echo "🔍 Validating frontmatter in: $PLUGIN_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Process each skill
if [ -d "$PLUGIN_DIR/skills" ]; then
  echo "Validating skill.md frontmatter..."
  echo ""
  for skill_dir in "$PLUGIN_DIR/skills"/*/; do
    if [ -d "$skill_dir" ]; then
      SKILL_NAME=$(basename "$skill_dir")
      SKILL_MD="$skill_dir/skill.md"

      echo "Checking skill: $SKILL_NAME"

      if [ ! -f "$SKILL_MD" ]; then
        echo "  ❌ skill.md not found"
        ((RRORS++)) || true
        continue
      fi

      # Check for frontmatter block
      if ! grep -q "^---$" "$SKILL_MD"; then
        echo "  ❌ No frontmatter found (missing --- markers)"
        ((RRORS++)) || true
        continue
      fi

      # Extract frontmatter (between first two --- markers)
      FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$SKILL_MD" | sed '1d;$d')

      if [ -z "$FRONTMATTER" ]; then
        echo "  ❌ Empty frontmatter"
        ((RRORS++)) || true
        continue
      fi

      # Check required fields
      HAS_NAME=false
      HAS_DESC=false
      HAS_LICENSE=false

      # Check name field
      if echo "$FRONTMATTER" | grep -q "^name:"; then
        FRONT_NAME=$(echo "$FRONTMATTER" | grep "^name:" | sed 's/name:\s*//' | tr -d ' ')

        if [ "$FRONT_NAME" != "$SKILL_NAME" ]; then
          echo "  ❌ Frontmatter name '$FRONT_NAME' doesn't match directory '$SKILL_NAME'"
          ((RRORS++)) || true
        else
          echo "  ✅ Frontmatter name matches directory"
        fi
      else
        echo "  ❌ Missing required field: name"
        ((RRORS++)) || true
      fi

      # Check description field
      if echo "$FRONTMATTER" | grep -q "^description:"; then
        DESC=$(echo "$FRONTMATTER" | grep "^description:" | sed 's/description:\s*//')
        DESC_LEN=${#DESC}

        if [ "$DESC_LEN" -lt 10 ]; then
          echo "  ❌ Description too short ($DESC_LEN chars, min 10)"
          ((RRORS++)) || true
        elif [ "$DESC_LEN" -gt 200 ]; then
          echo "  ⚠️  Description very long ($DESC_LEN chars, recommended max 200)"
          ((WARNINGS++)) || true
        else
          echo "  ✅ Description length valid: $DESC_LEN chars"
        fi
      else
        echo "  ❌ Missing required field: description"
        ((RRORS++)) || true
      fi

      # Check license field
      if echo "$FRONTMATTER" | grep -q "^license:"; then
        LICENSE=$(echo "$FRONTMATTER" | grep "^license:" | sed 's/license:\s*//' | tr -d ' ')

        # Check if license is from valid enum
        VALID_LICENSES="MIT Apache-2.0 GPL-3.0 BSD-3-Clause CC-BY-SA Unlicense"
        if echo "$VALID_LICENSES" | grep -qw "$LICENSE"; then
          echo "  ✅ License valid: $LICENSE"
        else
          echo "  ⚠️  License '$LICENSE' not in common list: $VALID_LICENSES"
          ((WARNINGS++)) || true
        fi
      else
        echo "  ❌ Missing required field: license"
        ((RRORS++)) || true
      fi

      # Check title heading
      if grep -q "^# SKILL: $SKILL_NAME" "$SKILL_MD"; then
        echo "  ✅ Title heading matches skill name"
      else
        echo "  ⚠️  Title heading doesn't match expected format: '# SKILL: $SKILL_NAME'"
        ((WARNINGS++)) || true
      fi

      echo ""
    fi
  done
else
  echo "ℹ️  No skills/ directory found (skipping skill frontmatter validation)"
fi

# Validate command frontmatter
if [ -d "$PLUGIN_DIR/commands" ]; then
  echo ""
  echo "Validating command frontmatter..."
  echo ""

  for cmd_file in "$PLUGIN_DIR/commands"/*.md; do
    if [ -f "$cmd_file" ]; then
      CMD_NAME=$(basename "$cmd_file" .md)

      echo "Checking command: $CMD_NAME"

      # Check for frontmatter block
      if ! grep -q "^---$" "$cmd_file"; then
        echo "  ❌ No frontmatter found (missing --- markers)"
        ((RRORS++)) || true
        continue
      fi

      # Extract frontmatter
      FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$cmd_file" | sed '1d;$d')

      if [ -z "$FRONTMATTER" ]; then
        echo "  ❌ Empty frontmatter"
        ((RRORS++)) || true
        continue
      fi

      # Check required description field
      if echo "$FRONTMATTER" | grep -q "^description:"; then
        DESC=$(echo "$FRONTMATTER" | grep "^description:" | sed 's/description:\s*//')
        DESC_LEN=${#DESC}

        if [ "$DESC_LEN" -lt 5 ]; then
          echo "  ❌ Description too short ($DESC_LEN chars, min 5)"
          ((RRORS++)) || true
        elif [ "$DESC_LEN" -gt 100 ]; then
          echo "  ⚠️  Description very long ($DESC_LEN chars, recommended max 100)"
          ((WARNINGS++)) || true
        else
          echo "  ✅ Description length valid: $DESC_LEN chars"
        fi
      else
        echo "  ❌ Missing required field: description"
        ((RRORS++)) || true
      fi

      echo ""
    fi
  done
else
  echo "ℹ️  No commands/ directory found (skipping command frontmatter validation)"
fi

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "❌ Errors: $ERRORS"
echo "⚠️  Warnings: $WARNINGS"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo ""
  echo "✅ All frontmatter is valid!"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo ""
  echo "✅ No blocking errors, but $WARNINGS warnings should be reviewed"
  exit 0
else
  echo ""
  echo "❌ Found $ERRORS frontmatter errors"
  exit 1
fi
