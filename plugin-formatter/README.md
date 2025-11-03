# Plugin Formatter

Comprehensive plugin validation and formatting toolkit for Claude Code plugin development.

## What This Plugin Provides

This plugin provides automated validation, formatting, and development assistance for Claude Code plugins. It ensures plugins meet marketplace guidelines through skills, commands, and hooks.

## Features

### Skills
- **plugin-formatter**: Full validation and auto-formatting of plugin structure, naming, metadata, and documentation

### Commands
- **`/validate-plugin`**: Quick validation without modifications - check if your plugin is ready to publish
- **`/fix-naming`**: Auto-fix naming convention violations (CamelCase → kebab-case)
- **`/check-schema`**: Validate JSON schema compliance for plugin.json and marketplace.json
- **`/generate-template`**: Create a new plugin from scratch with proper structure

### Hooks
- **pre-commit**: Automatically validates plugin files before git commits (blocks invalid commits)
- **tool-use**: Provides real-time validation hints when editing plugin files
- **user-prompt-submit**: Suggests validation commands based on your questions and intent

### Agent
- **plugin-formatter-tutor**: Interactive guide for plugin formatting and validation workflows

## Quick Start

### Validation
```bash
# Quick validation check (no changes)
/validate-plugin

# Full formatting with auto-fixes
format this plugin
```

### Fixing Issues
```bash
# Fix naming conventions only
/fix-naming

# Check JSON schema compliance
/check-schema
```

### Creating New Plugins
```bash
# Generate a new plugin from template
/generate-template
```

## Automatic Validation

The pre-commit hook automatically validates plugins before commits:
- Runs all validation scripts (naming, JSON, frontmatter)
- Blocks commits with validation errors
- Provides actionable fix suggestions

To bypass (not recommended):
```bash
git commit --no-verify
```

## How to Use

1. **Navigate** to your plugin directory
2. **Run** validation: `/validate-plugin` or `format this plugin`
3. **Fix** issues: `/fix-naming` for naming, `/check-schema` for JSON
4. **Commit** with confidence - validation runs automatically

## Status

Active - 1 skill, 4 commands, 3 hooks, 1 agent

## Version

v3.1.0 (2025-11-03) - Added commands and hooks for enhanced automation
