#!/bin/bash
# validate-json.sh
# Validates plugin.json and marketplace.json against schemas

set -e

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INPUT VALIDATION (SECURITY: OWASP A03 - Injection Prevention)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PLUGIN_DIR="${1:-.}"

# Security: Prevent directory traversal attacks
if [[ "$PLUGIN_DIR" == *".."* ]]; then
  echo "❌ Security Error: Directory traversal not allowed"
  exit 1
fi

# Security: Whitelist allowed characters in path
if [[ ! "$PLUGIN_DIR" =~ ^[a-zA-Z0-9/_.-]+$ ]]; then
  echo "❌ Security Error: Invalid characters in path"
  exit 1
fi

# Validate directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "❌ Error: Directory does not exist: $PLUGIN_DIR"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_DIR="$SCRIPT_DIR/../schemas"
ERRORS=0

echo "🔍 Validating JSON files in: $PLUGIN_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Function to find a working Python executable (OS-independent)
find_python() {
  # Try common Python commands across different operating systems
  for py in "python3" "python" "py"; do
    if command -v "$py" &>/dev/null; then
      # Verify it's a real Python installation, not a stub/alias
      if "$py" --version &>/dev/null; then
        echo "$py"
        return 0
      fi
    fi
  done

  # No working Python found
  echo ""
  return 1
}

# Function to validate JSON syntax
validate_json_syntax() {
  local file=$1
  local python_cmd=$(find_python)

  if [ -z "$python_cmd" ]; then
    echo "❌ Python not found. Install Python 3 to enable JSON validation."
    echo "   Download: https://www.python.org/downloads/"
    echo "   Skipping JSON syntax validation for: $file"
    return 0 # Don't fail validation, just skip this check
  fi

  if ! $python_cmd -m json.tool "$file" >/dev/null 2>&1; then
    echo "❌ Invalid JSON syntax in: $file"
    $python_cmd -m json.tool "$file" 2>&1 | head -5
    return 1
  fi
  return 0
}

# Function to check author/owner field format
check_author_format() {
  local file=$1
  local field=$2 # "author" or "owner"

  # Check if field is a string (invalid) or object (valid)
  if grep -q "\"$field\":\s*\"" "$file"; then
    echo "  ❌ $field field is a string, should be object: {\"name\": \"...\"}"
    return 1
  elif grep -q "\"$field\":\s*{" "$file"; then
    echo "  ✅ $field field is correctly formatted as object"
    return 0
  fi
  return 0
}

# Validate plugin.json
echo "Checking plugin.json..."
PLUGIN_JSON="$PLUGIN_DIR/.claude-plugin/plugin.json"

if [ ! -f "$PLUGIN_JSON" ]; then
  echo "❌ plugin.json not found at: $PLUGIN_JSON"
  ((RRORS++)) || true
