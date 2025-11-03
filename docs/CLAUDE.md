# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code Plugin Marketplace** containing three plugins:
1. **plugin-formatter**: Validates and formats Claude Code plugins according to marketplace guidelines
2. **claude-prioritise**: Provides project status assessment, priority surfacing, and persistent backlog management
3. **example-plugin**: Reference implementation demonstrating all marketplace features and best practices

The repository serves dual purposes:
- **User-facing**: A local marketplace providing development workflow plugins
- **Developer-facing**: A comprehensive example implementation with validation tools, documentation, and automated testing

## Repository Structure

```
claude-priority/                    # Marketplace root
├── .claude-plugin/
│   └── marketplace.json           # Marketplace metadata
├── .github/workflows/             # CI/CD automation
│   ├── validate-plugins.yml      # Plugin validation on push/PR
│   └── test-installation.yml     # Cross-platform installation tests
├── .githooks/                     # Git hooks
│   ├── pre-commit                # Pre-commit validation
│   └── README.md                 # Hook installation guide
├── docs/                          # Documentation
│   ├── CLAUDE.md                 # This file - Guide for Claude Code
│   ├── CONTRIBUTING.md           # Contribution guidelines
│   ├── VALIDATION_GUIDE.md       # Local validation procedures
│   ├── ARCHITECTURE.md           # System architecture
│   ├── CHANGELOG.md              # Version history
│   ├── IMPROVEMENTS.md           # Enhancement log
│   ├── INSTALLATION_GUIDE.md     # User installation guide
│   ├── TESTING_CHECKLIST.md      # Testing procedures
│   ├── SUMMARY.md                # Project summary
│   ├── DEV_REPO_SETUP.md         # Development repository setup guide
│   ├── PRODUCTION_CLEANUP.md     # Production cleanup procedures
│   ├── DEPLOYMENT_GUIDE.md       # Deployment strategies
│   └── PUBLIC_MARKETPLACE_STRATEGY.md  # Public marketplace considerations
├── tests/                         # Automated test suite
│   ├── test-all.sh               # Test runner (Linux/macOS/Git Bash)
│   ├── test-all.bat              # Test runner (Windows)
│   └── TEST_README.md            # Test suite documentation
├── persistence/                   # Project tracking
│   ├── log.md                    # Activity log
│   ├── ideas.md                  # Project ideas backlog
│   └── todo.md                   # Project tasks
├── plugin-formatter/              # Plugin 1: Formatting & validation
│   ├── .claude-plugin/plugin.json
│   ├── agents/plugin-formatter-tutor.md
│   ├── skills/plugin-formatter/
│   │   ├── skill.md              # Skill definition
│   │   ├── rules.md              # Validation rules
│   │   ├── schemas/              # JSON schemas
│   │   ├── scripts/              # Validation scripts
│   │   │   ├── validate-naming.sh
│   │   │   ├── validate-json.sh
│   │   │   └── validate-frontmatter.sh
│   │   └── templates/            # Template files
│   └── README.md
├── claude-prioritise/             # Plugin 2: Task management
│   ├── .claude-plugin/plugin.json
│   ├── agents/claude-prioritise-tutor.md
│   ├── skills/project-status/skill.md
│   ├── persistence/               # Auto-created storage
│   │   ├── log.md                # Activity log
│   │   ├── ideas.md              # Backlog ideas
│   │   └── todo.md               # Current tasks
│   └── README.md
├── example-plugin/                # Plugin 3: Reference implementation
│   ├── .claude-plugin/plugin.json
│   ├── agents/example-plugin-tutor.md
│   ├── skills/
│   │   ├── hello-world/skill.md
│   │   └── status-checker/skill.md
│   └── README.md
├── MIGRATION_CHECKLIST.md         # Two-repository migration checklist
├── READY_TO_MIGRATE.md            # Migration readiness overview
├── LICENSE                        # MIT License
└── README.md                      # Main documentation
```

## Architecture

### Marketplace System
- **marketplace.json**: Defines the marketplace name, owner, version, and lists all available plugins
- Each plugin is a subdirectory with its own `.claude-plugin/plugin.json`
- Plugins are referenced in marketplace.json with relative paths (e.g., `"source": "./plugin-formatter"`)

### Plugin Structure
Each plugin follows Claude Code marketplace conventions:
- `.claude-plugin/plugin.json`: Plugin metadata (name, version, description, author, keywords, license)
- `agents/`: Interactive tutors that guide users through complex workflows
- `skills/`: Discrete capabilities that can be triggered by user phrases
- `plugin.md`: Overview documentation with purpose, triggers, topics, workflow, and version history
- `README.md`: User-facing documentation with installation and usage instructions

### Skill System
Skills are defined in `skills/<skill-name>/skill.md` with:
- **Frontmatter**: YAML metadata (name, description, license)
- **Activation Triggers**: Phrases that invoke the skill
- **Behaviour**: Detailed workflow steps
- Optional `manifest.json` for additional metadata

### Persistence (claude-prioritise)
The claude-prioritise plugin maintains state across sessions using markdown files in `persistence/`:
- **log.md**: Continuous activity log appended on each run
- **ideas.md**: Backlog of ideas and features
- **todo.md**: Current task list with status (done/in progress/not started)

## Installation and Testing

### Installing the Marketplace
```bash
/plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority
```

### Installing Plugins
```bash
/plugin install plugin-formatter@claude-priority
/plugin install claude-prioritise@claude-priority
```

### Enabling Plugins
```bash
/plugin enable plugin-formatter
/plugin enable claude-prioritise
```

