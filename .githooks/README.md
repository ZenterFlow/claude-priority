# Git Hooks

This directory contains git hooks for the claude-priority marketplace.

## Available Hooks

### pre-commit
Runs validation on all modified plugins before allowing commits.

**What it does:**
- Detects which plugins were modified
- Runs naming convention validation
- Validates JSON syntax and schema
- Checks frontmatter in skill.md files
- Validates marketplace.json (if modified)
- Blocks commit if errors are found

**Installation:**
```bash
# Option 1: Copy to .git/hooks
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Option 2: Use git config (Git 2.9+)
git config core.hooksPath .githooks
```

**Usage:**
Once installed, the hook runs automatically on `git commit`.

To bypass (not recommended):
```bash
git commit --no-verify
```

## Hook Output Example

```
🔍 Running pre-commit validation...

Modified plugins:
  • plugin-formatter
  • example-plugin

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Validating: plugin-formatter
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Checking naming conventions...
✅ Plugin directory name valid: plugin-formatter
✅ Plugin.json name valid and matches directory
✅ All naming conventions are valid!

2. Validating JSON files...
✅ plugin.json has valid JSON syntax
✅ All required fields present
✅ All JSON files are valid!

3. Checking frontmatter...
Checking skill: plugin-formatter
✅ Frontmatter name matches directory
✅ All frontmatter is valid!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 VALIDATION SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ All validations passed!

Proceeding with commit...
```

## Testing Hooks

Test the pre-commit hook without committing:
```bash
# Make some changes
echo "# Test" >> example-plugin/README.md

# Stage changes
git add example-plugin/README.md

# Test hook manually
.githooks/pre-commit

# If successful, commit
git commit -m "Test commit"
```

## Debugging

If the hook fails unexpectedly:

1. **Check script permissions:**
   ```bash
   ls -la .git/hooks/pre-commit
   # Should show: -rwxr-xr-x (executable)
   ```

2. **Test validation scripts directly:**
   ```bash
   ./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh plugin-formatter
   ```

3. **Check for syntax errors:**
   ```bash
   bash -n .githooks/pre-commit
   ```

4. **Run with debugging:**
   ```bash
   bash -x .githooks/pre-commit
   ```

## Customization

Edit `.githooks/pre-commit` to:
- Add custom validation rules
- Change error threshold
- Modify output format
- Add notifications (Slack, email, etc.)

## Best Practices

1. **Always install hooks** when cloning the repository
2. **Don't bypass validation** unless absolutely necessary
3. **Fix errors** rather than using `--no-verify`
4. **Update hooks** when validation requirements change
5. **Test hooks locally** before pushing

## CI/CD Integration

These hooks complement the GitHub Actions workflows in `.github/workflows/`:
- Hooks: Fast, local validation before commit
- Actions: Comprehensive validation on push/PR

Both use the same validation scripts for consistency.
