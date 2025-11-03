# Production Repository Cleanup Guide

This guide transforms the current `claude-priority` repository into a clean, user-facing marketplace by removing development tools and keeping only production plugins and essential documentation.

**Prerequisites**: Development repository (`claude-priority-dev`) must be set up first. See [DEV_REPO_SETUP.md](./DEV_REPO_SETUP.md).

---

## Overview

### What Stays in Production
- ✅ README.md (user-focused version)
- ✅ .claude-plugin/marketplace.json
- ✅ plugin-formatter/
- ✅ claude-prioritise/
- ✅ docs/ (minimal - user docs only)
- ✅ LICENSE
- ✅ .github/workflows/ (minimal CI only)

### What Gets Removed
- ❌ example-plugin/
- ❌ tests/
- ❌ .githooks/
- ❌ docs/ (developer docs)
- ❌ .github/workflows/ (comprehensive CI)
- ❌ Development-focused README sections

### Result
- **Before**: ~40 files, 15 MB, development hub
- **After**: ~20 files, 5 MB, clean marketplace

---

## Backup First! ⚠️

```bash
# Create backup before any changes
cd /c/Users/jonat/Documents/Tech
cp -r claude-priority claude-priority-backup-$(date +%Y%m%d)

# Verify backup
ls claude-priority-backup-*
```

---

## Step 1: Remove Development Content

```bash
cd /c/Users/jonat/Documents/Tech/claude-priority

# Remove example plugin
git rm -r example-plugin/

# Remove tests
git rm -r tests/

# Remove git hooks
git rm -r .githooks/

# Commit removals
git add .
git commit -m "Remove development content

Moved to claude-priority-dev repository:
- example-plugin/ (reference implementation)
- tests/ (automated test suite)
- .githooks/ (pre-commit hooks)

This repository is now the production marketplace containing
only user-facing plugins and essential documentation."
```

---

## Step 2: Clean Up Documentation

### 2.1: Keep Only User Documentation

```bash
cd docs

# Remove developer-specific docs
git rm CLAUDE.md
git rm CONTRIBUTING.md
git rm VALIDATION_GUIDE.md
git rm ARCHITECTURE.md
git rm IMPROVEMENTS.md
git rm DEV_REPO_SETUP.md
git rm PRODUCTION_CLEANUP.md
git rm DEPLOYMENT_GUIDE.md
git rm PUBLIC_MARKETPLACE_STRATEGY.md

# Keep user docs
# - INSTALLATION_GUIDE.md
# - CHANGELOG.md
# - TESTING_CHECKLIST.md (if useful for users)
# - SUMMARY.md (if useful for users)

cd ..
git add .
git commit -m "Remove developer documentation

Developer documentation moved to claude-priority-dev.
Kept only user-facing installation and changelog."
```

### 2.2: Create Simple docs/README.md

```bash
cat > docs/README.md << 'EOF'
# Documentation

## For Users

- **[INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)** - Installation instructions and troubleshooting
- **[CHANGELOG.md](./CHANGELOG.md)** - Version history and updates

## For Developers

Development documentation is maintained in the [claude-priority-dev](https://github.com/ZenterFlow/claude-priority-dev) repository:

- Contributing Guide
- Architecture Documentation
- Validation Procedures
- Testing Guide

Visit https://github.com/ZenterFlow/claude-priority-dev for full developer resources.
EOF

git add docs/README.md
git commit -m "Add documentation index"
```

---

## Step 3: Simplify GitHub Workflows

### 3.1: Remove Comprehensive CI

```bash
cd .github/workflows

# Keep only essential validation
# Remove test-installation.yml (comprehensive testing in dev repo)
git rm test-installation.yml

# Keep validate-plugins.yml but simplify it
```

### 3.2: Simplify validate-plugins.yml

```bash
cat > validate-plugins.yml << 'EOF'
name: Validate Plugins

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate:
    name: Validate Production Plugins
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.x'

      - name: Validate marketplace.json
        run: |
          python3 -m json.tool .claude-plugin/marketplace.json > /dev/null
          echo "✅ marketplace.json is valid"

      - name: Validate plugin-formatter
        run: |
          python3 -m json.tool plugin-formatter/.claude-plugin/plugin.json > /dev/null
          echo "✅ plugin-formatter/plugin.json is valid"

      - name: Validate claude-prioritise
        run: |
          python3 -m json.tool claude-prioritise/.claude-plugin/plugin.json > /dev/null
          echo "✅ claude-prioritise/plugin.json is valid"

      - name: Summary
        run: |
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "✅ All production plugins validated"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
EOF

cd ../..
git add .github/workflows/
git commit -m "Simplify CI to production validation only

Comprehensive testing moved to claude-priority-dev repository.
Production repo validates JSON syntax only."
```

