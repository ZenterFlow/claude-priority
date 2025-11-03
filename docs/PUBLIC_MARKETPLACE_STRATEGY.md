# Public Marketplace Strategy

## Current Situation

The `claude-priority` GitHub repository is **already registered as a public marketplace** that users can install directly. This means:
- Users install via: `/plugin marketplace add https://github.com/ZenterFlow/claude-priority`
- The repository needs to maintain its current structure
- All content is publicly visible
- We need to keep developer tools while providing a clean user experience

## Recommended Strategy: Clean Root + Developer Subdirectory

Since the repo is public and users interact with it directly, organize it so users see a clean interface while developers have access to tools.

### Proposed Structure

```
claude-priority/ (Public GitHub Repository)
├── README.md                      # User-focused, clean introduction
├── .claude-plugin/
│   └── marketplace.json           # Public marketplace config
├── plugin-formatter/              # User-facing plugin 1
├── claude-prioritise/             # User-facing plugin 2
├── docs/                          # User & developer documentation
│   ├── README.md                  # Documentation index
│   ├── INSTALLATION_GUIDE.md      # For users
│   ├── CHANGELOG.md               # For users
│   ├── CLAUDE.md                  # For Claude instances
│   ├── CONTRIBUTING.md            # For developers
│   ├── VALIDATION_GUIDE.md        # For developers
│   ├── ARCHITECTURE.md            # For developers
│   └── IMPROVEMENTS.md            # For developers
├── .github/                       # CI/CD (hidden from main view)
│   └── workflows/
│       ├── validate-plugins.yml
│       └── test-installation.yml
├── .dev/                          # Developer-only content
│   ├── README.md                  # Developer guide
│   ├── example-plugin/            # Reference implementation
│   ├── tests/
│   │   ├── test-all.sh
│   │   ├── test-all.bat
│   │   └── TEST_README.md
│   └── .githooks/
│       ├── pre-commit
│       └── README.md
└── LICENSE
```

### Key Changes from Current Structure

1. **Move developer-specific content to `.dev/`**:
   - example-plugin → `.dev/example-plugin/`
   - tests/ → `.dev/tests/`
   - .githooks/ → `.dev/.githooks/`

2. **Keep docs/ for all documentation**:
   - User docs (INSTALLATION_GUIDE.md, CHANGELOG.md)
   - Developer docs (CONTRIBUTING.md, ARCHITECTURE.md, etc.)
   - Makes sense since users might want to read contribution guidelines

3. **Clean README.md**:
   - Focus on user experience first
   - Clear section for developers at the bottom
   - Link to developer resources in `.dev/`

### Benefits

✅ **For Users:**
- Clean root directory with only plugins and docs
- No confusion from test scripts or example plugins
- Professional appearance
- Clear installation instructions

✅ **For Developers:**
- All tools still accessible in `.dev/`
- Easy to find developer resources
- Tests and validation still work
- CI/CD continues to function

✅ **For Maintainers:**
- Single repository to manage
- No synchronization needed
- Clear organization
- Hidden dot-directory convention (`.dev/`) is familiar to developers

---

## Implementation Plan

### Step 1: Reorganize (10 minutes)

```bash
cd /c/Users/jonat/Documents/Tech/claude-priority

# Create .dev directory
mkdir -p .dev

# Move developer content
mv example-plugin .dev/
mv tests .dev/
mv .githooks .dev/

# Create .dev README
cat > .dev/README.md << 'EOF'
# Developer Resources

This directory contains tools and resources for plugin developers and contributors.

## Contents

- **example-plugin/** - Reference implementation demonstrating best practices
- **tests/** - Automated test suite for validation
- **.githooks/** - Git hooks for pre-commit validation

## Quick Start

### Run Tests
\`\`\`bash
cd .dev/tests
./test-all.sh       # Linux/macOS/Git Bash
test-all.bat        # Windows
\`\`\`

### Install Git Hooks
\`\`\`bash
cp .dev/.githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
\`\`\`

### Use Example Plugin
\`\`\`bash
# Install example plugin from this directory
/plugin marketplace add $(pwd)
/plugin install example-plugin@claude-priority
\`\`\`

## Documentation

See [docs/](../docs/) for complete documentation:
- [CONTRIBUTING.md](../docs/CONTRIBUTING.md) - Contribution guidelines
- [VALIDATION_GUIDE.md](../docs/VALIDATION_GUIDE.md) - Validation procedures
- [ARCHITECTURE.md](../docs/ARCHITECTURE.md) - System architecture

## Validation Scripts

Individual validation scripts are in:
\`plugin-formatter/skills/plugin-formatter/scripts/\`

- validate-naming.sh
- validate-json.sh
- validate-frontmatter.sh
EOF
```

