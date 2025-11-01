# Claude Priority Marketplace

Personal collection of Claude Code plugins for development workflows, featuring plugin formatting and task prioritization tools.

## What is This?

This is a **Claude Code Plugin Marketplace** that you can install locally to access custom development tools. Once installed, you'll have access to two powerful plugins that help with plugin development and project management.

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

## Installation

### Quick Start (3 Steps):

1. **Add the Marketplace**
   ```
   /plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority
   ```
   *(Replace with your actual path)*

2. **Install Plugins**
   ```
   /plugin install plugin-formatter@claude-priority
   /plugin install claude-prioritise@claude-priority
   ```

3. **Enable Plugins**
   ```
   /plugin enable plugin-formatter
   /plugin enable claude-prioritise
   ```

**That's it!** Your plugins are ready to use.

### Detailed Instructions

For step-by-step instructions with verification steps, see:
- **[INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)** - Complete installation guide for non-technical users
- **[TESTING_CHECKLIST.md](./TESTING_CHECKLIST.md)** - Comprehensive testing and verification procedures

## Directory Structure

```
claude-priority/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace configuration
├── plugin-formatter/              # Plugin 1
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── agents/
│   │   └── plugin-formatter-tutor.md
│   ├── skills/
│   │   └── plugin-formatter/
│   │       ├── skill.md
│   │       ├── rules.md
│   │       ├── schemas/
│   │       └── templates/
│   ├── plugin.md
│   └── README.md
├── claude-prioritise/             # Plugin 2
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── agents/
│   │   └── claude-prioritise-tutor.md
│   ├── skills/
│   │   └── project-status/
│   │       └── skill.md
│   ├── persistence/               # Auto-created storage
│   │   ├── log.md
│   │   ├── ideas.md
│   │   └── todo.md
│   ├── plugin.md
│   └── README.md
├── pending-skills/                # Development area
├── INSTALLATION_GUIDE.md          # User installation guide
├── TESTING_CHECKLIST.md           # Testing procedures
└── README.md                      # This file
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

## Documentation

- **[INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)** - Complete step-by-step installation with troubleshooting
- **[TESTING_CHECKLIST.md](./TESTING_CHECKLIST.md)** - Detailed testing procedures and verification steps
- **plugin-formatter/README.md** - Plugin-specific documentation
- **claude-prioritise/README.md** - Plugin-specific documentation

## Development

This marketplace is set up for local development and testing. The `pending-skills/` directory contains ideas and prototypes for future plugins.

## Version

**Marketplace Version:** 1.0.0
**Last Updated:** 2025-11-01

## License

MIT
