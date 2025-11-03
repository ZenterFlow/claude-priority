# Local Validation Guide

Complete checklist for validating the claude-priority marketplace and all plugins locally before pushing to GitHub.

## Automated Test Suite (Recommended - 2 minutes)

The easiest way to validate everything at once:

### Linux / macOS / Git Bash
```bash
cd /path/to/claude-priority
chmod +x test-all.sh
./test-all.sh
```

### Windows (without Git Bash)
```cmd
cd C:\path\to\claude-priority
test-all.bat
```

**What it does:**
- ✅ Validates all 3 plugins (naming, JSON, frontmatter)
- ✅ Validates marketplace.json
- ✅ Provides colored output with clear pass/fail
- ✅ Shows detailed error messages if validation fails
- ✅ Works cross-platform (Linux, macOS, Windows)
- ✅ Automatically finds Python (python3, python, or py)
- ✅ Provides next steps after all tests pass

**Exit codes:**
- `0` - All tests passed, ready to publish
- `1` - Tests failed, errors need fixing

---

## Quick Manual Validation (5 minutes)

If you prefer to run validation scripts individually:

```bash
# Navigate to repository root
cd /path/to/claude-priority

# Validate plugin-formatter
echo "=== Validating plugin-formatter ==="
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh plugin-formatter

# Validate claude-prioritise
echo "=== Validating claude-prioritise ==="
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh claude-prioritise
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh claude-prioritise
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh claude-prioritise

# Validate example-plugin
echo "=== Validating example-plugin ==="
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh example-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh example-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh example-plugin

# Validate marketplace.json
echo "=== Validating marketplace.json ==="
python3 -m json.tool .claude-plugin/marketplace.json > /dev/null && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
```

## Comprehensive Validation (15 minutes)

### Step 1: File Structure Validation

```bash
# Check required directories exist
test -d ".claude-plugin" && echo "✅ .claude-plugin/" || echo "❌ Missing .claude-plugin/"
test -f ".claude-plugin/marketplace.json" && echo "✅ marketplace.json" || echo "❌ Missing marketplace.json"

# Check each plugin
for plugin in plugin-formatter claude-prioritise example-plugin; do
  echo "Checking $plugin..."
  test -d "$plugin" && echo "  ✅ Plugin directory exists" || echo "  ❌ Missing plugin directory"
  test -f "$plugin/.claude-plugin/plugin.json" && echo "  ✅ plugin.json exists" || echo "  ❌ Missing plugin.json"
  test -d "$plugin/skills" && echo "  ✅ skills/ directory exists" || echo "  ❌ Missing skills/"
  test -d "$plugin/agents" && echo "  ✅ agents/ directory exists" || echo "  ⚠️  No agents/ (optional)"
done
```

### Step 2: Naming Convention Validation

```bash
# Run naming validation on each plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh claude-prioritise
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh example-plugin
```

**What it checks:**
- ✅ Directory names are lowercase-with-hyphens
- ✅ Plugin.json name matches directory
- ✅ Skill directory names match frontmatter
- ✅ Agent file names follow convention

### Step 3: JSON Schema Validation

```bash
# Run JSON validation on each plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh claude-prioritise
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh example-plugin
```

**What it checks:**
- ✅ Valid JSON syntax
- ✅ Required fields present (name, version, description, author)
- ✅ Author field is object (not string)
- ✅ Semantic versioning (X.Y.Z)
- ✅ Description length (10-200 chars)

### Step 4: Frontmatter Validation

```bash
# Run frontmatter validation on each plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh claude-prioritise
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh example-plugin
```

**What it checks:**
- ✅ Frontmatter exists in all skill.md files
- ✅ Required fields: name, description, license
- ✅ Names match directory names
- ✅ Description length (10-200 chars)
- ✅ Title headers match skill names

### Step 5: Manual Plugin Testing

Test each plugin by installing locally:

