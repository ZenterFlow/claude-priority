# Plugin Formatter Rules

## Naming Conventions

### Directory Names
- **Format**: lowercase with hyphens
- **Pattern**: `^[a-z0-9-]+$`
- **Examples**:
  - ✅ `chart-basics`
  - ✅ `tidal-calculator`
  - ❌ `Chart_Basics`
  - ❌ `TidalCalculator`
  - ❌ `chart basics`

### File Names
- **skill.md**: Required, exactly this name
- **manifest.json**: Optional, exactly this name
- **plugin.json**: Required in `.claude-plugin/`
- **README.md**: Required at plugin root
- **plugin.md**: Optional documentation

## Required Plugin Structure

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json          (required)
├── agents/
│   └── plugin-name-tutor.md (recommended)
├── skills/
│   ├── skill-name/
│   │   ├── skill.md         (required)
│   │   └── manifest.json    (optional)
│   └── another-skill/
│       └── skill.md
├── plugin.md                (optional)
└── README.md                (required)
```

## skill.md Format

### Required Frontmatter
```yaml
---
name: skill-name          # lowercase-with-hyphens
description: brief desc   # 10-200 chars
license: MIT|CC-BY-SA     # valid license
---
```

### Required Sections
1. **Title**: `# SKILL: skill-name`
2. **Triggers**: List of activation phrases
3. **Behaviour**: How the skill works

### Optional Sections
- Purpose
- Example sessions
- File dependencies
- Integration notes

## plugin.json Format

### Required Fields
- `name`: string, lowercase-with-hyphens
- `version`: string, semantic version (x.y.z)
- `description`: string, 10-200 chars
- `author.name`: string

### Optional Fields
- `author.url`: URL
- `homepage`: URL
- `repository`: URL
- `license`: enum
- `keywords`: array of strings
- `agents`: path to agent file
- `skills`: path to skills directory

## README.md Format

### Required Sections
1. **Title**: `# Plugin NN: Name`
2. **Subtitle**: Description line
3. **What This Plugin Teaches**: Bullet list
4. **Skills Included**: Numbered list with descriptions
5. **How to Use**: Example questions
6. **Status**: Implementation status
7. **Version**: Version and date

## Marketplace Format

### marketplace.json Location
- **Path**: `.claude-plugin/marketplace.json` (repository root)

### Required Fields
- `name`: marketplace name
- `owner.name`: owner name
- `description`: marketplace description
- `version`: semantic version
- `plugins[]`: array of plugin entries

### Plugin Entry Fields
- `name`, `source`, `description`, `version`
- `author`, `keywords`, `category`

## Validation Checks

### File Existence
- [ ] `.claude-plugin/plugin.json` exists
- [ ] `README.md` exists
- [ ] At least one skill in `skills/` directory
- [ ] Each skill has `skill.md`

### Naming Validation
- [ ] All directory names are lowercase-with-hyphens
- [ ] Plugin name in plugin.json matches directory
- [ ] Skill names in frontmatter match directory names

### Schema Validation
- [ ] plugin.json validates against schema
- [ ] marketplace.json validates against schema
- [ ] All manifest.json files validate

### Content Validation
- [ ] README lists all skills
- [ ] Skill count matches actual skills
- [ ] Version numbers are consistent
- [ ] All required sections present

## Auto-Fix Actions

1. **Rename directories** to lowercase-with-hyphens
2. **Update references** in JSON files
3. **Regenerate README** skill lists
4. **Add missing frontmatter** to skill.md files
5. **Create manifest.json** if beneficial
6. **Update version history** in plugin.md
7. **Validate and fix** JSON formatting
8. **Convert string to object** for author/owner fields
9. **Convert object to proper format** if malformed

### String-to-Object Conversions

#### Author Field (plugin.json)
```javascript
// BEFORE (incorrect - string)
"author": "ZenterFlow"

// AFTER (correct - object)
"author": {
  "name": "ZenterFlow"
}
```

#### Owner Field (marketplace.json)
```javascript
// BEFORE (incorrect - string)
"owner": "ZenterFlow"

// AFTER (correct - object)
"owner": {
  "name": "ZenterFlow"
}
```

#### Detection & Conversion Logic
1. Check if `author` or `owner` is a string
2. If string, wrap in object: `{"name": <string-value>}`
3. If object missing `name` field, flag as error
4. If object has only `name`, that's valid
5. If object has `name` + `url`, that's also valid

## Error Handling

### Warnings (non-blocking)
- Missing optional files
- Inconsistent version numbers
- Missing optional metadata

### Errors (blocking)
- Invalid JSON syntax
- Missing required files
- Invalid naming patterns
- Schema validation failures
