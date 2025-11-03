# Two-Repository Migration Checklist

Complete step-by-step checklist for splitting `claude-priority` into production and development repositories.

## Overview

- **Production**: `claude-priority` (clean user-facing marketplace)
- **Development**: `claude-priority-dev` (full development environment)
- **Time**: ~1-2 hours
- **Risk**: Low (backups created, reversible)

---

## Pre-Migration

### ☐ Verify Current State

```bash
cd /c/Users/jonat/Documents/Tech/claude-priority

# Run tests - should all pass
cd tests
./test-all.sh

# Verify git status is clean
cd ..
git status

# Should show: "nothing to commit, working tree clean"
```

### ☐ Create Backup

```bash
cd /c/Users/jonat/Documents/Tech

# Create timestamped backup
cp -r claude-priority claude-priority-backup-$(date +%Y%m%d-%H%M%S)

# Verify backup
ls -la claude-priority-backup-*
```

### ☐ Document Current State

```bash
cd claude-priority

# Save current structure
tree -L 3 > structure-before.txt

# Save file count
find . -type f | wc -l > file-count-before.txt

# Save size
du -sh . > size-before.txt

# Commit documentation
git add structure-before.txt file-count-before.txt size-before.txt
git commit -m "Pre-migration: Document current state"
```

---

## Phase 1: Create Development Repository

### ☐ Create Repo on GitHub

- [ ] Go to https://github.com/new
- [ ] Name: `claude-priority-dev`
- [ ] Description: `Development repository for Claude Priority marketplace - includes tests, examples, and comprehensive documentation`
- [ ] Visibility: **Public**
- [ ] **Do NOT** initialize with README
- [ ] Click "Create repository"
- [ ] Copy repo URL: `https://github.com/ZenterFlow/claude-priority-dev.git`

### ☐ Clone and Prepare Dev Repo

```bash
cd /c/Users/jonat/Documents/Tech

# Clone current state as dev repo
cp -r claude-priority claude-priority-dev
cd claude-priority-dev

# Remove old git history
rm -rf .git

# Initialize new repo
git init
git remote add origin https://github.com/ZenterFlow/claude-priority-dev.git
```

### ☐ Update Dev README

```bash
# Replace README.md with developer-focused version
# (See DEV_REPO_SETUP.md Step 3 for full content)

# Quick version:
cat > README.md << 'EOF'
# Claude Priority Development Repository

Development hub for Claude Priority marketplace.

**For users**: See [claude-priority](https://github.com/ZenterFlow/claude-priority)
**For developers**: You're in the right place!

## Quick Start
```bash
git clone https://github.com/ZenterFlow/claude-priority-dev.git
cd claude-priority-dev
cd tests && ./test-all.sh
```

[... rest of developer README ...]
EOF

git add README.md
```

### ☐ Initial Commit and Push

```bash
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
- Git hooks"

git branch -M main
git push -u origin main
```

### ☐ Verify Dev Repo on GitHub

- [ ] Visit: https://github.com/ZenterFlow/claude-priority-dev
- [ ] README displays correctly
- [ ] All files present
- [ ] Repository is public

---

## Phase 2: Configure Sync Workflow

### ☐ Create Personal Access Token