```bash
# 1. Add marketplace
/plugin marketplace add $(pwd)

# 2. List available plugins
/plugin list

# 3. Install plugin-formatter
/plugin install plugin-formatter@claude-priority
/plugin enable plugin-formatter

# 4. Test plugin-formatter
# In Claude Code, type: "format this plugin"
# Expected: Formatter activates and offers to format

# 5. Install claude-prioritise
/plugin install claude-prioritise@claude-priority
/plugin enable claude-prioritise

# 6. Test claude-prioritise
# In Claude Code, type: "What should I work on?"
# Expected: Status report with suggestions

# 7. Install example-plugin
/plugin install example-plugin@claude-priority
/plugin enable example-plugin

# 8. Test example-plugin skills
# In Claude Code, type: "say hello"
# Expected: hello-world skill responds

# In Claude Code, type: "check system status"
# Expected: status-checker runs diagnostics

# In Claude Code, type: "help with example plugin"
# Expected: example-plugin-tutor agent activates
```

### Step 6: Git Hook Testing

Test the pre-commit hook:

```bash
# Install hook
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Make a test change
echo "# Test" >> example-plugin/README.md

# Stage the change
git add example-plugin/README.md

# Test hook (should run automatically on commit)
git commit -m "Test commit"

# If hook passes, commit succeeds
# If hook fails, check errors and fix

# Unstage if you don't want to commit
git restore --staged example-plugin/README.md
git restore example-plugin/README.md
```

### Step 7: GitHub Actions Simulation

Simulate what GitHub Actions will run:

```bash
# Make scripts executable (as GitHub Actions does)
chmod +x plugin-formatter/skills/plugin-formatter/scripts/*.sh

# Run the same validation GitHub Actions will run
echo "=== Running CI/CD Validation Simulation ==="

# plugin-formatter validation
echo "Validating plugin-formatter..."
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh plugin-formatter || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh plugin-formatter || exit 1

# claude-prioritise validation
echo "Validating claude-prioritise..."
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh claude-prioritise || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh claude-prioritise || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh claude-prioritise || exit 1

# example-plugin validation
echo "Validating example-plugin..."
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh example-plugin || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh example-plugin || exit 1
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh example-plugin || exit 1

# marketplace.json validation
echo "Validating marketplace.json..."
python3 -m json.tool .claude-plugin/marketplace.json > /dev/null || exit 1

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ All CI/CD validations passed!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
```

### Step 8: Documentation Review

Check that all documentation is up to date:

```bash
# Check critical files exist
test -f "README.md" && echo "✅ README.md" || echo "❌ Missing README.md"
test -f "CLAUDE.md" && echo "✅ CLAUDE.md" || echo "❌ Missing CLAUDE.md"
test -f "CONTRIBUTING.md" && echo "✅ CONTRIBUTING.md" || echo "❌ Missing CONTRIBUTING.md"
test -f "ARCHITECTURE.md" && echo "✅ ARCHITECTURE.md" || echo "❌ Missing ARCHITECTURE.md"
test -f "CHANGELOG.md" && echo "✅ CHANGELOG.md" || echo "❌ Missing CHANGELOG.md"
test -f "IMPROVEMENTS.md" && echo "✅ IMPROVEMENTS.md" || echo "❌ Missing IMPROVEMENTS.md"

# Check each plugin has documentation
for plugin in plugin-formatter claude-prioritise example-plugin; do
  echo "Checking $plugin documentation..."
  test -f "$plugin/README.md" && echo "  ✅ README.md" || echo "  ❌ Missing README.md"
  test -f "$plugin/plugin.md" && echo "  ✅ plugin.md" || echo "  ⚠️  Missing plugin.md (optional)"
done
```

---

## Complete Validation Checklist

Use this checklist before pushing:

### File Structure
- [ ] `.claude-plugin/marketplace.json` exists
- [ ] All 3 plugins have `.claude-plugin/plugin.json`
- [ ] All plugins have `skills/` directory with at least one skill
- [ ] All skills have `skill.md` file
- [ ] Root documentation files exist (README, CLAUDE, CONTRIBUTING, ARCHITECTURE, CHANGELOG)

### Naming Conventions
- [ ] All plugin directories are lowercase-with-hyphens
- [ ] All skill directories are lowercase-with-hyphens
- [ ] Plugin.json names match directory names
- [ ] Skill frontmatter names match directory names

