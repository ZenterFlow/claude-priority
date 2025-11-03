# Automated Test Suite

Comprehensive automated testing for the Claude Priority marketplace and all plugins.

## Overview

The test suite validates all plugins and marketplace configuration to ensure they meet Claude Code marketplace standards before publishing.

## Files

- **`test-all.sh`** - Main test suite (bash script)
- **`test-all.bat`** - Windows wrapper (calls test-all.sh via Git Bash)
- **`TEST_README.md`** - This file

## Quick Start

### Linux / macOS / Git Bash
```bash
chmod +x test-all.sh
./test-all.sh
```

### Windows
```cmd
test-all.bat
```

## What Gets Tested

### For Each Plugin (plugin-formatter, claude-prioritise, example-plugin)

1. **Naming Conventions** (`validate-naming.sh`)
   - Plugin directory name is lowercase-with-hyphens
   - plugin.json name matches directory
   - All skill directories follow naming convention
   - Skill frontmatter names match directories
   - Agent file names follow convention

2. **JSON Schema** (`validate-json.sh`)
   - Valid JSON syntax
   - Required fields present: name, version, description, author
   - Author field is object (not string)
   - Semantic versioning (X.Y.Z)
   - Description length (10-200 characters)

3. **Frontmatter** (`validate-frontmatter.sh`)
   - All skill.md files have frontmatter
   - Required frontmatter fields: name, description, license
   - Frontmatter names match directory names
   - Description adequate length
   - Title headers match skill names

### Marketplace

4. **marketplace.json**
   - Valid JSON syntax
   - Required fields: name, owner, plugins
   - Proper structure

## Test Output

### Success
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧪 CLAUDE PRIORITY MARKETPLACE TEST SUITE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📦 Testing: plugin-formatter
✅ plugin-formatter: ALL TESTS PASSED

📦 Testing: claude-prioritise
✅ claude-prioritise: ALL TESTS PASSED

📦 Testing: example-plugin
✅ example-plugin: ALL TESTS PASSED

🏪 Testing: marketplace.json
✅ marketplace.json is valid JSON

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 FINAL TEST RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ SUCCESS: All tests passed!

Your marketplace is ready to publish:
  ✓ plugin-formatter validated
  ✓ claude-prioritise validated
  ✓ example-plugin validated
  ✓ marketplace.json validated

Next steps:
  1. Review changes: git status
  2. Commit changes: git add . && git commit -m 'your message'
  3. Push to GitHub: git push origin main
```

### Failure
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 FINAL TEST RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ FAILED: 3 error(s) found

Please fix the errors above before publishing.

Tips:
  • Use 'format this plugin' in Claude Code to auto-fix common issues
  • Review validation output for specific errors
  • Check CONTRIBUTING.md for guidelines
```

## Exit Codes

- **0** - All tests passed, ready to publish
- **1** - Tests failed, fix errors before publishing

## Features

### Cross-Platform Support
- Works on Linux, macOS, Windows (Git Bash), WSL
- Automatically finds Python (tries python3, python, py)
- Graceful degradation if Python not available

### Colored Output
- Green (✅) for success
- Red (❌) for errors
- Yellow (⚠️) for warnings
- Blue for section headers

### Detailed Error Reporting
- Shows exactly which validation failed
- Displays error messages from validation scripts
- Points to specific files/lines with issues
- Suggests fixes

### Smart Python Detection
Same cross-platform Python detection as validation scripts:
```bash
find_python() {
  for py in "python3" "python" "py"; do
    if command -v "$py" &> /dev/null; then
      if "$py" --version &> /dev/null; then
        echo "$py"
        return 0
      fi
    fi
  done
  return 1
}
```

## Integration with CI/CD

### GitHub Actions
The test suite mirrors what runs in `.github/workflows/validate-plugins.yml`:

```yaml
- name: Validate plugin-formatter
  run: |
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh plugin-formatter
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh plugin-formatter
```

Running `test-all.sh` locally ensures your changes will pass CI/CD.

### Pre-Commit Hook
Integrate with git pre-commit hook:

```bash
# .git/hooks/pre-commit
#!/bin/bash
./test-all.sh || exit 1
```

## Troubleshooting

### "Git Bash not found" (Windows)
**Solution**: Install Git for Windows from https://git-scm.com/download/win

Git Bash is included with Git for Windows and required to run bash scripts.

### "Python not found"
**Solution**: Install Python 3 from https://www.python.org/downloads/

Python is required for JSON validation. The test suite will skip JSON validation if Python is not available (with a warning).

### "Permission denied"
**Solution**: Make script executable:
```bash
chmod +x test-all.sh
```

### Tests fail but output unclear
**Solution**: Run individual validation scripts for detailed output:
```bash
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh plugin-formatter
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh plugin-formatter
```

## Development Workflow

### Before Committing
```bash
# 1. Make your changes
# ... edit files ...

# 2. Run tests
./test-all.sh

# 3. If tests pass, commit
git add .
git commit -m "Your message"

# 4. Push to GitHub
git push
```

### Before Publishing
```bash
# 1. Complete validation
./test-all.sh

# 2. Manual testing
/plugin marketplace add $(pwd)
/plugin install plugin-name@claude-priority
# ... test functionality ...

# 3. Final checks
git status  # Review changes
git log     # Check commits

# 4. Push
git push origin main
```

## Customization

### Adding New Plugins

When adding a new plugin, update `test-all.sh`:

```bash
# Add to the validation section
validate_plugin "your-new-plugin"
```

### Custom Validation

Add custom validation checks:

```bash
# In test-all.sh, add after marketplace.json validation
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}🔧 Custom Validation${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Your custom validation here
# ...
```

## Related Documentation

- **VALIDATION_GUIDE.md** - Comprehensive validation procedures
- **CONTRIBUTING.md** - Contribution guidelines
- **CLAUDE.md** - Repository guide for Claude Code instances
- **.github/workflows/validate-plugins.yml** - CI/CD configuration

## Version History

### v1.0.0 (2025-11-02)
- Initial automated test suite
- Cross-platform support (Linux, macOS, Windows)
- Colored output with clear pass/fail indicators
- Validates all 3 plugins + marketplace.json
- Integrates with existing validation scripts

## License

MIT License - See LICENSE file for details

---

**Happy Testing! 🧪**
