# Claude Priority Marketplace

A comprehensive Claude Code plugin marketplace featuring development tools, validation utilities, and task management - designed as a production-ready example implementation with extensive documentation and automated testing.

## What is This?

This is a **Claude Code Plugin Marketplace** that you can install locally to access custom development tools. It includes three plugins with comprehensive documentation, automated validation, and serves as a reference implementation for creating Claude Code plugins.

## Plugins Included

### 1. plugin-formatter
**Category:** Tools
**Version:** 1.0.0

Automatically formats and validates Claude Code plugins to ensure they meet marketplace guidelines.

**Features:**
- Validates plugin.json, marketplace.json, and manifest.json against schemas
- Converts directory and file names to lowercase-with-hyphens
- Auto-fixes string-to-object conversions (author, owner fields)
- Regenerates README.md skill lists
- Creates missing template files
- Validates frontmatter in skill.md files

**How to Use:**
- "format this plugin"
- "fix plugin structure"
- "validate plugin format"
- "check plugin compliance"

### 2. claude-prioritise
**Category:** Tools
**Version:** 1.0.0

One-command project status assessment, priority surfacing, and persistent backlog grooming.

**Features:**
- Continuous activity logging across sessions
- Backlog management with ideas and todos
- Smart priority suggestions based on context
- GitHub integration for up-to-date status
- Persistent storage for project continuity

**How to Use:**
- "What should I work on?"
- "Show project status"
- "Update backlog"

### 3. example-plugin
**Category:** Reference
**Version:** 1.0.0

Perfect reference implementation demonstrating all Claude Code marketplace features and best practices.

**Features:**
- Two example skills (hello-world, status-checker)
- Interactive teaching agent
- Complete documentation structure
- Demonstrates all best practices

**How to Use:**
- "say hello" - Test hello-world skill
- "check system status" - Test status-checker skill
- "help with example plugin" - Launch teaching agent

## Installation

### Quick Start

1. **Add the Marketplace**
   ```bash
   /plugin marketplace add /path/to/claude-priority
   ```

2. **Install Plugins**
   ```bash
   /plugin install plugin-formatter@claude-priority
   /plugin install claude-prioritise@claude-priority
   /plugin install example-plugin@claude-priority
   ```

3. **Enable Plugins**
   ```bash
   /plugin enable plugin-formatter
   /plugin enable claude-prioritise
   /plugin enable example-plugin
   ```

**That's it!** Your plugins are ready to use.

### Detailed Instructions

For step-by-step instructions with verification steps, see:
- **[INSTALLATION_GUIDE.md](./docs/INSTALLATION_GUIDE.md)** - Complete installation guide for non-technical users
- **[TESTING_CHECKLIST.md](./docs/TESTING_CHECKLIST.md)** - Comprehensive testing and verification procedures

## Directory Structure

```
claude-priority/
├── .claude-plugin/
│   └── marketplace.json               # Marketplace configuration
├── .github/workflows/                 # CI/CD automation
│   ├── validate-plugins.yml           # Plugin validation
│   └── test-installation.yml          # Installation testing
├── .githooks/                         # Git hooks
│   ├── pre-commit                     # Pre-commit validation
│   └── README.md                      # Hook documentation
├── docs/                              # Documentation
│   ├── CLAUDE.md                      # Guide for Claude Code instances
│   ├── CONTRIBUTING.md                # Contribution guidelines
│   ├── VALIDATION_GUIDE.md            # Local validation procedures
│   ├── ARCHITECTURE.md                # System architecture
│   ├── CHANGELOG.md                   # Version history
│   ├── IMPROVEMENTS.md                # Enhancement log
│   ├── INSTALLATION_GUIDE.md          # User installation guide
│   ├── TESTING_CHECKLIST.md           # Testing procedures
│   └── SUMMARY.md                     # Project summary
├── tests/                             # Automated testing
│   ├── test-all.sh                    # Test suite (Linux/macOS)
│   ├── test-all.bat                   # Test suite (Windows)
│   └── TEST_README.md                 # Test documentation
├── plugin-formatter/                  # Plugin 1: Formatting & validation
│   ├── .claude-plugin/plugin.json
│   ├── agents/plugin-formatter-tutor.md
│   ├── skills/plugin-formatter/
│   │   ├── skill.md
│   │   ├── rules.md
│   │   ├── schemas/                   # JSON schemas
│   │   ├── scripts/                   # Validation scripts
│   │   │   ├── validate-naming.sh
│   │   │   ├── validate-json.sh
│   │   │   └── validate-frontmatter.sh
│   │   └── templates/                 # Plugin templates
│   └── README.md
├── claude-prioritise/                 # Plugin 2: Task management
│   ├── .claude-plugin/plugin.json
│   ├── agents/claude-prioritise-tutor.md
│   ├── skills/project-status/skill.md
│   ├── persistence/                   # Auto-created storage
│   │   ├── log.md
│   │   ├── ideas.md
│   │   └── todo.md
│   └── README.md
├── example-plugin/                    # Plugin 3: Reference implementation
│   ├── .claude-plugin/plugin.json
│   ├── agents/example-plugin-tutor.md
│   ├── skills/
│   │   ├── hello-world/skill.md
│   │   └── status-checker/skill.md
│   └── README.md
└── README.md                          # This file
```

## Verification

After installation, verify everything is working:

```
/plugin marketplace list          # Should show "claude-priority"
/plugin list                      # Should show both plugins as "enabled"
```

