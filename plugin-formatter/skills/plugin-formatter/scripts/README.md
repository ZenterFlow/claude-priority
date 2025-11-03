# Validation Scripts

These scripts provide automated validation for Claude Code plugins.

## Available Scripts

### 1. `validate-naming.sh`
Validates that all directories, files, and metadata follow lowercase-with-hyphens naming convention.

**Usage:**
```bash
./validate-naming.sh /path/to/plugin
```

**Checks:**
- Plugin directory name
- Plugin.json name field
- Skill directory names
- Skill frontmatter names
- Agent file names

### 2. `validate-json.sh`
Validates JSON syntax and schema compliance for plugin.json and marketplace.json.

**Usage:**
```bash
./validate-json.sh /path/to/plugin
```

**Checks:**
- JSON syntax validity
- Required fields present
- Author/owner field format (object vs string)
- Semantic versioning
- Description length
- Keywords format (array vs string)

### 3. `validate-frontmatter.sh`
Validates YAML frontmatter in all skill.md files.

**Usage:**
```bash
./validate-frontmatter.sh /path/to/plugin
```

**Checks:**
- Frontmatter block exists
- Required fields: name, description, license
- Name matches directory
- Description length
- License from valid enum
- Title heading format

## Running All Validations

To run all validations at once:

```bash
#!/bin/bash
PLUGIN_DIR="/path/to/plugin"

echo "Running all validations..."
./validate-naming.sh "$PLUGIN_DIR" && \
./validate-json.sh "$PLUGIN_DIR" && \
./validate-frontmatter.sh "$PLUGIN_DIR" && \
echo "✅ All validations passed!"
```

## Exit Codes

All scripts use standard exit codes:
- `0`: Success (all validations passed)
- `1`: Failure (errors found)

Warnings don't cause script failure but should be reviewed.

## Integration

### Git Pre-Commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit

./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh . && \
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh . && \
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh .

if [ $? -ne 0 ]; then
  echo "❌ Validation failed. Fix errors before committing."
  exit 1
fi
```

### CI/CD (GitHub Actions)
```yaml
- name: Validate Plugin Format
  run: |
    chmod +x plugin-formatter/skills/plugin-formatter/scripts/*.sh
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh .
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh .
    ./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh .
```

## Dependencies

- `bash` (version 4+)
- `python3` (for JSON validation)
- `grep`, `sed` (standard Unix tools)

## Notes

- Scripts are safe to run (read-only, no modifications)
- Can be run individually or combined
- Designed to work on Linux, macOS, and WSL
- For Windows native support, use Git Bash or WSL