- [ ] Go to: https://github.com/settings/tokens/new
- [ ] Note: `claude-priority-dev sync to production`
- [ ] Expiration: `No expiration` or `1 year`
- [ ] Scope: ✅ **repo** (full control)
- [ ] Click "Generate token"
- [ ] **Copy token** (save securely, won't see again)

### ☐ Add Token to Dev Repo

- [ ] Go to: https://github.com/ZenterFlow/claude-priority-dev/settings/secrets/actions
- [ ] Click "New repository secret"
- [ ] Name: `PRODUCTION_SYNC_TOKEN`
- [ ] Value: [paste token]
- [ ] Click "Add secret"

### ☐ Create Sync Workflow

```bash
cd /path/to/claude-priority-dev

mkdir -p .github/workflows

# Create sync workflow
# (See DEV_REPO_SETUP.md Step 4 for full workflow content)

cat > .github/workflows/sync-to-production.yml << 'EOF'
name: Sync to Production
# [... full workflow content ...]
EOF

git add .github/workflows/sync-to-production.yml
git commit -m "Add production sync workflow"
git push
```

### ☐ Verify Workflow

- [ ] Go to: https://github.com/ZenterFlow/claude-priority-dev/actions
- [ ] Workflow appears in list
- [ ] No errors shown

---

## Phase 3: Clean Up Production Repository

### ☐ Remove Development Content

```bash
cd /path/to/claude-priority

# Remove example-plugin
git rm -r example-plugin/

# Remove tests
git rm -r tests/

# Remove git hooks
git rm -r .githooks/

git commit -m "Remove development content

Moved to claude-priority-dev repository:
- example-plugin/
- tests/
- .githooks/"
```

### ☐ Clean Up Documentation

```bash
cd docs

# Remove developer docs
git rm CLAUDE.md CONTRIBUTING.md VALIDATION_GUIDE.md \
       ARCHITECTURE.md IMPROVEMENTS.md DEV_REPO_SETUP.md \
       PRODUCTION_CLEANUP.md DEPLOYMENT_GUIDE.md \
       PUBLIC_MARKETPLACE_STRATEGY.md

# Create docs index
cat > README.md << 'EOF'
# Documentation

## For Users
- [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)
- [CHANGELOG.md](./CHANGELOG.md)

## For Developers
See [claude-priority-dev](https://github.com/ZenterFlow/claude-priority-dev)
EOF

cd ..
git add docs/
git commit -m "Remove developer documentation

Developer docs moved to claude-priority-dev."
```

### ☐ Update marketplace.json

```bash
# Remove example-plugin from plugins array
# Should only list: plugin-formatter, claude-prioritise

cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "claude-priority",
  "owner": {"name": "ZenterFlow"},
  "description": "Production-ready Claude Code plugins for development workflows",
  "version": "2.1.0",
  "plugins": [
    {
      "name": "plugin-formatter",
      "source": "./plugin-formatter",
      "description": "Formats plugin folders and files according to Claude Code plugin marketplace guidelines",
      "version": "1.0.0",
      "author": {"name": "ZenterFlow"},
      "keywords": ["formatting", "validation", "plugin-development", "tools"],
      "category": "tools"
    },
    {
      "name": "claude-prioritise",
      "source": "./claude-prioritise",
      "description": "One-command project status assessment, priority surfacing, and persistent backlog management",
      "version": "1.0.0",
      "author": {"name": "ZenterFlow"},
      "keywords": ["productivity", "task-management", "priorities", "tools"],
      "category": "tools"
    }
  ]
}
EOF

git add .claude-plugin/marketplace.json
git commit -m "Update marketplace.json: remove example-plugin"
```

### ☐ Simplify CI/CD

```bash
cd .github/workflows

# Remove comprehensive testing
git rm test-installation.yml

# Simplify validate-plugins.yml
# (See PRODUCTION_CLEANUP.md Step 3.2 for simplified version)

git add validate-plugins.yml
git commit -m "Simplify CI to production validation only"
```

### ☐ Create User-Focused README

```bash
cd /path/to/claude-priority

# Replace README.md with user-focused version
# (See PRODUCTION_CLEANUP.md Step 4 for full content)

git add README.md
git commit -m "Add user-focused production README"
```

### ☐ Document Final State

```bash
# Save post-cleanup structure
tree -L 3 > structure-after.txt

# Save file count
find . -type f | wc -l > file-count-after.txt

# Save size
du -sh . > size-after.txt

git add structure-after.txt file-count-after.txt size-after.txt
git commit -m "Post-migration: Document final state"
```

### ☐ Push Production Changes

```bash
git push origin main
```

---

## Phase 4: Verification

### ☐ Verify Production Repo

```bash
cd /path/to/claude-priority

# Check structure
ls -la

# Should see:
# - README.md
# - .claude-plugin/
# - plugin-formatter/
# - claude-prioritise/
# - docs/ (minimal)
# - LICENSE
# - .github/

# Should NOT see:
# - example-plugin/
# - tests/
# - .githooks/

# Check size
du -sh .
# Should be ~5 MB (down from ~15 MB)

# Check file count
find . -type f | wc -l
# Should be ~50 files (down from ~120)
```

### ☐ Verify Dev Repo

```bash
cd /path/to/claude-priority-dev

# Should have everything:
ls -la

# Run tests
cd tests
./test-all.sh

# Should see:
# ✅ All 3 plugins validated
# ✅ All tests passed
```

### ☐ Test Production Marketplace

```bash
# Remove old marketplace if exists
/plugin marketplace remove claude-priority

# Add production marketplace
/plugin marketplace add https://github.com/ZenterFlow/claude-priority

# List available plugins
/plugin marketplace list

# Should show only:
# - plugin-formatter
# - claude-prioritise

# Install both
/plugin install plugin-formatter@claude-priority
/plugin install claude-prioritise@claude-priority

# Enable
/plugin enable plugin-formatter
/plugin enable claude-prioritise

# Test
# Type: "format this plugin"
# Type: "What should I work on?"
```

### ☐ Test Dev Marketplace

```bash
# Add dev marketplace
/plugin marketplace add /path/to/claude-priority-dev

# Should list 3 plugins:
# - plugin-formatter
# - claude-prioritise
# - example-plugin

# Install example
/plugin install example-plugin@claude-priority-dev
/plugin enable example-plugin

# Test: "say hello"
```

### ☐ Test Sync Workflow

```bash
cd /path/to/claude-priority-dev

# Make test change to plugin
echo "# Test sync" >> plugin-formatter/README.md

git add plugin-formatter/README.md
git commit -m "Test: Verify production sync"
git push

# Check GitHub Actions
# Go to: https://github.com/ZenterFlow/claude-priority-dev/actions
# - Workflow should trigger
# - Should complete successfully

# Verify sync in production
# Go to: https://github.com/ZenterFlow/claude-priority
# - Should see synced commit
# - plugin-formatter/README.md should have change
```

---

## Phase 5: Finalization

### ☐ Update CHANGELOG

```bash
cd /path/to/claude-priority/docs

# Add v2.1.0 entry to CHANGELOG.md
# (See section below for content)

git add CHANGELOG.md
git commit -m "Update CHANGELOG for v2.1.0 repository split"
git push
```

### ☐ Update Dev Repo Documentation

```bash
cd /path/to/claude-priority-dev/docs

# Update CONTRIBUTING.md with two-repo note
# Update CLAUDE.md with repository structure

git add docs/
git commit -m "Update documentation for two-repo structure"
git push
```

### ☐ Create GitHub Releases

Production Release:
- [ ] Go to: https://github.com/ZenterFlow/claude-priority/releases/new
- [ ] Tag: `v2.1.0`
- [ ] Title: "Claude Priority Marketplace v2.1.0"
- [ ] Description: Production marketplace release
- [ ] Publish release

Dev Release (optional):
- [ ] Go to: https://github.com/ZenterFlow/claude-priority-dev/releases/new
- [ ] Tag: `v2.1.0-dev`
- [ ] Title: "Development Environment v2.1.0"
- [ ] Publish release

### ☐ Update Repository Descriptions

Production:
- [ ] Go to: https://github.com/ZenterFlow/claude-priority
- [ ] Click ⚙️ Settings
- [ ] Description: `Production marketplace for Claude Code plugins - includes plugin-formatter and claude-prioritise`
- [ ] Website: Leave empty or link to dev repo
- [ ] Topics: `claude-code`, `plugins`, `marketplace`, `productivity`
- [ ] Save

Development:
- [ ] Go to: https://github.com/ZenterFlow/claude-priority-dev
- [ ] Description: `Development repository for Claude Priority marketplace - tests, examples, and comprehensive documentation`
- [ ] Website: `https://github.com/ZenterFlow/claude-priority`
- [ ] Topics: `claude-code`, `plugin-development`, `testing`, `documentation`
- [ ] Save

---

## Post-Migration

### ☐ Announce Changes

Create announcement issue or discussion:

```markdown
# Repository Split: Production & Development

The Claude Priority project has been reorganized into two repositories:

## 🎯 Production Marketplace
**https://github.com/ZenterFlow/claude-priority**
- Clean, user-facing marketplace
- Only production plugins
- Minimal documentation
- Install: `/plugin marketplace add https://github.com/ZenterFlow/claude-priority`

## 🛠️ Development Repository
**https://github.com/ZenterFlow/claude-priority-dev**
- Full development environment
- All tools and examples
- Comprehensive documentation
- For contributors and plugin developers

## 🔄 Automatic Sync
Changes to plugins in the dev repo automatically sync to production via GitHub Actions.

## 📚 Documentation
- Users: See production repo README
- Developers: See dev repo docs/

Questions? Open an issue in the appropriate repository!
```

### ☐ Monitor First Week

- [ ] Watch for sync workflow issues
- [ ] Monitor user installation success
- [ ] Check for broken links in documentation
- [ ] Respond to issues/questions

### ☐ Clean Up Local

```bash
# Optional: Remove backup after 1 week if all is well
rm -rf /path/to/claude-priority-backup-*

# Keep both repos updated
cd /path/to/claude-priority && git pull
cd /path/to/claude-priority-dev && git pull
```

---

## Success Criteria

Migration is successful when:

- ✅ Dev repo created with all content
- ✅ Production repo cleaned up
- ✅ Both repos accessible on GitHub
- ✅ Sync workflow configured and tested
- ✅ Production marketplace installs correctly
- ✅ Dev marketplace installs correctly
- ✅ All tests pass in dev repo
- ✅ Documentation updated in both repos
- ✅ CHANGELOG updated
- ✅ No broken links
- ✅ Sync from dev to production works

---

## Rollback Plan

If critical issues arise:

```bash
# Restore production from backup
cd /c/Users/jonat/Documents/Tech
rm -rf claude-priority
cp -r claude-priority-backup-TIMESTAMP claude-priority
cd claude-priority

# Force push to GitHub
git push --force origin main

# Delete dev repo (if needed)
# Go to: https://github.com/ZenterFlow/claude-priority-dev/settings
# Scroll to "Danger Zone"
# Delete repository
```

---

## Checklist Summary

**Pre-Migration**: 3 items
**Phase 1 - Dev Repo**: 5 items
**Phase 2 - Sync**: 4 items
**Phase 3 - Cleanup**: 8 items
**Phase 4 - Verification**: 7 items
**Phase 5 - Finalization**: 4 items
**Post-Migration**: 3 items

**Total**: 34 items
**Estimated Time**: 1-2 hours
**Complexity**: Medium
**Risk**: Low (reversible with backups)

---

## Support

Need help? Check:
- [DEV_REPO_SETUP.md](./docs/DEV_REPO_SETUP.md)
- [PRODUCTION_CLEANUP.md](./docs/PRODUCTION_CLEANUP.md)
- [GitHub Issues](https://github.com/ZenterFlow/claude-priority-dev/issues)

---

**Ready to begin? Start with Pre-Migration checks! ✅**