### JSON Validation
- [ ] marketplace.json is valid JSON
- [ ] All plugin.json files are valid JSON
- [ ] All author/owner fields are objects (not strings)
- [ ] All versions are semantic (X.Y.Z)
- [ ] All descriptions are 10-200 characters

### Frontmatter Validation
- [ ] All skill.md files have frontmatter
- [ ] All have required fields: name, description, license
- [ ] Names match directory names exactly
- [ ] Descriptions are adequate length

### Functionality Testing
- [ ] Marketplace installs locally
- [ ] plugin-formatter installs and activates
- [ ] claude-prioritise installs and activates
- [ ] example-plugin installs and activates
- [ ] All skills respond to trigger phrases
- [ ] All agents activate correctly

### Git and CI/CD
- [ ] Pre-commit hook installed and tested
- [ ] Local CI/CD simulation passes
- [ ] No uncommitted changes (git status clean)
- [ ] Changelog updated with changes
- [ ] Version numbers consistent

---

## Automated Validation Script

Save this as `validate-all.sh` for one-command validation:

```bash
#!/bin/bash
# validate-all.sh - Complete validation of claude-priority marketplace

set -e

echo "🔍 Claude Priority Marketplace - Complete Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ERRORS=0

# Function to validate a plugin
validate_plugin() {
  local plugin=$1
  echo "📦 Validating: $plugin"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Naming
  ./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh "$plugin" || ((ERRORS++))

  # JSON
  ./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh "$plugin" || ((ERRORS++))

  # Frontmatter
  ./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh "$plugin" || ((ERRORS++))

  echo ""
}

# Validate each plugin
validate_plugin "plugin-formatter"
validate_plugin "claude-prioritise"
validate_plugin "example-plugin"

# Validate marketplace.json
echo "📋 Validating: marketplace.json"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
python3 -m json.tool .claude-plugin/marketplace.json > /dev/null || ((ERRORS++))
echo "✅ marketplace.json is valid JSON"
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 VALIDATION SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ]; then
  echo "✅ All validations passed!"
  echo ""
  echo "Ready to push to GitHub! 🚀"
  echo ""
  echo "Next steps:"
  echo "  git add ."
  echo "  git commit -m \"Your commit message\""
  echo "  git push"
  exit 0
else
  echo "❌ Found $ERRORS validation error(s)"
  echo ""
  echo "Please fix errors before pushing."
  exit 1
fi
```

Usage:
```bash
chmod +x validate-all.sh
./validate-all.sh
```

---

## Troubleshooting Common Issues

### Issue: "Command not found: python3"
**Solution**: Install Python 3 or use `python` instead:
```bash
# Try python instead of python3
python -m json.tool .claude-plugin/marketplace.json
```

### Issue: "Permission denied" on scripts
**Solution**: Make scripts executable:
```bash
chmod +x plugin-formatter/skills/plugin-formatter/scripts/*.sh
chmod +x .githooks/pre-commit
```

### Issue: "No such file or directory"
**Solution**: Ensure you're in the repository root:
```bash
cd /path/to/claude-priority
pwd  # Should end in /claude-priority
```

### Issue: Validation fails on Windows
**Solution**: Use Git Bash or WSL:
```bash
# Install Git Bash or WSL
# Run scripts in Git Bash or WSL terminal
```

---

## Pre-Push Checklist

Final checks before `git push`:

```bash
# 1. Run automated test suite
./test-all.sh  # Linux/macOS/Git Bash
# OR
test-all.bat   # Windows

# 2. Check git status
git status
# Should show only intended changes

# 3. Review changes
git diff

# 4. Stage changes
git add .

# 5. Test pre-commit hook
git commit -m "Your commit message"
# Hook runs automatically

# 6. If commit succeeds, push
git push origin main
```

---

## Success Indicators

You're ready to push when:

✅ All validation scripts pass with 0 errors
✅ Pre-commit hook runs successfully
✅ Plugins install and activate locally
✅ All skills respond to triggers
✅ All agents activate correctly
✅ Documentation is up to date
✅ Changelog includes your changes
✅ Git status shows only intended changes
✅ No uncommitted files

---

**Happy Validating! 🎉**
