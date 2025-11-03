#!/bin/bash
# test-all.sh
# Comprehensive test suite for all plugins in claude-priority marketplace
# Run this locally before pushing to ensure everything passes

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TOTAL_ERRORS=0
TOTAL_WARNINGS=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 CLAUDE PRIORITY MARKETPLACE TEST SUITE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get script directory and repository root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VALIDATOR_DIR="$REPO_ROOT/plugin-formatter/skills/plugin-formatter/scripts"

# Make validators executable
chmod +x "$VALIDATOR_DIR"/*.sh 2>/dev/null || true

# Function to run validation for a plugin
validate_plugin() {
  local plugin_name=$1
  local plugin_dir="$REPO_ROOT/$plugin_name"

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e "${BLUE}📦 Testing: $plugin_name${NC}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  local plugin_errors=0

  # Test 1: Naming Conventions
  echo -e "${YELLOW}[1/3] Naming Conventions${NC}"
  if "$VALIDATOR_DIR/validate-naming.sh" "$plugin_dir"; then
    echo -e "${GREEN}✅ Naming validation passed${NC}"
  else
    echo -e "${RED}❌ Naming validation failed${NC}"
    ((plugin_errors++))
  fi
  echo ""

  # Test 2: JSON Schema
  echo -e "${YELLOW}[2/3] JSON Schema${NC}"
  if "$VALIDATOR_DIR/validate-json.sh" "$plugin_dir"; then
    echo -e "${GREEN}✅ JSON validation passed${NC}"
  else
    echo -e "${RED}❌ JSON validation failed${NC}"
    ((plugin_errors++))
  fi
  echo ""

  # Test 3: Frontmatter
  echo -e "${YELLOW}[3/3] Frontmatter${NC}"
  if "$VALIDATOR_DIR/validate-frontmatter.sh" "$plugin_dir"; then
    echo -e "${GREEN}✅ Frontmatter validation passed${NC}"
  else
    echo -e "${RED}❌ Frontmatter validation failed${NC}"
    ((plugin_errors++))
  fi
  echo ""

  if [ $plugin_errors -eq 0 ]; then
    echo -e "${GREEN}✅ $plugin_name: ALL TESTS PASSED${NC}"
  else
    echo -e "${RED}❌ $plugin_name: $plugin_errors test(s) failed${NC}"
    ((TOTAL_ERRORS+=plugin_errors))
  fi

  return $plugin_errors
}

# Test marketplace.json
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}🏪 Testing: marketplace.json${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

MARKETPLACE_JSON="$REPO_ROOT/.claude-plugin/marketplace.json"

# Find Python (using same logic as validate-json.sh)
find_python() {
  for py in "python3" "python" "py"; do
    if command -v "$py" &> /dev/null; then
      if "$py" --version &> /dev/null; then
        echo "$py"
        return 0
      fi
    fi
  done
  echo ""
  return 1
}

PYTHON_CMD=$(find_python)

if [ -z "$PYTHON_CMD" ]; then
  echo -e "${RED}❌ Python not found. Install Python 3 to validate marketplace.json${NC}"
  echo "   Download: https://www.python.org/downloads/"
  ((TOTAL_ERRORS++))
else
  if $PYTHON_CMD -m json.tool "$MARKETPLACE_JSON" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ marketplace.json is valid JSON${NC}"

    # Check required fields
    if grep -q '"name"' "$MARKETPLACE_JSON" && \
       grep -q '"owner"' "$MARKETPLACE_JSON" && \
       grep -q '"plugins"' "$MARKETPLACE_JSON"; then
      echo -e "${GREEN}✅ marketplace.json has required fields${NC}"
    else
      echo -e "${RED}❌ marketplace.json missing required fields${NC}"
      ((TOTAL_ERRORS++))
    fi
  else
    echo -e "${RED}❌ marketplace.json has invalid JSON syntax${NC}"
    $PYTHON_CMD -m json.tool "$MARKETPLACE_JSON" 2>&1 | head -10
    ((TOTAL_ERRORS++))
  fi
fi

# Test each plugin
validate_plugin "plugin-formatter"
validate_plugin "claude-prioritise"
validate_plugin "example-plugin"

# Final Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 FINAL TEST RESULTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $TOTAL_ERRORS -eq 0 ]; then
  echo -e "${GREEN}✅ SUCCESS: All tests passed!${NC}"
  echo ""
  echo "Your marketplace is ready to publish:"
  echo "  ✓ plugin-formatter validated"
  echo "  ✓ claude-prioritise validated"
  echo "  ✓ example-plugin validated"
  echo "  ✓ marketplace.json validated"
  echo ""
  echo "Next steps:"
  echo "  1. Review changes: git status"
  echo "  2. Commit changes: git add . && git commit -m 'your message'"
  echo "  3. Push to GitHub: git push origin main"
  echo ""
  exit 0
else
  echo -e "${RED}❌ FAILED: $TOTAL_ERRORS error(s) found${NC}"
  echo ""
  echo "Please fix the errors above before publishing."
  echo ""
  echo "Tips:"
  echo "  • Use 'format this plugin' in Claude Code to auto-fix common issues"
  echo "  • Review validation output for specific errors"
  echo "  • Check CONTRIBUTING.md for guidelines"
  echo ""
  exit 1
fi