else
  if validate_json_syntax "$PLUGIN_JSON"; then
    echo "✅ plugin.json has valid JSON syntax"

    # Check required fields
    for field in "name" "version" "description" "author"; do
      if ! grep -q "\"$field\"" "$PLUGIN_JSON"; then
        echo "  ❌ Missing required field: $field"
        ((RRORS++)) || true
      else
        echo "  ✅ Required field present: $field"
      fi
    done

    # Check author format
    if ! check_author_format "$PLUGIN_JSON" "author"; then
      ((ERRORS++)) || true
    fi

    # Check version format (semantic versioning)
    VERSION=$(jq -r '.version // empty' "$PLUGIN_JSON" 2>/dev/null || echo "")
    if [ -z "$VERSION" ]; then
      echo "  ❌ Missing version field"
      ((ERRORS++)) || true
    elif [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "  ✅ Version format valid: $VERSION"
    else
      echo "  ❌ Version must be semantic (X.Y.Z): $VERSION"
      ((ERRORS++)) || true
    fi

    # Check description length
    DESC=$(jq -r '.description // empty' "$PLUGIN_JSON" 2>/dev/null || echo "")
    if [ -z "$DESC" ]; then
      echo "  ❌ Missing description field"
      ((ERRORS++)) || true
    else
      DESC_LEN=${#DESC}
      if [ $DESC_LEN -lt 10 ]; then
        echo "  ❌ Description too short ($DESC_LEN chars, min 10)"
        ((ERRORS++)) || true
      elif [ $DESC_LEN -gt 200 ]; then
        echo "  ⚠️  Description very long ($DESC_LEN chars, max recommended 200)"
      else
        echo "  ✅ Description length valid: $DESC_LEN chars"
      fi
    fi

  else
    ((ERRORS++)) || true
  fi
fi

# Validate hooks configuration (if exists)
echo ""
echo "Checking hooks configuration..."
HOOKS_JSON="$PLUGIN_DIR/.hooks.json"

if [ -f "$HOOKS_JSON" ]; then
  if validate_json_syntax "$HOOKS_JSON"; then
    echo "✅ .hooks.json has valid JSON syntax"

    # Check if hooks field exists
    if ! jq -e '.hooks' "$HOOKS_JSON" >/dev/null 2>&1; then
      echo "  ⚠️  .hooks.json missing 'hooks' field"
      ((ERRORS++)) || true
    else
      echo "  ✅ hooks field present"
    fi
  else
    ((ERRORS++)) || true
  fi
else
  echo "ℹ️  .hooks.json not found (optional)"
fi

# Validate MCP servers configuration (if exists)
echo ""
echo "Checking MCP servers configuration..."
MCP_JSON="$PLUGIN_DIR/.mcp.json"

if [ -f "$MCP_JSON" ]; then
  if validate_json_syntax "$MCP_JSON"; then
    echo "✅ .mcp.json has valid JSON syntax"

    # Check if mcpServers field exists
    if ! jq -e '.mcpServers' "$MCP_JSON" >/dev/null 2>&1; then
      echo "  ⚠️  .mcp.json missing 'mcpServers' field"
      ((ERRORS++)) || true
    else
      echo "  ✅ mcpServers field present"
    fi
  else
    ((ERRORS++)) || true
  fi
else
  echo "ℹ️  .mcp.json not found (optional)"
fi

# Validate marketplace.json (if exists)
echo ""
echo "Checking marketplace.json..."
MARKETPLACE_JSON="$PLUGIN_DIR/../.claude-plugin/marketplace.json"

if [ -f "$MARKETPLACE_JSON" ]; then
  if validate_json_syntax "$MARKETPLACE_JSON"; then
    echo "✅ marketplace.json has valid JSON syntax"

    # Check required fields
    for field in "name" "owner" "description" "version" "plugins"; do
      if ! jq -e ".$field" "$MARKETPLACE_JSON" >/dev/null 2>&1; then
        echo "  ❌ Missing required field: $field"
        ((ERRORS++)) || true
      else
        echo "  ✅ Required field present: $field"
      fi
    done

    # Check owner format
    if ! check_author_format "$MARKETPLACE_JSON" "owner"; then
      ((ERRORS++)) || true
    fi

    # Check version format
    VERSION=$(jq -r '.version // empty' "$MARKETPLACE_JSON" 2>/dev/null || echo "")
    if [ -z "$VERSION" ]; then
      echo "  ❌ Missing version field"
      ((ERRORS++)) || true
    elif [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      echo "  ✅ Version format valid: $VERSION"
    else
      echo "  ❌ Version must be semantic (X.Y.Z): $VERSION"
      ((ERRORS++)) || true
    fi

  else
    ((ERRORS++)) || true
  fi
else
  echo "ℹ️  marketplace.json not found (optional if not marketplace root)"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "❌ Errors: $ERRORS"

if [ $ERRORS -eq 0 ]; then
  echo ""
  echo "✅ All JSON files are valid!"
  exit 0
else
  echo ""
  echo "❌ Found $ERRORS JSON validation errors"
  exit 1
fi
