# Deployment Guide

This guide explains how to deploy the Claude Priority marketplace, separating user-facing plugins from developer-facing tools and documentation.

## Current Repository Structure

The `claude-priority` repository currently contains:
- **User-facing**: 2 production plugins (plugin-formatter, claude-prioritise)
- **Developer-facing**: Validation tools, test suite, comprehensive documentation
- **Reference**: example-plugin demonstrating best practices

## Recommended Deployment Strategies

### Strategy 1: Single Repository with Branches (Recommended)

Keep everything in one repository but use branches to separate concerns.

**Structure:**
```
Repository: claude-priority
├── Branch: main (Public - User-facing)
│   ├── README.md (simplified for users)
│   ├── .claude-plugin/marketplace.json
│   ├── plugin-formatter/
│   ├── claude-prioritise/
│   ├── docs/
│   │   ├── INSTALLATION_GUIDE.md
│   │   └── CHANGELOG.md (user-facing changes only)
│   └── LICENSE
│
└── Branch: development (Public - Developer-facing)
    ├── README.md (comprehensive for developers)
    ├── .claude-plugin/marketplace.json
    ├── plugin-formatter/
    ├── claude-prioritise/
    ├── example-plugin/
    ├── docs/ (all documentation)
    │   ├── CLAUDE.md
    │   ├── CONTRIBUTING.md
    │   ├── VALIDATION_GUIDE.md
    │   ├── ARCHITECTURE.md
    │   ├── CHANGELOG.md (complete)
    │   ├── IMPROVEMENTS.md
    │   └── ...
    ├── tests/
    │   ├── test-all.sh
    │   ├── test-all.bat
    │   └── TEST_README.md
    ├── .github/workflows/
    ├── .githooks/
    └── LICENSE
```

**Advantages:**
- ✅ Single source of truth
- ✅ Easy synchronization between branches
- ✅ Users can access developer branch if interested
- ✅ GitHub shows both branches clearly
- ✅ Simple git workflow

**Disadvantages:**
- ⚠️ Users might clone wrong branch
- ⚠️ Need clear branch documentation

**Implementation:**
```bash
# Create user-facing branch from current main
git checkout -b main-public
git checkout development  # Current comprehensive version

# For main-public branch, remove developer content:
rm -rf tests/
rm -rf example-plugin/
rm docs/CLAUDE.md docs/CONTRIBUTING.md docs/VALIDATION_GUIDE.md \
   docs/ARCHITECTURE.md docs/IMPROVEMENTS.md
# Simplify README.md for users

# Push both branches
git push origin main-public
git push origin development
```

---

### Strategy 2: Separate Repositories

Split into two repositories: one for users, one for developers.

**Structure:**

**Repository 1: claude-priority-marketplace (Public - User-facing)**
```
claude-priority-marketplace/
├── README.md (user-focused)
├── .claude-plugin/marketplace.json
├── plugin-formatter/
├── claude-prioritise/
├── docs/
│   ├── INSTALLATION_GUIDE.md
│   └── CHANGELOG.md
└── LICENSE
```

**Repository 2: claude-priority (Public - Developer-facing)**
```
claude-priority/
├── README.md (developer-focused)
├── .claude-plugin/marketplace.json
├── plugin-formatter/
├── claude-prioritise/
├── example-plugin/
├── docs/ (all documentation)
├── tests/
├── .github/workflows/
├── .githooks/
└── LICENSE
```

**Advantages:**
- ✅ Clear separation of concerns
- ✅ Users only see what they need
- ✅ Smaller clone size for users
- ✅ Can have different release cycles

**Disadvantages:**
- ⚠️ Need to synchronize plugin updates between repos
- ⚠️ More complex maintenance
- ⚠️ Duplicate content

**Implementation:**
```bash
# Create user-facing repo
mkdir claude-priority-marketplace
cp -r .claude-plugin plugin-formatter claude-prioritise claude-priority-marketplace/
# Copy user docs and simplified README
cd claude-priority-marketplace
git init
git add .
git commit -m "Initial user-facing marketplace"
git remote add origin https://github.com/ZenterFlow/claude-priority-marketplace.git
git push -u origin main

# Keep current repo as developer-facing
cd ../claude-priority
# Update README to focus on developers
git add .
git commit -m "Converted to developer-focused repository"
```