---

## Step 4: Create User-Focused README

```bash
cat > README.md << 'EOF'
# Claude Priority Marketplace

A curated Claude Code plugin marketplace providing production-ready development workflow tools.

## 🚀 Quick Install

```bash
/plugin marketplace add https://github.com/ZenterFlow/claude-priority
```

Install plugins:
```bash
/plugin install plugin-formatter@claude-priority
/plugin install claude-prioritise@claude-priority
```

Enable and use:
```bash
/plugin enable plugin-formatter
/plugin enable claude-prioritise
```

## 📦 Available Plugins

### plugin-formatter
**Version**: 1.0.0
**Category**: Tools

Validates and formats Claude Code plugins to ensure marketplace compliance.

**Features**:
- Naming convention enforcement (lowercase-with-hyphens)
- JSON schema validation
- Frontmatter validation
- Auto-fix capabilities
- Template generation

**Use it**: `"format this plugin"`

**More**: See [plugin-formatter/README.md](./plugin-formatter/README.md)

---

### claude-prioritise
**Version**: 1.0.0
**Category**: Tools

One-command project status assessment and priority management with persistent backlog.

**Features**:
- Activity logging across sessions
- Backlog management (ideas + todos)
- Smart priority suggestions
- GitHub integration
- Persistent storage

**Use it**: `"What should I work on?"`

**More**: See [claude-prioritise/README.md](./claude-prioritise/README.md)

## 📖 Documentation

- **[Installation Guide](./docs/INSTALLATION_GUIDE.md)** - Detailed setup and troubleshooting
- **[Changelog](./docs/CHANGELOG.md)** - Version history and updates

## 🛠️ For Developers

Want to contribute or build your own plugins?

Visit the **development repository**: [claude-priority-dev](https://github.com/ZenterFlow/claude-priority-dev)

The dev repo includes:
- ✅ Example plugin demonstrating best practices
- ✅ Automated test suite (cross-platform)
- ✅ Validation scripts
- ✅ Comprehensive documentation
- ✅ CI/CD workflows
- ✅ Git hooks

See [CONTRIBUTING.md](https://github.com/ZenterFlow/claude-priority-dev/blob/main/docs/CONTRIBUTING.md) for details.

## ✨ Features

- **Production-Ready**: All plugins fully tested and validated
- **Well-Documented**: Clear installation guides and changelogs
- **Open Source**: MIT licensed, community-driven
- **Active Development**: Regular updates and improvements

## 📊 Version

**Marketplace Version**: 2.1.0
**Last Updated**: 2025-11-03

## 📄 License

MIT - See [LICENSE](./LICENSE) for details

## 🔗 Links

- **Development Repository**: https://github.com/ZenterFlow/claude-priority-dev
- **Issues**: https://github.com/ZenterFlow/claude-priority/issues
- **Latest Release**: https://github.com/ZenterFlow/claude-priority/releases/latest

---

**Made with ❤️ by [ZenterFlow](https://github.com/ZenterFlow)**
EOF

git add README.md
git commit -m "Add user-focused production README

Clean, simple README focusing on:
- Quick installation
- Plugin descriptions
- Links to developer resources

Comprehensive development docs available in claude-priority-dev."
```

---

## Step 5: Update marketplace.json

Remove example-plugin from the marketplace listing:

```bash
# Edit .claude-plugin/marketplace.json
# Remove the example-plugin entry from the plugins array

# Current marketplace.json should only list:
# - plugin-formatter
# - claude-prioritise

cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "claude-priority",
  "owner": {
    "name": "ZenterFlow"
  },
  "description": "Production-ready Claude Code plugins for development workflows",
  "version": "2.1.0",
  "plugins": [
    {
      "name": "plugin-formatter",
      "source": "./plugin-formatter",
      "description": "Formats plugin folders and files according to Claude Code plugin marketplace guidelines",
      "version": "1.0.0",
      "author": {
        "name": "ZenterFlow"
      },
      "keywords": ["formatting", "validation", "plugin-development", "tools"],
      "category": "tools"
    },
    {
      "name": "claude-prioritise",
      "source": "./claude-prioritise",
      "description": "One-command project status assessment, priority surfacing, and persistent backlog management",
      "version": "1.0.0",
      "author": {
        "name": "ZenterFlow"
      },
      "keywords": ["productivity", "task-management", "priorities", "tools"],
      "category": "tools"
    }
  ]
}
EOF

git add .claude-plugin/marketplace.json
git commit -m "Update marketplace.json: remove example-plugin

Production marketplace lists only production plugins:
- plugin-formatter v1.0.0
- claude-prioritise v1.0.0"
```