### Verification
```bash
/plugin marketplace list    # Should show "claude-priority"
/plugin list               # Should show both plugins as "enabled"
```

## Testing Plugins

### plugin-formatter
Activation phrases:
- "format this plugin"
- "validate plugin format"
- "check plugin compliance"

Validates and fixes:
- Directory and file naming (converts to lowercase-with-hyphens)
- JSON schema compliance (plugin.json, marketplace.json)
- Frontmatter in skill.md files
- README.md skill lists
- String-to-object conversions for author/owner fields

### claude-prioritise
Activation phrases:
- "What should I work on?"
- "Show project status"
- "Update backlog"

Provides:
- Current status (X done, Y in progress, Z not started)
- Last activity from persistent log
- Suggested next steps based on context
- GitHub synchronization for up-to-date state

## Validation Rules

### Naming Conventions
- **Directories**: lowercase-with-hyphens (e.g., `chart-basics`, not `Chart_Basics`)
- **Pattern**: `^[a-z0-9-]+$`
- **skill.md**: Must match directory name in frontmatter

### Required Files
- `.claude-plugin/plugin.json` (plugin level)
- `.claude-plugin/marketplace.json` (marketplace level)
- `README.md` (plugin level)
- `skills/<skill-name>/skill.md` (for each skill)

### JSON Schemas
- **Author field**: Must be object `{"name": "..."}`, not string
- **Owner field**: Must be object `{"name": "..."}`, not string
- **Version**: Semantic versioning (x.y.z)
- **Keywords**: Array of strings
- **Category**: String (e.g., "tools")

## Development Workflow

### Working on Plugins
1. Make changes to plugin files
2. Run `"format this plugin"` to validate and auto-fix issues
3. Check for renamed directories, updated JSON, regenerated READMEs
4. Commit changes

### Creating New Skills
1. Create `skills/<skill-name>/` directory (lowercase-with-hyphens)
2. Add `skill.md` with required frontmatter and sections
3. Optionally add `manifest.json`
4. Run formatter to validate structure
5. Update plugin README.md with new skill

### Modifying Metadata
- **Plugin version**: Update `.claude-plugin/plugin.json` version field
- **Marketplace version**: Update `.claude-plugin/marketplace.json` version field
- **Plugin description**: Update both plugin.json and marketplace.json entry
- **Version history**: Update `plugin.md` with changelog entry

## Key Files

### Marketplace Configuration
- `.claude-plugin/marketplace.json`: Defines marketplace and lists all plugins

### Plugin-Formatter Resources
- `plugin-formatter/skills/plugin-formatter/rules.md`: Complete validation rules
- `plugin-formatter/skills/plugin-formatter/schemas/`: JSON schemas for validation
  - `plugin-schema.json`: Schema for plugin.json
  - `marketplace-schema.json`: Schema for marketplace.json
- `plugin-formatter/skills/plugin-formatter/templates/`: Template files for auto-generation

### Claude-Prioritise Persistence
- `claude-prioritise/persistence/log.md`: Activity log (auto-created, append-only)
- `claude-prioritise/persistence/ideas.md`: Backlog ideas (manually curated)
- `claude-prioritise/persistence/todo.md`: Current tasks (synced from ideas)

## Common Issues and Solutions

### Plugin not appearing after installation
- Verify marketplace.json lists the plugin with correct "source" path
- Check plugin.json exists in `.claude-plugin/` subdirectory
- Run `/plugin marketplace refresh`

### Skill not triggering
- Check frontmatter name matches directory name
- Verify activation triggers are listed in skill.md
- Ensure plugin is enabled with `/plugin list`

### Validation errors
- Run `"format this plugin"` to auto-fix common issues
- Check directory names are lowercase-with-hyphens
- Verify author/owner fields are objects, not strings
- Ensure all required fields exist in JSON files

## Two-Repository Migration (Prepared for v2.1.0)

### Current Status
This repository is **ready for migration** to a two-repository structure. All documentation has been prepared but migration has NOT yet been executed.

### Migration Strategy
- **Production Marketplace** (`claude-priority`): This current repo will be cleaned up to contain only production plugins
- **Development Repository** (`claude-priority-dev`): New repo will contain full development environment

### Migration Documents
- **[MIGRATION_CHECKLIST.md](../MIGRATION_CHECKLIST.md)**: 34-step detailed checklist
- **[READY_TO_MIGRATE.md](../READY_TO_MIGRATE.md)**: Migration overview and timeline
- **[DEV_REPO_SETUP.md](./DEV_REPO_SETUP.md)**: Development repository setup guide
- **[PRODUCTION_CLEANUP.md](./PRODUCTION_CLEANUP.md)**: Production cleanup procedures

### When Migration Occurs
After migration:
- Production repo will remove: `example-plugin/`, `tests/`, `.githooks/`, developer docs
- Production repo will keep: `plugin-formatter/`, `claude-prioritise/`, user docs, LICENSE
- Development repo will have: Everything (full current state preserved)
- Auto-sync via GitHub Actions will keep production updated

### For Claude Instances
If you see this message and migration has been completed:
- Check if `example-plugin/` exists - if NO, migration is complete
- Check for `claude-priority-dev` repository - if EXISTS, migration is complete
- Update working procedures to use dev repo for development tasks

## Version History
- **v2.1.0** (2025-11-03): Repository reorganization - docs/ and tests/ directories, migration preparation
- **v2.0.1** (2025-11-03): Validation fixes, automated test suite
- **v2.0.0** (2025-11-02): Major enhancement with comprehensive documentation and validation
- **v1.0.0** (2025-11-01): Initial marketplace with plugin-formatter and claude-prioritise plugins
