# Changelog

All notable changes to the Claude Priority marketplace will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2025-11-03

### 🏗️ Repository Architecture Release

Major reorganization into separate production and development repositories for optimal user and developer experiences.

### Changed - Repository Split

**IMPORTANT**: The Claude Priority project has been reorganized into two repositories:

1. **Production Marketplace** (`claude-priority`)
   - URL: https://github.com/ZenterFlow/claude-priority
   - Purpose: Clean, user-facing marketplace
   - Content: Production plugins only (plugin-formatter, claude-prioritise)
   - Size: ~5 MB
   - Audience: End users installing plugins

2. **Development Repository** (`claude-priority-dev`)
   - URL: https://github.com/ZenterFlow/claude-priority-dev
   - Purpose: Full development environment
   - Content: All plugins + tests + examples + comprehensive docs
   - Size: ~15 MB
   - Audience: Contributors and plugin developers

**For Users**: No action required. Continue using:
```bash
/plugin marketplace add https://github.com/ZenterFlow/claude-priority
```

**For Developers**: Clone the development repository:
```bash
git clone https://github.com/ZenterFlow/claude-priority-dev.git
```

### Added

- **Development Repository**:
  - Complete development environment with all tools
  - example-plugin (reference implementation)
  - Automated test suite (tests/)
  - Validation scripts
  - Git hooks (.githooks/)
  - Comprehensive documentation
  - CI/CD workflows

- **Automatic Synchronization**:
  - GitHub Actions workflow syncs plugin changes from dev to production
  - Ensures production always has latest plugin versions
  - Zero maintenance overhead

- **Migration Documentation**:
  - `DEV_REPO_SETUP.md` - Complete development repository setup guide
  - `PRODUCTION_CLEANUP.md` - Production repository cleanup procedures
  - `MIGRATION_CHECKLIST.md` - Step-by-step migration checklist
  - `DEPLOYMENT_GUIDE.md` - Deployment strategies and best practices
  - `PUBLIC_MARKETPLACE_STRATEGY.md` - Public marketplace considerations

### Changed - Production Repository

- **Removed development content**:
  - example-plugin/ → Moved to dev repo
  - tests/ → Moved to dev repo
  - .githooks/ → Moved to dev repo
  - Developer documentation → Moved to dev repo

- **Simplified structure**:
  - Clean root directory
  - Only production plugins
  - Minimal user-facing documentation
  - Simplified CI (basic validation only)

