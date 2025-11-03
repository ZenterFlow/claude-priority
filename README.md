# Claude Priority Marketplace

A curated Claude Code plugin marketplace featuring professional development tools for plugin formatting and project management.

## What is This?

This is a **Claude Code Plugin Marketplace** that you can install locally to access custom development tools. Install once, use everywhere in your Claude Code sessions.

## Plugins Included

### 1. plugin-formatter
**Category:** Tools | **Version:** 1.0.0

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
**Category:** Tools | **Version:** 1.0.0

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

## Installation

### Quick Start

1. **Add the Marketplace**
   ```bash
   /plugin marketplace add https://github.com/ZenterFlow/claude-priority
   ```

2. **Install Plugins**
   ```bash
   /plugin install plugin-formatter@claude-priority
   /plugin install claude-prioritise@claude-priority
   ```

3. **Enable Plugins**
   ```bash
   /plugin enable plugin-formatter
   /plugin enable claude-prioritise
   ```

**That's it!** Your plugins are ready to use.

### Verification

After installation, verify everything is working:

```
/plugin marketplace list          # Should show "claude-priority"
/plugin list                      # Should show plugins as "enabled"
```

Then test the plugins:
- Type: **"format this plugin"** to test plugin-formatter
- Type: **"What should I work on?"** to test claude-prioritise

## Directory Structure

```
claude-priority/
├── .claude-plugin/
│   └── marketplace.json               # Marketplace configuration
├── .github/workflows/                 # CI/CD automation
│   ├── validate-plugins.yml           # Plugin validation
│   └── test-installation.yml          # Installation testing
├── plugin-formatter/                  # Plugin 1: Formatting & validation
│   ├── .claude-plugin/plugin.json
│   ├── agents/plugin-formatter-tutor.md
│   ├── skills/plugin-formatter/
│   │   ├── skill.md
│   │   ├── rules.md
│   │   ├── schemas/                   # JSON schemas
│   │   ├── scripts/                   # Validation scripts
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
├── persistence/                       # Project tracking
└── README.md                          # This file
```

## Features

### Automated Testing
- **Cross-platform test suite** - Works on Linux, macOS, Windows
- **Comprehensive validation** - Naming, JSON schema, frontmatter
- **CI/CD integration** - GitHub Actions workflows

### Development Tools
- **Validation scripts** - Automated plugin compliance checking
- **Templates** - Starter files for new plugins and skills
- **Comprehensive docs** - Guides for users and contributors

### Quality Assurance
- **100% validated** - All plugins pass automated tests
- **Cross-platform** - Tested on multiple operating systems
- **Production-ready** - Enterprise-grade implementation
- **Best practices** - Demonstrates Claude Code standards

## Version

**Marketplace Version:** 3.0.0 (Production Release)
**Last Updated:** 2025-11-03

### What's New in v3.0.0
- **Production-Ready**: Clean user-focused marketplace
- **Two Production Plugins**: plugin-formatter and claude-prioritise
- **Streamlined Workflows**: Optimized CI/CD for production
- **User-Focused Documentation**: Clear installation and usage guides

## Development

This is a production marketplace. For development, testing, and contributing:
- **Development Repository**: https://github.com/ZenterFlow/claude-priority-dev
- **Submit Issues**: https://github.com/ZenterFlow/claude-priority/issues
- **Latest Release**: https://github.com/ZenterFlow/claude-priority/releases/latest

## License

MIT - See LICENSE file for details

## Links

- **Repository:** https://github.com/ZenterFlow/claude-priority
- **Issues:** https://github.com/ZenterFlow/claude-priority/issues
- **Latest Release:** https://github.com/ZenterFlow/claude-priority/releases/latest

## Acknowledgments

Created by ZenterFlow as a professional Claude Code plugin marketplace.