---

## Step 6: Final Verification

### 6.1: Check Directory Structure

```bash
# Should look like this:
tree -L 2 -a

# Expected structure:
# claude-priority/
# ├── .claude-plugin/
# │   └── marketplace.json
# ├── .github/
# │   └── workflows/
# │       └── validate-plugins.yml
# ├── docs/
# │   ├── README.md
# │   ├── INSTALLATION_GUIDE.md
# │   └── CHANGELOG.md
# ├── plugin-formatter/
# │   ├── .claude-plugin/
# │   ├── agents/
# │   ├── skills/
# │   └── README.md
# ├── claude-prioritise/
# │   ├── .claude-plugin/
# │   ├── agents/
# │   ├── skills/
# │   ├── persistence/
# │   └── README.md
# ├── LICENSE
# └── README.md
```

### 6.2: Verify File Count

```bash
# Count total files (should be significantly reduced)
find . -type f | wc -l

# Before cleanup: ~120 files
# After cleanup: ~50 files
```

### 6.3: Check Repository Size

```bash
du -sh .

# Before: ~15 MB
# After: ~5 MB
```

---

## Step 7: Push Changes

```bash
# Review all changes
git status
git log --oneline -10

# Push to GitHub
git push origin main

# Verify on GitHub:
# https://github.com/ZenterFlow/claude-priority
# Should see clean, user-focused repository
```

---

## Step 8: Test Installation

```bash
# Test marketplace installation
/plugin marketplace remove claude-priority  # If already added
/plugin marketplace add https://github.com/ZenterFlow/claude-priority

# Verify plugins list
/plugin marketplace list

# Should show:
# - plugin-formatter
# - claude-prioritise
# (no example-plugin)

# Install and test
/plugin install plugin-formatter@claude-priority
/plugin install claude-prioritise@claude-priority

/plugin list
# Both should install successfully
```

---

## Step 9: Verify Sync Workflow

Once production cleanup is complete, test the sync from dev to production:

```bash
# In claude-priority-dev repo:
cd /path/to/claude-priority-dev

# Make a test change
echo "# Test sync" >> plugin-formatter/README.md

git add plugin-formatter/README.md
git commit -m "Test: Verify sync to production"
git push

# Check GitHub Actions in dev repo:
# https://github.com/ZenterFlow/claude-priority-dev/actions

# Verify change appears in production:
# https://github.com/ZenterFlow/claude-priority/commits/main
# Should see synced commit
```

---

## Success Criteria

Production repository is ready when:

- ✅ Development content removed (example-plugin, tests, .githooks)
- ✅ Developer docs removed (moved to dev repo)
- ✅ User-focused README in place
- ✅ Only 2 plugins in marketplace.json
- ✅ CI simplified to basic validation
- ✅ Repository size reduced (~5 MB)
- ✅ Marketplace installs successfully
- ✅ Sync from dev repo works

---

## Rollback Plan

If something goes wrong:

```bash
# Restore from backup
cd /c/Users/jonat/Documents/Tech
rm -rf claude-priority
cp -r claude-priority-backup-YYYYMMDD claude-priority
cd claude-priority

# Force push to restore GitHub
git push --force origin main
```

---

## Next Steps

After production cleanup:

1. ✅ Test both repositories work independently
2. ✅ Update any external marketplace registrations
3. ✅ Announce two-repo structure in CHANGELOG
4. ✅ Monitor first sync from dev to production

---

## Troubleshooting

### Sync workflow not triggering

**Check**:
- GitHub Action enabled in dev repo
- Token configured correctly
- Paths match in workflow trigger

### Marketplace won't install

**Verify**:
```bash
# marketplace.json is valid
python3 -m json.tool .claude-plugin/marketplace.json

# Plugins exist
ls -la plugin-formatter/ claude-prioritise/
```

### Missing files after cleanup

**Check backup**:
```bash
# Restore specific file from backup
cp claude-priority-backup-YYYYMMDD/path/to/file .
git add path/to/file
git commit -m "Restore accidentally removed file"
```

---

## Support

- **Production Issues**: https://github.com/ZenterFlow/claude-priority/issues
- **Development**: https://github.com/ZenterFlow/claude-priority-dev/issues
- **Documentation**: [docs/](./docs/)
