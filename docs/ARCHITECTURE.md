# Claude Priority Marketplace - Architecture

This document provides a deep dive into the architectural design of the Claude Priority marketplace, explaining the structure, patterns, and design decisions.

## Table of Contents
- [Overview](#overview)
- [System Architecture](#system-architecture)
- [Plugin Structure](#plugin-structure)
- [Data Flow](#data-flow)
- [Design Patterns](#design-patterns)
- [Implementation Details](#implementation-details)

---

## Overview

The Claude Priority marketplace is a **local Claude Code plugin marketplace** that demonstrates best practices for plugin development, validation, and distribution.

### Key Characteristics
- **Local-first**: Installable from local file system
- **Self-validating**: Includes validation tools
- **Educational**: Serves as reference implementation
- **Production-ready**: Fully functional with robust error handling
- **Extensible**: Easy to add new plugins

### Design Goals
1. **Demonstrate Excellence**: Show best-in-class plugin implementation
2. **Enable Learning**: Provide examples and documentation for developers
3. **Ensure Quality**: Include validation and testing tools
4. **Facilitate Development**: Provide templates and automation

---

## System Architecture

### Three-Tier Structure

```
┌─────────────────────────────────────────┐
│        Marketplace Level                │
│  .claude-plugin/marketplace.json        │
│  - Marketplace metadata                 │
│  - Plugin catalog                       │
│  - Version management                   │
└─────────────────────────────────────────┘
                   │
    ┌──────────────┼──────────────┐
    │              │              │
    ▼              ▼              ▼
┌─────────┐  ┌─────────┐  ┌─────────┐
│ Plugin 1│  │ Plugin 2│  │ Plugin 3│
│  Level  │  │  Level  │  │  Level  │
└─────────┘  └─────────┘  └─────────┘
    │              │              │
    ▼              ▼              ▼
┌─────────┐  ┌─────────┐  ┌─────────┐
│ Skills  │  │ Skills  │  │ Skills  │
│  Level  │  │  Level  │  │  Level  │
└─────────┘  └─────────┘  └─────────┘
```

### Component Hierarchy

1. **Marketplace Root**
   - Contains marketplace.json
   - Lists all available plugins
   - Manages versions and dependencies

2. **Plugin Directories**
   - Self-contained plugin implementations
   - Each has plugin.json metadata
   - Includes agents, skills, documentation

3. **Skill Implementations**
   - Individual capabilities within plugins
   - Defined by skill.md files
   - Optional manifest.json for metadata

---

## Plugin Structure

### Standard Plugin Layout

```
plugin-name/
├── .claude-plugin/           # Metadata directory
│   └── plugin.json          # Plugin configuration (REQUIRED)
├── agents/                  # Interactive agents
│   └── plugin-name-tutor.md # Main agent (optional)
├── skills/                  # Capabilities
│   ├── skill-one/
│   │   ├── skill.md        # Skill definition (REQUIRED)
│   │   └── manifest.json   # Additional metadata (optional)
│   └── skill-two/
│       └── skill.md
├── plugin.md               # Developer documentation (recommended)
└── README.md               # User documentation (recommended)
```

### File Relationships

```
plugin.json
    │
    ├─> agents: "./agents/plugin-name-tutor.md"
    │             │
    │             └─> Agent implementation file
    │
    └─> skills: "./skills"
                  │
                  ├─> skill-one/skill.md
                  └─> skill-two/skill.md
```

### Metadata Flow

```
marketplace.json
    ├─> plugins[0].name: "plugin-name"
    │   plugins[0].source: "./plugin-name"
    │   plugins[0].version: "1.0.0"
    │
    └─> Resolves to: plugin-name/
                          └─> .claude-plugin/plugin.json
                                  ├─> name: "plugin-name" (MUST match)
                                  └─> version: "1.0.0" (MUST match)
```

---

## Data Flow

### Plugin Discovery and Installation

```
1. User adds marketplace
   /plugin marketplace add /path/to/claude-priority

2. Claude Code reads marketplace.json
   ┌─> Lists plugins
   ├─> Verifies structure
   └─> Makes plugins available

3. User installs plugin
   /plugin install plugin-name@marketplace-name

4. Claude Code:
   ┌─> Reads plugin.json
   ├─> Discovers agents
   ├─> Discovers skills
   └─> Makes plugin available

5. User enables plugin
   /plugin enable plugin-name

6. Plugin is active
   ┌─> Skills listen for triggers
   └─> Agents ready for invocation
```

### Skill Activation Flow

```
User Input: "trigger phrase"
    │
    ▼
Claude Code matches trigger to skill
    │
    ▼
Skill.md frontmatter checked
    ├─> name
    ├─> description
    └─> license
    │
    ▼
Skill behavior executed
    ├─> Read content
    ├─> Parse instructions
    ├─> Execute workflow
    └─> Return response
    │
    ▼
User receives response
```

### Agent Invocation Flow

```
User Input: "help with X" or direct agent trigger
    │
    ▼
Agent markdown file loaded
    │
    ▼
Agent workflow phases executed
    ├─> Phase 1: Initialization
    ├─> Phase 2: Analysis
    ├─> Phase 3: Action
    ├─> Phase 4: Reporting
    └─> Phase 5: Completion
    │
    ▼
Tools invoked as needed
    ├─> Read (view files)
    ├─> Write (create files)
    ├─> Edit (modify files)
    ├─> Bash (run commands)
    ├─> Glob (find files)
    └─> Grep (search content)
    │
    ▼
Results returned to user
```

---

## Design Patterns

### 1. Convention Over Configuration

**Pattern**: Use strict naming conventions to eliminate configuration
**Implementation**:
- Directories: lowercase-with-hyphens
- Files: Predictable locations (skill.md, plugin.json)
- Names: Must match between directories and metadata

**Benefits**:
- Reduces cognitive load
- Enables automatic validation
- Facilitates tooling
- Improves consistency

### 2. Self-Documenting Structure

**Pattern**: Structure implies purpose, names explain function
**Implementation**:
- Directory names indicate content type (agents/, skills/)
- File names indicate purpose (skill.md, plugin.json)
- Metadata embedded in frontmatter

**Benefits**:
- Easy to navigate
- Clear intent
- Self-explanatory
- Reduces documentation burden

### 3. Validation as Code

**Pattern**: Validation rules are executable scripts
**Implementation**:
- validate-naming.sh: Naming conventions
- validate-json.sh: Schema compliance
- validate-frontmatter.sh: Metadata correctness

**Benefits**:
- Consistent enforcement
- CI/CD integration
- Pre-commit validation
- Developer feedback loop

### 4. Template-Driven Development

**Pattern**: Generate correct structure from templates
**Implementation**:
- skill.md.template
- plugin.json.template
- marketplace.json.template
- agent.md.template

**Benefits**:
- Correct by default
- Faster development
- Consistency
- Educational value

### 5. Progressive Enhancement

**Pattern**: Start simple, add complexity as needed
**Implementation**:
- hello-world: Simplest possible skill
- status-checker: Adds interactivity
- example-plugin-tutor: Full agent capabilities

**Benefits**:
- Lower barrier to entry
- Clear learning path
- Scalable complexity
- Educational progression

### 6. Separation of Concerns

**Pattern**: Each component has a single, clear responsibility
**Implementation**:
- Skills: Focused capabilities
- Agents: Complex workflows
- Validators: Quality enforcement
- Templates: Structure generation

**Benefits**:
- Modularity
- Maintainability
- Testability
- Reusability

---

## Implementation Details

### Plugin-Formatter Architecture

```
plugin-formatter/
├── Agent: plugin-formatter-tutor.md
│   ├─> Orchestrates validation workflow
│   ├─> Applies auto-fixes
│   └─> Generates reports
│
├── Skill: plugin-formatter
│   ├─> Activates formatter
│   └─> Delegates to agent
│
├── Scripts:
│   ├─> validate-naming.sh
│   ├─> validate-json.sh
│   └─> validate-frontmatter.sh
│
├── Schemas:
│   ├─> plugin-schema.json
│   └─> marketplace-schema.json
│
└── Templates:
    ├─> skill.md.template
    ├─> plugin.json.template
    ├─> README.md.template
    └─> etc.
```

**Workflow**:
1. User triggers: "format this plugin"
2. Skill activates plugin-formatter
3. Agent loads and begins 5-phase process:
   - Phase 1: Discovery (scan structure)
   - Phase 2: Validation (run scripts)
   - Phase 3: Auto-Fix (apply fixes)
   - Phase 4: Reporting (generate report)
   - Phase 5: Interaction (user confirmation)

### Claude-Prioritise Architecture

```
claude-prioritise/
├── Agent: claude-prioritise-tutor.md
│   ├─> Manages persistence
│   ├─> Syncs with GitHub
│   └─> Calculates priorities
│
├── Skill: project-status
│   ├─> Activates status check
│   └─> Delegates to agent
│
└── Persistence:
    ├─> log.md (activity log)
    ├─> ideas.md (backlog)
    └─> todo.md (current tasks)
```

**Workflow**:
1. User triggers: "What should I work on?"
2. Skill activates project-status
3. Agent executes 8-phase workflow:
   - Phase 1: Initialize persistence files
   - Phase 2: Sync with GitHub (gh CLI)
   - Phase 3: Read persistent data
   - Phase 4: Calculate priorities
   - Phase 5: Generate status report
   - Phase 6: Append to log
   - Phase 7: Handle backlog operations
   - Phase 8: Provide smart suggestions

**Priority Scoring Algorithm**:
```
Score = (Priority × 3) + (Age × 2) + (Context × 2) + (Dependencies × 3) + (Quick Win × 1)

Where:
- Priority: High=3, Medium=2, Low=1
- Age: Days in backlog (capped at 10)
- Context: Related to recent work (0-3)
- Dependencies: Number of blocked tasks (0-5)
- Quick Win: Estimated effort Low=1, High=0
```

### Example-Plugin Architecture

```
example-plugin/
├── Agent: example-plugin-tutor.md
│   └─> Interactive teaching guide
│
├── Skills:
│   ├─> hello-world (basic example)
│   └─> status-checker (interactive example)
│
└── Documentation:
    ├─> README.md (user-facing)
    └─> plugin.md (developer-facing)
```

**Educational Progression**:
1. **hello-world**: Learn absolute basics
2. **status-checker**: Add interactivity
3. **example-plugin-tutor**: Master agents

---

## Data Models

### Marketplace Metadata

```json
{
  "name": "marketplace-name",
  "owner": {
    "name": "Owner Name"
  },
  "description": "Marketplace description",
  "version": "X.Y.Z",
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./relative/path",
      "description": "Plugin description",
      "version": "X.Y.Z",
      "author": {"name": "Author Name"},
      "keywords": ["tag1", "tag2"],
      "category": "category-name"
    }
  ]
}
```

### Plugin Metadata

```json
{
  "name": "plugin-name",
  "version": "X.Y.Z",
  "description": "10-200 char description",
  "author": {
    "name": "Author Name",
    "url": "https://optional"
  },
  "homepage": "https://optional",
  "repository": "https://optional",
  "license": "MIT|Apache-2.0|GPL-3.0|BSD-3-Clause|CC-BY-SA|Unlicense",
  "keywords": ["array", "of", "strings"],
  "agents": "./agents/plugin-name-tutor.md",
  "skills": "./skills"
}
```

### Skill Frontmatter

```yaml
---
name: skill-name
description: 10-200 char description
license: MIT
---
```

### Persistence Data (claude-prioritise)

```markdown
# log.md structure
## YYYY-MM-DD HH:MM
- Activity description
- Current state: X done, Y in progress, Z not started
- Priorities: list
- GitHub: status

# ideas.md structure
## High Priority
- [DUE: YYYY-MM-DD] Task description
- [URGENT] Another task

## Medium Priority
- Regular task
...

# todo.md structure
## Done ✅
- [x] Completed task

## In Progress 🔄
- [ ] 🔄 Active task

## Not Started 📋
- [ ] 📋 Pending task
```

---

## Quality Assurance

### Validation Layers

1. **Syntactic**: JSON validity, YAML validity
2. **Semantic**: Schema compliance, field types
3. **Conventional**: Naming patterns, structure
4. **Relational**: Name matching, version consistency

### Enforcement Points

1. **Development**: Pre-commit hooks
2. **CI/CD**: GitHub Actions workflows
3. **Runtime**: Skill activation checks
4. **Installation**: Marketplace validation

---

## Extension Points

### Adding New Plugins

1. Copy example-plugin structure
2. Modify metadata (plugin.json)
3. Create skills (skills/*/skill.md)
4. Optionally create agent
5. Add to marketplace.json
6. Validate and test

### Adding Validation Rules

1. Create new script in scripts/
2. Follow existing pattern (naming, json, frontmatter)
3. Update pre-commit hook
4. Update CI/CD workflow
5. Document in CONTRIBUTING.md

### Adding Templates

1. Create .template file in templates/
2. Use {{placeholder}} syntax
3. Document placeholders
4. Reference in agent workflow

---

## Performance Considerations

### File I/O
- Minimal file reads (only when needed)
- Batch operations where possible
- Cache validation results

### Validation
- Fail fast on critical errors
- Parallelize independent checks
- Skip unchanged files (git hooks)

### Persistence
- Append-only log (no rewrites)
- Truncate old entries (size management)
- Async writes (non-blocking)

---

## Security Considerations

### Input Validation
- All user paths sanitized
- JSON parsed safely
- Shell commands escaped

### File Operations
- Verify file existence
- Check permissions
- Backup before overwrite

### External Commands
- Whitelist allowed commands
- Validate arguments
- Handle errors gracefully

---

## Future Architecture

### Potential Enhancements

1. **Plugin Versioning**: Semantic version resolution
2. **Dependency Management**: Inter-plugin dependencies
3. **Remote Marketplace**: Network-based distribution
4. **Binary Distribution**: Compiled validators
5. **Interactive Installer**: Guided setup wizard
6. **Plugin Testing Framework**: Automated testing
7. **Performance Monitoring**: Metrics collection
8. **Telemetry**: Usage analytics (opt-in)

---

## Conclusion

The Claude Priority marketplace architecture demonstrates:
- **Clean separation** of concerns
- **Progressive complexity** from simple to advanced
- **Self-validation** and quality enforcement
- **Educational value** through examples
- **Production readiness** with robust error handling
- **Extensibility** for future growth

This architecture serves as both a functional marketplace and a reference implementation for Claude Code plugin development.