Then test the plugins:
- Type: **"format this plugin"** to test plugin-formatter
- Type: **"What should I work on?"** to test claude-prioritise
- Type: **"say hello"** to test example-plugin

## Documentation

### User Guides
- **[INSTALLATION_GUIDE.md](./docs/INSTALLATION_GUIDE.md)** - Complete step-by-step installation with troubleshooting
- **[TESTING_CHECKLIST.md](./docs/TESTING_CHECKLIST.md)** - Detailed testing procedures and verification steps

### Developer Guides
- **[CONTRIBUTING.md](./docs/CONTRIBUTING.md)** - How to contribute new plugins or improvements
- **[VALIDATION_GUIDE.md](./docs/VALIDATION_GUIDE.md)** - Local validation procedures before publishing
- **[ARCHITECTURE.md](./docs/ARCHITECTURE.md)** - System architecture and design patterns
- **[CLAUDE.md](./docs/CLAUDE.md)** - Guide for Claude Code instances working in this repo
- **[CHANGELOG.md](./docs/CHANGELOG.md)** - Version history and changes
- **[IMPROVEMENTS.md](./docs/IMPROVEMENTS.md)** - Enhancement log and statistics

### Testing
- **[TEST_README.md](./tests/TEST_README.md)** - Automated test suite documentation
- **[test-all.sh](./tests/test-all.sh)** - Automated test suite (Linux/macOS/Git Bash)
- **[test-all.bat](./tests/test-all.bat)** - Automated test suite (Windows)

### Plugin Documentation
- **[plugin-formatter/README.md](./plugin-formatter/README.md)** - Plugin-specific documentation
- **[claude-prioritise/README.md](./claude-prioritise/README.md)** - Plugin-specific documentation
- **[example-plugin/README.md](./example-plugin/README.md)** - Reference implementation

## Development

### For Contributors

If you want to contribute to this marketplace or create new plugins:

1. **Read the guides:**
   - [CONTRIBUTING.md](./docs/CONTRIBUTING.md) - Contribution guidelines
   - [ARCHITECTURE.md](./docs/ARCHITECTURE.md) - Understanding the system

2. **Validate before publishing:**
   ```bash
   # Automated test suite (recommended)
   cd tests
   ./test-all.sh          # Linux/macOS/Git Bash
   test-all.bat           # Windows

   # Or manual validation
   ./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh your-plugin
   ./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh your-plugin
   ./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh your-plugin
   ```

3. **Use example-plugin as reference:**
   The `example-plugin/` directory demonstrates best practices for:
   - Plugin structure
   - Skill implementation
   - Agent workflows
   - Documentation

See **[VALIDATION_GUIDE.md](./docs/VALIDATION_GUIDE.md)** for complete validation procedures.

## Migration Notice

This repository is prepared for migration to a two-repository structure:
- **Production Marketplace** (`claude-priority`): Clean, user-facing marketplace with production plugins only
- **Development Repository** (`claude-priority-dev`): Full development environment with tests, examples, and comprehensive documentation

All migration documentation is ready in:
- **[MIGRATION_CHECKLIST.md](./MIGRATION_CHECKLIST.md)** - Step-by-step migration guide
- **[READY_TO_MIGRATE.md](./READY_TO_MIGRATE.md)** - Migration overview and timeline
- **[docs/DEV_REPO_SETUP.md](./docs/DEV_REPO_SETUP.md)** - Development repository setup
- **[docs/PRODUCTION_CLEANUP.md](./docs/PRODUCTION_CLEANUP.md)** - Production cleanup procedures

The migration is low-risk, fully documented, and can be executed when ready. See [CHANGELOG.md](./docs/CHANGELOG.md) v2.1.0 for details.

## Features

### Automated Testing
- **Cross-platform test suite** - Works on Linux, macOS, Windows
- **Comprehensive validation** - Naming, JSON schema, frontmatter
- **CI/CD integration** - GitHub Actions workflows
- **Pre-commit hooks** - Catch issues before commit

### Development Tools
- **Validation scripts** - Automated plugin compliance checking
- **Templates** - Starter files for new plugins and skills
- **Example implementation** - Production-ready reference plugin
- **Comprehensive docs** - Guides for users and contributors

### Quality Assurance
- **100% validated** - All plugins pass automated tests
- **Cross-platform** - Tested on multiple operating systems
- **Production-ready** - Enterprise-grade documentation
- **Best practices** - Demonstrates Claude Code standards

## Version

**Marketplace Version:** 2.1.0 (Repository Reorganization)
**Last Updated:** 2025-11-03

### What's New in v2.1.0
- **Reorganized Structure**: Documentation moved to `docs/`, tests moved to `tests/`
- **Automated Test Suite**: Cross-platform test runner (`tests/test-all.sh`, `tests/test-all.bat`)
- **Migration Ready**: Prepared for two-repository split (production + development)
- **Enhanced Validation**: Fixed cross-platform compatibility issues

See [CHANGELOG.md](./docs/CHANGELOG.md) for complete version history.

## License

MIT - See LICENSE file for details

## Links

- **Repository:** https://github.com/ZenterFlow/claude-priority
- **Issues:** https://github.com/ZenterFlow/claude-priority/issues
- **Latest Release:** https://github.com/ZenterFlow/claude-priority/releases/latest

## Acknowledgments

Created by ZenterFlow as a comprehensive example implementation for the Claude Code plugin marketplace ecosystem.