- **README.md**: Converted to user-focused installation guide
- **marketplace.json**: Removed example-plugin, lists only production plugins
- **docs/**: Kept only INSTALLATION_GUIDE.md and CHANGELOG.md

### Repository Sizes

| Repository | Before | After | Reduction |
|------------|--------|-------|-----------|
| Production | 15 MB | 5 MB | 67% |
| Development | N/A | 15 MB | New |

### Benefits

✅ **For Users**:
- Faster clone/download (5 MB vs 15 MB)
- Cleaner interface
- No development clutter
- Professional marketplace appearance

✅ **For Developers**:
- Complete toolset in dev repo
- All examples and tests accessible
- Full documentation
- Dedicated development environment

✅ **For Maintainers**:
- Automated sync (no manual work)
- Clear separation of concerns
- Industry-standard approach
- Easier to manage releases

### Migration

See [MIGRATION_CHECKLIST.md](./MIGRATION_CHECKLIST.md) for complete migration procedure.

### Version
**Production Marketplace Version:** 2.1.0
**Development Repository Version:** 2.1.0
**Last Updated:** 2025-11-03

---

## [2.0.1] - 2025-11-03

### 🔧 Maintenance Release

Repository reorganization and test suite enhancements for better maintainability and cross-platform support.

### Changed
- **Repository Structure**: Reorganized root directory for clarity
  - Moved all documentation to `docs/` directory
  - Moved test suite to `tests/` directory
  - Root now contains only README.md and essential files
  - Updated all internal documentation references

- **Test Suite Improvements**:
  - Fixed frontmatter extraction bug in `validate-frontmatter.sh`
  - Updated test scripts to work from `tests/` directory
  - Added `REPO_ROOT` variable for correct path resolution
  - All tests pass successfully from new location

- **Documentation Updates**:
  - Updated README.md with complete new structure
  - Added example-plugin to all documentation
  - Improved directory tree visualizations
  - Updated all cross-references between documents
  - Enhanced Features section in README.md

###  Fixed
- **validate-frontmatter.sh**: Fixed `sed` command to correctly extract YAML frontmatter between `---` markers
  - Changed from: `sed -n '1,/^---$/p; /^---$/q'` (incorrect)
  - Changed to: `sed -n '/^---$/,/^---$/p' | sed '1d;$d'` (correct)
- **validate-json.sh**: OS-independent Python detection
  - Tries `python3`, `python`, `py` in order
  - Gracefully degrades if Python not available
  - Works on Linux, macOS, Windows, WSL

### Added
- **Automated Test Suite**:
  - `tests/test-all.sh` - Comprehensive test runner (Linux/macOS/Git Bash)
  - `tests/test-all.bat` - Windows wrapper script
  - `tests/TEST_README.md` - Complete test suite documentation
  - Colored output for better readability
  - Cross-platform compatibility

- **Repository Organization**:
  - `docs/` - All documentation in one place
  - `tests/` - All testing tools in one place
  - Clean root directory with only README.md

### Version
**Marketplace Version:** 2.0.1
**Last Updated:** 2025-11-03

---

## [2.0.0] - 2025-11-02

### 🎉 Major Enhancement Release

This release transforms the claude-priority marketplace from a basic plugin collection into a comprehensive, production-ready example implementation with extensive documentation, validation tools, and educational resources.

### Added

#### Agent Enhancements
- **plugin-formatter-tutor.md**: Complete 5-phase implementation workflow (415 lines, 13x increase)
  - Discovery, Validation, Auto-Fix, Reporting, and User Interaction phases
  - Comprehensive validation logic for directories, JSON schemas, and frontmatter
  - Auto-fix capabilities for naming conventions, JSON format, and README generation
  - Interactive modes (auto-fix all, review each, dry run, report only)
  - Educational explanations for each type of fix

- **claude-prioritise-tutor.md**: Complete 8-phase workflow implementation (624 lines, 19x increase)
  - Persistence initialization with template files
  - GitHub CLI integration for issues, PRs, and commits
  - Priority scoring algorithm (5 factors: priority, age, context, dependencies, effort)
  - Activity logging with automatic size management
  - Interactive backlog management (add, complete, reorder)
  - Smart context suggestions based on recent file changes
  - Pattern recognition and deadline awareness

#### Template Files
- **marketplace.json.template**: Complete marketplace configuration template
- **plugin.md.template**: Plugin documentation structure
- **agent.md.template**: Agent implementation template with phases and examples
- **Enhanced skill.md.template**: Added comprehensive comments and example usage section
- **Enhanced plugin.json.template**: Added inline comments explaining every field
- **Enhanced README.md.template**: Added installation, file structure, dependencies sections
- **Enhanced manifest.json.template**: Added dependencies and tags sections

#### Examples and Demonstrations
- **plugin-formatter/examples/README.md**: Overview of example scenarios
- **Before/After Scenarios**:
  - `01-naming-conventions-BEFORE/AFTER.json`: Naming convention violations and fixes
  - `02-json-schema-BEFORE/AFTER.json`: JSON schema violations and fixes
  - `03-frontmatter-BEFORE/AFTER.md`: Frontmatter issues and corrections
  - `04-validation-report-EXAMPLE.md`: Complete validation report example

#### Persistence System
- **log.md.template**: Activity log template with usage instructions
- **ideas.md.template**: Backlog template with 4 priority sections
- **todo.md.template**: Task tracking template with 3 status sections
- Enhanced existing persistence files with headers and documentation

#### Validation Tools
- **validate-naming.sh** (150 lines): Validates lowercase-with-hyphens convention
- **validate-json.sh** (140 lines): Validates JSON syntax and schema compliance
- **validate-frontmatter.sh** (150 lines): Validates YAML frontmatter in skill.md files
- **scripts/README.md**: Complete documentation for validation scripts

#### Example Plugin
- **example-plugin**: Complete reference implementation
  - **hello-world skill**: Simple greeting demonstrating basic structure
  - **status-checker skill**: Interactive system diagnostics with formatted output
  - **example-plugin-tutor agent**: Interactive teaching guide for plugin development
  - Complete documentation (README.md, plugin.md)
  - Perfect structure demonstrating all best practices

#### CI/CD and Git Hooks
- **.github/workflows/validate-plugins.yml**: Validates all plugins on push/PR
- **.github/workflows/test-installation.yml**: Tests marketplace installation on multiple OS
- **.githooks/pre-commit**: Pre-commit validation hook
- **.githooks/README.md**: Git hooks documentation and installation guide

#### Comprehensive Documentation
- **CLAUDE.md**: Complete guide for future Claude Code instances
  - Repository overview and architecture
  - Installation and testing procedures
  - Validation rules and development workflows
  - Key files reference and troubleshooting
- **IMPROVEMENTS.md**: Detailed changelog of all enhancements with statistics
- **CONTRIBUTING.md**: Complete contribution guidelines
  - Getting started and development setup
  - Plugin development guidelines
  - Validation requirements
  - Submission process and PR requirements
  - Code quality standards and testing procedures
- **ARCHITECTURE.md**: Deep dive into system architecture
  - Three-tier structure explanation
  - Data flow diagrams
  - Design patterns (6 patterns documented)
  - Implementation details for each plugin
  - Data models and quality assurance
- **CHANGELOG.md** (this file): Version history and changes

### Changed
- Updated README.md with improved structure and examples
- Enhanced persistence files with usage documentation
- Improved validation error messages for better clarity
- Refined skill activation triggers for better user experience

### Fixed
- Corrected frontmatter format inconsistencies
- Fixed naming convention mismatches
- Resolved JSON schema validation issues
- Improved error handling in all agents

### Statistics
- **23 new/enhanced files**
- **~3,500+ lines** of code and documentation added
- **10x improvement** in functionality and educational value
- **3 plugins** now included (plugin-formatter, claude-prioritise, example-plugin)
- **6 skills** total across all plugins
- **3 agents** providing interactive guidance
- **3 validation scripts** ready for CI/CD integration
- **4 documentation files** (CLAUDE.md, CONTRIBUTING.md, ARCHITECTURE.md, IMPROVEMENTS.md)

## [1.0.0] - 2025-11-01

### Added
- Initial marketplace setup with marketplace.json
- **plugin-formatter**: Basic plugin for formatting and validation
  - plugin-formatter skill
  - plugin-formatter-tutor agent (basic)
  - Rules documentation
  - JSON schemas (plugin-schema.json, marketplace-schema.json)
  - Basic templates (skill.md, plugin.json, README.md, manifest.json)

- **claude-prioritise**: Basic project status and priority management
  - project-status skill
  - claude-prioritise-tutor agent (basic)
  - Persistence directory structure
  - Basic log.md, ideas.md, todo.md files

- Basic README.md
- INSTALLATION_GUIDE.md for non-technical users
- TESTING_CHECKLIST.md for verification
- SUMMARY.md with project overview

### Initial Structure
```
claude-priority/
├── .claude-plugin/marketplace.json
├── plugin-formatter/
│   ├── .claude-plugin/plugin.json
│   ├── agents/plugin-formatter-tutor.md
│   ├── skills/plugin-formatter/
│   └── README.md
├── claude-prioritise/
│   ├── .claude-plugin/plugin.json
│   ├── agents/claude-prioritise-tutor.md
│   ├── skills/project-status/
│   ├── persistence/
│   └── README.md
└── README.md
```

---

## Release Comparison

### v1.0.0 → v2.0.0 Growth

| Metric | v1.0.0 | v2.0.0 | Increase |
|--------|--------|--------|----------|
| Total Files | ~15 | ~38 | +153% |
| Documentation Lines | ~500 | ~4,000+ | +700% |
| Agent Implementation | Basic | Comprehensive | 10x-19x |
| Validation Tools | None | 3 scripts | New |
| Examples | None | 8 files | New |
| Templates | 4 basic | 7 comprehensive | +75% |
| Plugins | 2 | 3 | +50% |
| Skills | 2 | 6 | +200% |
| CI/CD Workflows | None | 2 | New |
| Git Hooks | None | 1 | New |

---

## Migration Guide

### Upgrading from v1.0.0 to v2.0.0

#### For Users
No breaking changes. Simply pull the latest version:
```bash
cd /path/to/claude-priority
git pull origin main
```

#### For Plugin Developers
New validation tools available:
```bash
# Run new validation scripts
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh your-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh your-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh your-plugin
```

#### For Contributors
New pre-commit hooks recommended:
```bash
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

New documentation to review:
- CONTRIBUTING.md for contribution guidelines
- ARCHITECTURE.md for system design
- example-plugin for reference implementation

---

## Future Roadmap

### v2.1.0 (Planned)
- [ ] Interactive dry-run mode for plugin-formatter
- [ ] Enhanced priority scoring with machine learning
- [ ] Plugin dependency management
- [ ] Automated testing framework

### v3.0.0 (Future)
- [ ] Remote marketplace support
- [ ] Binary distribution of validators
- [ ] Web-based plugin browser
- [ ] Telemetry and analytics (opt-in)

---

## Notes

### Versioning Strategy
- **Major (X.0.0)**: Breaking changes, architectural redesigns
- **Minor (x.Y.0)**: New features, plugins, significant enhancements
- **Patch (x.y.Z)**: Bug fixes, documentation updates, minor improvements

### Deprecation Policy
- Features marked deprecated will be supported for one major version
- Deprecation warnings will be added one minor version before removal
- Migration guides will be provided for all breaking changes

---

## Acknowledgments

### v2.0.0 Contributors
- Enhanced agent implementations
- Comprehensive validation tools
- Extensive documentation
- CI/CD integration
- Example plugin creation

---

## Links
- [Repository](https://github.com/ZenterFlow/claude-priority)
- [Documentation](./CLAUDE.md)
- [Contributing](./CONTRIBUTING.md)
- [Architecture](./ARCHITECTURE.md)
- [Latest Release](https://github.com/ZenterFlow/claude-priority/releases/latest)
