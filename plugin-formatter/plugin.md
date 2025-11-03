# Plugin Formatter

## Purpose
Comprehensive plugin validation and formatting toolkit that ensures Claude Code plugins comply with marketplace guidelines through automated validation, commands, and hooks.

## Activation Triggers

### Skill Triggers
- "format this plugin"
- "fix plugin structure"
- "validate plugin format"
- "check plugin compliance"

### Commands
- `/validate-plugin` - Quick validation without modifications
- `/fix-naming` - Auto-fix naming convention violations
- `/check-schema` - Validate JSON schema compliance
- `/generate-template` - Create new plugin from template

## Topics Covered
- Plugin directory structure (agents, skills, commands, hooks, MCP)
- JSON schema validation (plugin.json, marketplace.json, .hooks.json, .mcp.json)
- Naming conventions (lowercase-with-hyphens pattern)
- Metadata completeness and format validation
- Skill and command frontmatter validation
- Documentation standards and best practices
- Git pre-commit validation
- Real-time editing assistance

## Workflow

### Validation Workflow
1. Scan plugin directory structure
2. Validate against Claude Code schemas
3. Identify and report issues by severity
4. Apply automatic fixes where possible
5. Generate comprehensive validation report

### Development Workflow
1. Create plugin with `/generate-template`
2. Edit files with real-time tool-use hints
3. Run `/validate-plugin` for quick checks
4. Fix issues with `/fix-naming` or `/check-schema`
5. Commit with automatic pre-commit validation

## Features

### Automated Hooks
- **pre-commit**: Validates plugins before git commits (blocks invalid commits)
- **tool-use**: Real-time validation hints when editing plugin files
- **user-prompt-submit**: Suggests validation commands based on user intent and queries

### Validation Scripts
- `validate-naming.sh`: Check naming conventions
- `validate-json.sh`: Validate JSON syntax and schemas
- `validate-frontmatter.sh`: Check markdown frontmatter

### Error Documentation
- Comprehensive error guide with fixes for all validation errors
- Quick fixes checklist for manual validation
- Automated fix suggestions in validation output

## Resources
- Claude Code Plugin Marketplace specifications
- JSON schemas for all plugin types
- Templates for standard files (skills, agents, commands, hooks, MCP)
- Formatting rules documentation
- Validation error guide with solutions

## Version History
- v3.1.1 (2025-11-03): Added user-prompt-submit hook for command discovery and intent-based suggestions
- v3.1.0 (2025-11-03): Added 4 slash commands and 2 hooks for enhanced automation and real-time validation
- v3.0.0 (2025-11-03): Version sync with full plugin type support (commands, hooks, MCP)
- v1.0.0 (2025-11-01): Initial release with full marketplace compliance validation
