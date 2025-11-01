---
name: plugin-formatter
description: Formats plugin folders and files according to Claude Code plugin marketplace guidelines
license: MIT
---

# SKILL: plugin-formatter
Automatically format plugin structures, skills, and marketplace files according to Claude Code specifications.

## Purpose
Take a plugin directory and ensure all files, metadata, and documentation conform to Claude Code plugin marketplace standards, including:
- Proper directory structure
- Correct JSON schema formats
- Consistent naming conventions (lowercase with hyphens)
- Complete metadata files
- Properly formatted skill.md files
- Updated README.md files

## Activation Triggers
- "format this plugin"
- "fix plugin structure"
- "validate plugin format"
- "standardize plugin files"
- "check plugin compliance"

## Behaviour

### 1. Initial Analysis
When given a plugin folder path:
1. Check for `.claude-plugin/plugin.json` (required)
2. List all agents in `agents/` directory
3. List all skills in `skills/` directory
4. Check for `README.md` and `plugin.md`
5. Report missing or malformed files

### 2. Formatting Actions

#### Plugin-Level Files
- **`.claude-plugin/plugin.json`**:
  - Ensure all required fields: `name`, `version`, `description`, `author`, `keywords`, `license`
  - Validate `agents` and `skills` paths
  - Check proper JSON formatting

- **`plugin.md`**:
  - Ensure sections: Purpose, Activation Triggers, Topics Covered, Workflow, Resources, Version History
  - Add any missing sections with placeholders

- **`README.md`**:
  - Ensure sections: Title, What This Plugin Teaches, Skills Included, Agent, How to Use, Status, Version
  - List all skills from `skills/` directory
  - Update skill count in Status line

#### Skill-Level Files
For each skill in `skills/`:
- **Directory name**: Convert to lowercase-with-hyphens
- **`skill.md`**:
  - Frontmatter with: `name`, `description`, `license`
  - Sections: Purpose/Behaviour, Triggers, Example usage
  - Ensure lowercase naming in frontmatter matches directory

- **`manifest.json`** (optional):
  - Fields: `name`, `description`, `version`, `triggers`
  - Ensure name matches directory

#### Marketplace-Level File
- **`.claude-plugin/marketplace.json`** (repository root):
  - Ensure `name`, `owner`, `description`, `version`, `plugins[]`
  - Each plugin entry has: `name`, `source`, `description`, `version`, `author`, `keywords`, `category`

### 3. Naming Convention Enforcement
- Convert all directory names to lowercase with hyphens
- Rename files if needed (e.g., `Chart-Correction.md` → `chart-correction.md`)
- Update all references in JSON files to match new names

### 4. Validation Rules

**Required Plugin Structure:**
```
plugin-name/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   └── plugin-name-tutor.md
├── skills/
│   ├── skill-one/
│   │   ├── skill.md (required)
│   │   └── manifest.json (optional)
│   └── skill-two/
│       └── skill.md
├── plugin.md
└── README.md
```

**Required Marketplace Structure:**
```
repository-root/
└── .claude-plugin/
    └── marketplace.json
```

### 5. Output Report
After formatting, provide:
1. ✅ Files corrected
2. 📝 Files created
3. ⚠️ Warnings or issues
4. 📊 Summary: X plugins, Y agents, Z skills processed

## Example Session

**User**: "format this plugin"

**Skill**:
```
Analyzing plugin at: ./01-chart-basics

Found:
- Plugin: chart-basics v0.1.0
- Agent: chart-basics-tutor.md
- Skills: 8 found

Actions taken:
✅ Renamed Chart-Correction-Decoder/ → chart-correction-decoder/
✅ Updated skill.md frontmatter: name "Chart-Correction-Decoder" → "chart-correction-decoder"
✅ Created missing manifest.json for chart-correction-decoder
✅ Updated README.md skills list (added 5 new skills)
✅ Updated plugin.md version history
✅ Validated plugin.json schema

Summary:
✅ 8 skills formatted
✅ 5 files renamed
✅ 2 documentation files updated
⚠️ 1 optional manifest.json created

Plugin is now compliant with Claude Code marketplace v0.1.1
```

## Workflow Steps

1. **Scan**: Walk directory tree, identify all plugin components
2. **Validate**: Check against schema requirements
3. **Transform**: Rename/reformat as needed
4. **Update**: Regenerate documentation to match current state
5. **Report**: Provide detailed change log

## Integration Points
- Can be run on single plugin or entire marketplace
- Validates against official Claude Code schemas
- Compatible with existing CI/CD validation
- Preserves custom content while fixing structure

## File Dependencies
- Templates in `.claude/skills/plugin-formatter/templates/`
- Schemas in `.claude/skills/plugin-formatter/schemas/`
- Validation rules in `.claude/skills/plugin-formatter/rules.md`

## Version
v1.0.0 - Initial formatter for Claude Code Plugin Marketplace v0.1.1