---

### Strategy 3: Monorepo with Subdirectories

Keep everything in one repo but organize into clear subdirectories.

**Structure:**
```
claude-priority/
├── README.md (navigation to sub-projects)
├── marketplace/ (User-facing)
│   ├── README.md
│   ├── .claude-plugin/marketplace.json
│   ├── plugin-formatter/
│   └── claude-prioritise/
├── development/ (Developer-facing)
│   ├── example-plugin/
│   ├── tests/
│   ├── docs/
│   ├── .github/workflows/
│   └── .githooks/
└── LICENSE
```

**Advantages:**
- ✅ Everything in one place
- ✅ Clear organization
- ✅ No synchronization needed

**Disadvantages:**
- ⚠️ Users clone entire repo (including dev tools)
- ⚠️ Marketplace installation path changes
- ⚠️ More complex directory structure

---

### Strategy 4: Tagged Releases (Best for Official Marketplace)

Use git tags to mark user-facing releases while keeping development tools in main branch.

**Structure:**
```
Repository: claude-priority (Public)
├── main branch (includes everything)
└── Tagged releases (v1.0.0, v2.0.0, etc.)
    └── Release assets include:
        ├── claude-priority-v2.0.0.zip (plugins only)
        └── claude-priority-v2.0.0-full.zip (everything)
```

**Advantages:**
- ✅ Professional release management
- ✅ Users can choose lightweight or full version
- ✅ Versioned snapshots
- ✅ GitHub release page for downloads

**Disadvantages:**
- ⚠️ Requires manual release process
- ⚠️ Users need to download releases vs git clone

**Implementation:**
```bash
# Create release artifacts
zip -r claude-priority-v2.0.1.zip \
  .claude-plugin/ plugin-formatter/ claude-prioritise/ \
  README.md LICENSE docs/INSTALLATION_GUIDE.md

zip -r claude-priority-v2.0.1-full.zip . -x ".git/*"

# Create git tag
git tag -a v2.0.1 -m "Release v2.0.1 - User-facing marketplace"
git push origin v2.0.1

# Create GitHub release with both artifacts
```

---

## Recommended Strategy for Your Use Case

### **Strategy 1 + Strategy 4 Hybrid** ✨ (Best Choice)

Use a single repository with well-organized structure, plus tagged releases for users.

**Why This Works:**
1. **Single Source of Truth**: Everything in one repo (claude-priority)
2. **Clear Organization**: Current structure is already excellent
3. **User-Friendly**: GitHub releases with downloadable marketplace zip
4. **Developer-Friendly**: Full repo available for contributors
5. **Flexible**: Users can either:
   - Download release zip (simple)
   - Clone full repo (advanced users/contributors)

**Implementation:**

```
Repository: claude-priority (Public)
├── main branch
│   ├── README.md (dual-purpose: users + developers)
│   ├── .claude-plugin/marketplace.json
│   ├── plugin-formatter/
│   ├── claude-prioritise/
│   ├── example-plugin/
│   ├── docs/ (all documentation)
│   ├── tests/
│   └── ...
│
└── Releases (GitHub)
    ├── v2.0.1 (Latest)
    │   ├── claude-priority-marketplace.zip
    │   │   └── Contains: plugins + user docs only
    │   └── Source code (automatic from GitHub)
    └── v2.0.0
```

**README.md Structure:**
```markdown
# Claude Priority Marketplace

> **For Users**: Download the [latest release](releases/latest) for a plug-and-play marketplace.
> **For Developers**: Clone this repo to access validation tools, tests, and documentation.

## Quick Start (Users)

1. Download `claude-priority-marketplace.zip` from [Releases](releases/latest)
2. Extract to your preferred location
3. Install: `/plugin marketplace add /path/to/claude-priority`

## Development (Contributors)

See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for:
- Setting up development environment
- Running tests
- Creating new plugins
- Submitting pull requests
```

---

## Implementation Plan