### Step 2: Update Test Scripts

```bash
# Update test-all.sh to work from .dev/tests/
# Already done - REPO_ROOT variable handles this!
```

### Step 3: Update README.md

Create a clean, user-first README while keeping developer info at the bottom:

```markdown
# Claude Priority Marketplace

A Claude Code plugin marketplace providing development workflow tools.

## 🚀 Quick Start

Install the marketplace:
\`\`\`bash
/plugin marketplace add https://github.com/ZenterFlow/claude-priority
\`\`\`

Install plugins:
\`\`\`bash
/plugin install plugin-formatter@claude-priority
/plugin install claude-prioritise@claude-priority
\`\`\`

Enable and use:
\`\`\`bash
/plugin enable plugin-formatter
/plugin enable claude-prioritise
\`\`\`

## 📦 Available Plugins

### plugin-formatter
Validates and formats Claude Code plugins according to marketplace guidelines.

**Use it:** "format this plugin"

### claude-prioritise
Project status assessment and priority surfacing with persistent backlog management.

**Use it:** "What should I work on?"

## 📖 Documentation

- [Installation Guide](./docs/INSTALLATION_GUIDE.md) - Detailed installation instructions
- [Changelog](./docs/CHANGELOG.md) - Version history and updates

## 🛠️ For Developers

Contributing to this marketplace? Check out:

- [**Developer Resources**](./.dev/) - Tests, examples, and git hooks
- [Contributing Guide](./docs/CONTRIBUTING.md) - How to contribute
- [Architecture](./docs/ARCHITECTURE.md) - System design
- [Validation Guide](./docs/VALIDATION_GUIDE.md) - Testing your plugins

### Running Tests

\`\`\`bash
cd .dev/tests
./test-all.sh  # All validation passes ✅
\`\`\`

## 📄 License

MIT - See [LICENSE](./LICENSE) for details
\`\`\`

### Step 4: Update Documentation References

```bash
# Update docs to reference .dev/ instead of root paths
cd docs

# Update references in CONTRIBUTING.md
sed -i 's|example-plugin/|.dev/example-plugin/|g' CONTRIBUTING.md
sed -i 's|./test-all.sh|./.dev/tests/test-all.sh|g' CONTRIBUTING.md

# Update references in VALIDATION_GUIDE.md
sed -i 's|cd tests|cd .dev/tests|g' VALIDATION_GUIDE.md
sed -i 's|./test-all|./.dev/tests/test-all|g' VALIDATION_GUIDE.md

# Update CLAUDE.md structure diagram
# (manually update the directory tree to show .dev/)
```

### Step 5: Update Marketplace

Update `.claude-plugin/marketplace.json` if it references example-plugin:

```bash
# Check if marketplace.json lists example-plugin
grep -q "example-plugin" .claude-plugin/marketplace.json

# If yes, update the source path
sed -i 's|"source": "./example-plugin"|"source": "./.dev/example-plugin"|g' .claude-plugin/marketplace.json
```

### Step 6: Test Everything

```bash
# Run tests from new location
cd .dev/tests
./test-all.sh

# Verify plugins still install
/plugin marketplace refresh
/plugin list
```

---

## Alternative: Keep Current Structure with Better README

If you prefer minimal changes, just improve the README to guide users better:

```markdown
# Claude Priority Marketplace

> 👤 **For Users**: Skip to [Installation](#installation)
> 👨‍💻 **For Developers**: See [Contributing](#for-developers)

[Rest of README with clear sections...]
```

This approach:
- ✅ No file reorganization needed
- ✅ Current structure stays intact
- ✅ Tests still work from tests/
- ⚠️ Root directory still has developer files visible

---

## Recommendation

**Option 1: Move to `.dev/` structure** (Cleaner, more professional)
- Better user experience
- Clear separation
- Standard convention (`.` prefix for meta/dev files)
- 15 minutes to implement

**Option 2: Improve README only** (Quicker, less risk)
- No file moves
- Just documentation changes
- 5 minutes to implement
- Less professional but functional

Given that this is a **public marketplace**, I recommend **Option 1** with the `.dev/` directory for the best professional appearance while keeping all functionality intact.

Would you like me to implement Option 1 (reorganize to `.dev/`) or Option 2 (improve README only)?
