# Development Repository Setup Guide

This guide walks through creating the `claude-priority-dev` repository as the development hub while keeping `claude-priority` as the clean public marketplace.

## Repository Strategy Overview

### claude-priority (Production - Current Repo)
- **Purpose**: Clean public marketplace for end users
- **Content**: Plugins + minimal docs only
- **Size**: ~5 MB
- **Audience**: Users installing plugins
- **URL**: https://github.com/ZenterFlow/claude-priority

### claude-priority-dev (Development - New Repo)
- **Purpose**: Development hub with all tools
- **Content**: Everything (plugins + tests + examples + full docs)
- **Size**: ~15 MB
- **Audience**: Contributors, plugin developers
- **URL**: https://github.com/ZenterFlow/claude-priority-dev

---

## Step 1: Create Development Repository on GitHub

1. **Go to GitHub**: https://github.com/new
2. **Repository settings**:
   - Repository name: `claude-priority-dev`
   - Description: `Development repository for Claude Priority marketplace - includes tests, examples, and comprehensive documentation`
   - Visibility: **Public** (for open source collaboration)
   - Initialize: **Do NOT** initialize with README (we'll push existing content)
3. **Create repository**

---

## Step 2: Prepare Development Repository Content

### 2.1: Create Dev Repo Directory

```bash
cd /c/Users/jonat/Documents/Tech

# Create fresh clone of current state as dev repo
git clone claude-priority claude-priority-dev
cd claude-priority-dev

# Remove old git history, start fresh
rm -rf .git
git init
```

### 2.2: Add Remote and Initial Commit

```bash
# Add dev repo remote
git remote add origin https://github.com/ZenterFlow/claude-priority-dev.git

# Initial commit with all current content
git add .
git commit -m "Initial development repository

Full development environment including:
- plugin-formatter v1.0.0
- claude-prioritise v1.0.0
- example-plugin v1.0.0
- Automated test suite
- Validation scripts
- Comprehensive documentation
- CI/CD workflows
- Git hooks

This repository serves as the development hub for the claude-priority
marketplace. The production marketplace (claude-priority) contains only
user-facing plugins and minimal documentation."

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## Step 3: Update Dev Repo README

Replace the current README.md with a developer-focused version:

```bash
cat > README.md << 'EOF'
# Claude Priority Development Repository

**Development hub** for the Claude Priority marketplace. For the production marketplace, see [claude-priority](https://github.com/ZenterFlow/claude-priority).

## What's This?

This repository contains the full development environment for Claude Priority plugins, including:
- ✅ All production plugins
- ✅ Example plugin demonstrating best practices
- ✅ Automated test suite with cross-platform support
- ✅ Validation scripts for plugin compliance
- ✅ Comprehensive documentation for contributors
- ✅ CI/CD workflows and git hooks

## For Users

**Want to install plugins?** Use the production marketplace:
```bash
/plugin marketplace add https://github.com/ZenterFlow/claude-priority
```

## For Developers

### Quick Start

1. **Clone this repository**:
   ```bash
   git clone https://github.com/ZenterFlow/claude-priority-dev.git
   cd claude-priority-dev
   ```

2. **Run tests**:
   ```bash
   cd tests
   ./test-all.sh       # Linux/macOS/Git Bash
   test-all.bat        # Windows
   ```

3. **Install git hooks**:
   ```bash
   cp .githooks/pre-commit .git/hooks/pre-commit
   chmod +x .git/hooks/pre-commit
   ```

### Directory Structure

```
claude-priority-dev/
├── README.md                      # This file
├── .claude-plugin/
│   └── marketplace.json           # Marketplace configuration
├── plugin-formatter/              # Plugin 1: Formatting & validation
├── claude-prioritise/             # Plugin 2: Task management
├── example-plugin/                # Reference implementation
├── docs/                          # Complete documentation
│   ├── CLAUDE.md                  # Guide for Claude instances
│   ├── CONTRIBUTING.md            # Contribution guidelines
│   ├── VALIDATION_GUIDE.md        # Validation procedures
│   ├── ARCHITECTURE.md            # System architecture
│   ├── CHANGELOG.md               # Version history
│   ├── IMPROVEMENTS.md            # Enhancement log
│   └── ...
├── tests/                         # Automated test suite
│   ├── test-all.sh
│   ├── test-all.bat
│   └── TEST_README.md
├── .github/workflows/             # CI/CD automation
└── .githooks/                     # Git hooks

```

### Available Plugins

#### 1. plugin-formatter
Validates and formats Claude Code plugins to marketplace standards.
- Naming convention enforcement
- JSON schema validation
- Frontmatter validation
- Auto-fix capabilities

#### 2. claude-prioritise
Project status assessment and priority management with persistence.
- Activity logging
- Backlog management
- Priority scoring
- GitHub integration

#### 3. example-plugin (Reference)
Perfect example demonstrating all marketplace features.
- hello-world skill
- status-checker skill
- Interactive teaching agent

### Testing

Run the complete test suite:
```bash
cd tests
./test-all.sh
```

This validates:
- ✅ All 3 plugins pass naming conventions
- ✅ All JSON schemas are valid
- ✅ All frontmatter is correct
- ✅ marketplace.json is valid

### Contributing

See [CONTRIBUTING.md](./docs/CONTRIBUTING.md) for:
- Development setup
- Creating new plugins
- Validation requirements
- Submission process

### Validation Scripts

Individual validation scripts are located in:
```
plugin-formatter/skills/plugin-formatter/scripts/
├── validate-naming.sh       # Naming conventions
├── validate-json.sh         # JSON schema
└── validate-frontmatter.sh  # YAML frontmatter
```

### Documentation

- **[CLAUDE.md](./docs/CLAUDE.md)** - Guide for Claude Code instances
- **[CONTRIBUTING.md](./docs/CONTRIBUTING.md)** - How to contribute
- **[VALIDATION_GUIDE.md](./docs/VALIDATION_GUIDE.md)** - Validation procedures
- **[ARCHITECTURE.md](./docs/ARCHITECTURE.md)** - System architecture
- **[CHANGELOG.md](./docs/CHANGELOG.md)** - Version history

### Sync to Production

Changes to production plugins are automatically synced to the [claude-priority](https://github.com/ZenterFlow/claude-priority) repository via GitHub Actions.

The sync workflow triggers when:
- `plugin-formatter/` changes
- `claude-prioritise/` changes
- `marketplace.json` changes
- User documentation changes

### CI/CD

GitHub Actions workflows:
- **validate-plugins.yml** - Validates all plugins on push/PR
- **test-installation.yml** - Tests marketplace installation
- **sync-to-production.yml** - Syncs changes to production repo

### Version

**Development Repository**: v2.1.0
**Last Updated**: 2025-11-03

### License

MIT - See [LICENSE](./LICENSE) for details

### Links

- **Production Marketplace**: https://github.com/ZenterFlow/claude-priority
- **Issues**: https://github.com/ZenterFlow/claude-priority-dev/issues
- **Discussions**: https://github.com/ZenterFlow/claude-priority-dev/discussions
EOF

git add README.md
git commit -m "Add developer-focused README"
git push
```

---

## Step 4: Add Sync Workflow to Dev Repo

Create the GitHub Actions workflow that syncs to production:

```bash
mkdir -p .github/workflows

cat > .github/workflows/sync-to-production.yml << 'EOF'
name: Sync to Production

on:
  push:
    branches: [main]
    paths:
      - 'plugin-formatter/**'
      - 'claude-prioritise/**'
      - '.claude-plugin/marketplace.json'
      - 'docs/INSTALLATION_GUIDE.md'
      - 'docs/CHANGELOG.md'

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout dev repo
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Checkout production repo
        uses: actions/checkout@v4
        with:
          repository: ZenterFlow/claude-priority
          token: ${{ secrets.PRODUCTION_SYNC_TOKEN }}
          path: production

      - name: Sync plugins and docs
        run: |
          # Sync plugins
          rm -rf production/plugin-formatter
          rm -rf production/claude-prioritise
          cp -r plugin-formatter production/
          cp -r claude-prioritise production/

          # Sync marketplace config
          cp .claude-plugin/marketplace.json production/.claude-plugin/

          # Sync user documentation only
          cp docs/INSTALLATION_GUIDE.md production/docs/
          cp docs/CHANGELOG.md production/docs/

          # Sync README if it exists in production template
          if [ -f production/README.md ]; then
            # Production README is maintained separately
            echo "Production README maintained separately"
          fi

      - name: Commit and push to production
        working-directory: production
        run: |
          git config user.name "Claude Priority Sync Bot"
          git config user.email "sync-bot@claude-priority.dev"
          git add .

          if git diff --staged --quiet; then
            echo "No changes to sync"
            exit 0
          fi

          git commit -m "Sync from dev: ${{ github.event.head_commit.message }}

          Synced by: https://github.com/ZenterFlow/claude-priority-dev/commit/${{ github.sha }}

          Changes:
          - plugin-formatter/
          - claude-prioritise/
          - marketplace.json
          - User documentation"

          git push
EOF

git add .github/workflows/sync-to-production.yml
git commit -m "Add production sync workflow"
git push
```

---

## Step 5: Configure GitHub Token

The sync workflow needs a Personal Access Token to push to the production repo.

### 5.1: Create Personal Access Token

1. Go to: https://github.com/settings/tokens/new
2. Settings:
   - Note: `claude-priority-dev sync to production`
   - Expiration: `No expiration` (or 1 year)
   - Scopes: ✅ `repo` (Full control of private repositories)
3. **Generate token**
4. **Copy the token** (you won't see it again!)

### 5.2: Add Token to Dev Repo Secrets

1. Go to: https://github.com/ZenterFlow/claude-priority-dev/settings/secrets/actions
2. Click: **New repository secret**
3. Name: `PRODUCTION_SYNC_TOKEN`
4. Value: Paste the token you copied
5. **Add secret**

---

## Step 6: Test the Setup

### 6.1: Test Local Development

```bash
cd /path/to/claude-priority-dev

# Run tests
cd tests
./test-all.sh

# Should see:
# ✅ All 3 plugins validated
# ✅ marketplace.json validated
# ✅ All tests passed
```

### 6.2: Test Marketplace Installation

```bash
# Add dev marketplace
/plugin marketplace add /path/to/claude-priority-dev

# Install plugins
/plugin install plugin-formatter@claude-priority-dev
/plugin install claude-prioritise@claude-priority-dev
/plugin install example-plugin@claude-priority-dev

# Verify
/plugin list
```

### 6.3: Test Sync Workflow (After Production Cleanup)

```bash
# Make a test change to a plugin
echo "# Test" >> plugin-formatter/README.md

git add plugin-formatter/README.md
git commit -m "Test: Update plugin-formatter README"
git push

# Check GitHub Actions:
# https://github.com/ZenterFlow/claude-priority-dev/actions

# Verify sync worked:
# https://github.com/ZenterFlow/claude-priority
# Should see the commit synced
```

---

## Step 7: Update Documentation

Add notice to key docs about the two-repo structure:

### Update CONTRIBUTING.md

```bash
cat >> docs/CONTRIBUTING.md << 'EOF'

---

## Repository Structure

The Claude Priority project uses two repositories:

- **[claude-priority](https://github.com/ZenterFlow/claude-priority)** - Production marketplace (user-facing)
- **[claude-priority-dev](https://github.com/ZenterFlow/claude-priority-dev)** - Development repository (this repo)

Contributors should work in the **dev repository**. Changes to production plugins are automatically synced to the production repository via GitHub Actions.
EOF

git add docs/CONTRIBUTING.md
git commit -m "Update CONTRIBUTING.md with two-repo structure"
git push
```

---

## Success Criteria

Development repository is ready when:

- ✅ Repository created on GitHub
- ✅ All current content pushed to dev repo
- ✅ Developer-focused README in place
- ✅ Sync workflow configured with token
- ✅ Tests pass (`./tests/test-all.sh`)
- ✅ Marketplace installs correctly
- ✅ Documentation updated

---

## Next Steps

After dev repo is set up:

1. ✅ **Proceed to**: [PRODUCTION_CLEANUP.md](./PRODUCTION_CLEANUP.md)
2. Clean up production repository (remove dev content)
3. Test both repositories work correctly
4. Update marketplace registration if needed

---

## Troubleshooting

### Sync workflow fails

**Check**:
- Token has `repo` scope
- Token is added as `PRODUCTION_SYNC_TOKEN` secret
- Production repo exists and is accessible

### Tests fail in dev repo

**Run**:
```bash
cd tests
./test-all.sh
```

Check output for specific errors.

### Marketplace won't install

**Verify**:
```bash
# Path is correct
/plugin marketplace add /full/path/to/claude-priority-dev

# Marketplace.json is valid
cat .claude-plugin/marketplace.json
```

---

## Support

- **Issues**: https://github.com/ZenterFlow/claude-priority-dev/issues
- **Discussions**: https://github.com/ZenterFlow/claude-priority-dev/discussions
- **Documentation**: [docs/](./docs/)