### Phase 1: Prepare Current Repo (Now)

1. ✅ Current structure is already excellent
2. ✅ All validation passes
3. ⚠️ Update README.md with dual-purpose structure
4. ⚠️ Add "For Users" and "For Developers" sections

### Phase 2: Create First Release

```bash
# 1. Create release directory
mkdir -p release-temp

# 2. Copy user-facing content
cp -r .claude-plugin release-temp/
cp -r plugin-formatter release-temp/
cp -r claude-prioritise release-temp/
cp README.md release-temp/
cp LICENSE release-temp/
mkdir release-temp/docs
cp docs/INSTALLATION_GUIDE.md release-temp/docs/
cp docs/CHANGELOG.md release-temp/docs/

# 3. Create release zip
cd release-temp
zip -r ../claude-priority-marketplace-v2.0.1.zip .
cd ..
rm -rf release-temp

# 4. Create git tag
git tag -a v2.0.1 -m "Release v2.0.1

User-facing marketplace with:
- plugin-formatter v1.0.0
- claude-prioritise v1.0.0

See docs/CHANGELOG.md for details."

# 5. Push tag
git push origin v2.0.1

# 6. Create GitHub Release
# Go to https://github.com/ZenterFlow/claude-priority/releases/new
# - Tag: v2.0.1
# - Title: "Claude Priority Marketplace v2.0.1"
# - Description: From CHANGELOG.md
# - Upload: claude-priority-marketplace-v2.0.1.zip
```

### Phase 3: Maintain Going Forward

**For plugin updates:**
```bash
# 1. Make changes to plugins
# 2. Update version in plugin.json and marketplace.json
# 3. Run tests
cd tests && ./test-all.sh

# 4. Update CHANGELOG.md
# 5. Commit and push
git add .
git commit -m "Update plugin-formatter to v1.1.0"
git push

# 6. Create new release when ready
git tag -a v2.1.0 -m "..."
# Create release zip and GitHub release
```

**For developer tools only:**
```bash
# Just commit and push to main
# No need for release tag
git add tests/
git commit -m "Improve test coverage"
git push
```

---

## Automation (Optional)

### GitHub Actions Release Workflow

Create `.github/workflows/release.yml`:

```yaml
name: Create Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Create release package
        run: |
          mkdir release
          cp -r .claude-plugin plugin-formatter claude-prioritise release/
          cp README.md LICENSE release/
          mkdir release/docs
          cp docs/INSTALLATION_GUIDE.md docs/CHANGELOG.md release/docs/
          cd release
          zip -r ../claude-priority-marketplace-${{ github.ref_name }}.zip .

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v1
        with:
          files: claude-priority-marketplace-${{ github.ref_name }}.zip
          body_path: docs/CHANGELOG.md
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

This automatically creates releases when you push tags!

---

## Recommended Structure Summary

```
claude-priority/ (GitHub Repository)
├── For Users (via Releases)
│   └── claude-priority-marketplace-v2.0.1.zip
│       ├── .claude-plugin/marketplace.json
│       ├── plugin-formatter/
│       ├── claude-prioritise/
│       ├── README.md (installation focus)
│       ├── docs/INSTALLATION_GUIDE.md
│       └── LICENSE
│
└── For Developers (via Clone)
    ├── .claude-plugin/marketplace.json
    ├── plugin-formatter/
    ├── claude-prioritise/
    ├── example-plugin/
    ├── docs/ (complete)
    ├── tests/
    ├── .github/workflows/
    ├── .githooks/
    ├── README.md (dual-purpose)
    └── LICENSE
```

**Benefits:**
- ✅ Users get clean, simple marketplace via releases
- ✅ Developers get full tooling via clone
- ✅ Single repository to maintain
- ✅ Professional release management
- ✅ Clear upgrade path (download new release)
- ✅ Automated with GitHub Actions

---

## Next Steps

1. **Update README.md** with dual-purpose structure
2. **Create v2.0.1 release** with user-facing zip
3. **Set up GitHub Actions** for automated releases (optional)
4. **Announce** on Claude Code community

Would you like me to implement any of these strategies?
