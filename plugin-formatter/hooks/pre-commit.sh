#!/bin/bash
# pre-commit hook for plugin-formatter
# Automatically validates plugin files before git commit

set -e

# Get the repository root
REPO_ROOT=$(git rev-parse --show-toplevel)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}🔍 Plugin Validation Pre-Commit Hook${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get list of modified plugin.json files
PLUGIN_JSONS=$(git diff --cached --name-only --diff-filter=ACM | grep '\.claude-plugin/plugin.json$' || true)

if [ -z "$PLUGIN_JSONS" ]; then
  echo -e "${GREEN}✅ No plugin files modified${NC}"
  exit 0
fi

# Locate validation scripts
SCRIPT_DIR="$REPO_ROOT/plugin-formatter/skills/plugin-formatter/scripts"

if [ ! -d "$SCRIPT_DIR" ]; then
  echo -e "${YELLOW}⚠️  Validation scripts not found, skipping validation${NC}"
  exit 0
fi

# Make scripts executable
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true

VALIDATION_FAILED=0

# Validate each modified plugin
for PLUGIN_JSON in $PLUGIN_JSONS; do
  # Get plugin directory (parent of .claude-plugin)
  PLUGIN_DIR=$(dirname "$(dirname "$PLUGIN_JSON")")
  PLUGIN_NAME=$(basename "$PLUGIN_DIR")

  echo -e "${BLUE}Validating: ${PLUGIN_NAME}${NC}"
  echo ""

  # Run validation scripts
  if ! "$SCRIPT_DIR/validate-naming.sh" "$REPO_ROOT/$PLUGIN_DIR" 2>&1 | head -20; then
    echo -e "${RED}❌ Naming validation failed for ${PLUGIN_NAME}${NC}"
    VALIDATION_FAILED=1
  fi

  echo ""

  if ! "$SCRIPT_DIR/validate-json.sh" "$REPO_ROOT/$PLUGIN_DIR" 2>&1 | head -20; then
    echo -e "${RED}❌ JSON validation failed for ${PLUGIN_NAME}${NC}"
    VALIDATION_FAILED=1
  fi

  echo ""

  if ! "$SCRIPT_DIR/validate-frontmatter.sh" "$REPO_ROOT/$PLUGIN_DIR" 2>&1 | head -20; then
    echo -e "${RED}❌ Frontmatter validation failed for ${PLUGIN_NAME}${NC}"
    VALIDATION_FAILED=1
  fi

  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $VALIDATION_FAILED -eq 1 ]; then
  echo -e "${RED}❌ COMMIT BLOCKED: Validation errors found${NC}"
  echo ""
  echo "Fix errors and try again, or use these commands:"
  echo "  • /validate-plugin - Check what needs fixing"
  echo "  • /fix-naming - Auto-fix naming issues"
  echo "  • /check-schema - Validate JSON schemas"
  echo ""
  echo "To bypass this hook (not recommended):"
  echo "  git commit --no-verify"
  echo ""
  exit 1
else
  echo -e "${GREEN}✅ All validations passed!${NC}"
  echo ""
  exit 0
fi
