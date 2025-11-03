# Contributing to Claude Priority Marketplace

Thank you for your interest in contributing to the Claude Priority marketplace! This document provides guidelines and instructions for contributing new plugins or improving existing ones.

## Table of Contents
- [Getting Started](#getting-started)
- [Plugin Development Guidelines](#plugin-development-guidelines)
- [Validation Requirements](#validation-requirements)
- [Submission Process](#submission-process)
- [Code of Conduct](#code-of-conduct)

---

## Getting Started

### Prerequisites
- Claude Code CLI installed
- Git installed
- Basic understanding of markdown and JSON
- Familiarity with Claude Code plugin structure

### Development Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ZenterFlow/claude-priority.git
   cd claude-priority
   ```

2. **Install git hooks:**
   ```bash
   cp .githooks/pre-commit .git/hooks/pre-commit
   chmod +x .git/hooks/pre-commit
   ```

3. **Install the marketplace locally:**
   ```bash
   /plugin marketplace add $(pwd)
   ```

4. **Test existing plugins:**
   ```bash
   /plugin install plugin-formatter@claude-priority
   /plugin enable plugin-formatter
   ```

---

## Plugin Development Guidelines

### Creating a New Plugin

1. **Use the example-plugin as a template:**
   ```bash
   cp -r example-plugin my-new-plugin
   cd my-new-plugin
   ```

2. **Update plugin.json:**
   ```json
   {
     "name": "my-new-plugin",
     "version": "1.0.0",
     "description": "Clear description of what your plugin does (10-200 chars)",
     "author": {
       "name": "Your Name"
     },
     "license": "MIT",
     "keywords": ["keyword1", "keyword2"],
     "agents": "./agents/my-new-plugin-tutor.md",
     "skills": "./skills"
   }
   ```

3. **Create your skills:**
   ```bash
   mkdir -p skills/my-skill
   ```

4. **Follow naming conventions:**
   - **MUST**: Use lowercase-with-hyphens for all directories and names
   - **Examples**: `my-skill`, `hello-world`, `status-checker`
   - **NOT**: `MySkill`, `my_skill`, `mySkill`

### Skill Structure

Each skill must have a `skill.md` file with this structure:

```markdown
---
name: my-skill              # Must match directory name
description: Brief description (10-200 chars)
license: MIT
---

# SKILL: my-skill

Clear purpose statement explaining what this skill does.

## Triggers
- "natural trigger phrase 1"
- "natural trigger phrase 2"
- "natural trigger phrase 3"

## Behaviour

### Step 1: First Action
Describe what happens first...

### Step 2: Next Action
Describe what happens next...

### Step 3: Final Action
Describe the outcome...

## Example Usage

**User**: "example trigger"

**Skill**:
```
Expected output or behavior
```
```

### Agent Structure

Agents are optional but recommended for complex plugins:

```markdown
---
name: my-plugin-tutor
description: Interactive guide for my plugin
---

# My Plugin Tutor Agent

## Purpose
Guide users through using my plugin...

## Activation
This agent is invoked when users ask for help...

## Workflow

### Phase 1: Introduction
...

### Phase 2: Main Content
...

## Skills and Tools Used
...
```

---

## Validation Requirements

All plugins **MUST** pass these validation checks before submission:

### 1. Naming Conventions
```bash
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh my-new-plugin
```

**Requirements:**
- Plugin directory: lowercase-with-hyphens
- plugin.json name field: matches directory
- Skill directories: lowercase-with-hyphens
- Skill frontmatter names: match directories

### 2. JSON Schema
```bash
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh my-new-plugin
```

**Requirements:**
- Valid JSON syntax
- Required fields: name, version, description, author
- Author field: object with "name" property (not string)
- Version: semantic (X.Y.Z)
- Description: 10-200 characters

### 3. Frontmatter
```bash
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh my-new-plugin
```

**Requirements:**
- All skill.md files have frontmatter
- Required fields: name, description, license
- Names match directory names
- Description: 10-200 characters

### Running All Validations

```bash
cd my-new-plugin

# Run all checks
../plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh . && \
../plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh . && \
../plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh .
```

### Using the Formatter

If validation fails, use plugin-formatter to auto-fix:

```
# In Claude Code
"format this plugin"
```

The formatter will:
- ✅ Rename directories to lowercase-with-hyphens
- ✅ Convert author strings to objects
- ✅ Fix frontmatter names
- ✅ Add missing fields
- ✅ Generate README if missing

---

## Submission Process

### 1. Prepare Your Plugin

- [ ] Create plugin following guidelines above
- [ ] Run all validation scripts
- [ ] Test plugin installation locally
- [ ] Write comprehensive README.md
- [ ] Create plugin.md documentation
- [ ] Add examples if applicable

### 2. Update Marketplace

Add your plugin to `.claude-plugin/marketplace.json`:

```json
{
  "name": "my-new-plugin",
  "source": "./my-new-plugin",
  "description": "Brief description matching plugin.json",
  "version": "1.0.0",
  "author": {
    "name": "Your Name"
  },
  "keywords": ["keyword1", "keyword2"],
  "category": "tools"
}
```

### 3. Create a Pull Request

1. **Create a branch:**
   ```bash
   git checkout -b add-my-new-plugin
   ```

2. **Commit your changes:**
   ```bash
   git add my-new-plugin/
   git add .claude-plugin/marketplace.json
   git commit -m "Add my-new-plugin

   - Description of what the plugin does
   - List of skills included
   - Any special features or requirements"
   ```

3. **Push and create PR:**
   ```bash
   git push origin add-my-new-plugin
   ```

4. **Open PR on GitHub** with description including:
   - What problem does this plugin solve?
   - What skills are included?
   - Examples of usage
   - Screenshots/demos if applicable

### 4. PR Requirements

Your PR must:
- [ ] Pass all CI/CD checks (GitHub Actions)
- [ ] Include documentation (README.md, plugin.md)
- [ ] Have clear skill.md files with examples
- [ ] Follow naming conventions
- [ ] Pass all validation scripts
- [ ] Not duplicate existing functionality

---

## Code Quality Standards

### Documentation
- **README.md**: User-facing, explains what and how
- **plugin.md**: Developer-facing, explains structure and workflow
- **skill.md**: Clear triggers, behavior, and examples
- **Comments**: In code where logic is complex

### Naming
- **Descriptive**: Names should explain purpose
- **Consistent**: Follow existing patterns
- **Convention**: lowercase-with-hyphens everywhere

### Skills
- **Focused**: One skill = one purpose
- **Clear triggers**: Natural language phrases
- **Examples**: Show actual usage
- **Error handling**: Graceful degradation

### Agents
- **Structured**: Use phases for complex workflows
- **Interactive**: Ask questions, guide users
- **Educational**: Explain concepts, don't just execute
- **Tool usage**: Document what tools the agent uses

---

## Testing Your Plugin

### Manual Testing

1. **Install locally:**
   ```bash
   /plugin marketplace add $(pwd)
   /plugin install my-new-plugin@claude-priority
   /plugin enable my-new-plugin
   ```

2. **Test each skill:**
   - Try all trigger phrases
   - Verify expected behavior
   - Check error cases
   - Test edge cases

3. **Test agent (if applicable):**
   - Follow the workflow
   - Verify all phases work
   - Check tool interactions
   - Test different user responses

### Automated Testing

Run CI checks locally:
```bash
# Validation
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh my-new-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh my-new-plugin
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh my-new-plugin

# Git hook (simulates pre-commit)
.githooks/pre-commit
```

---

## Common Issues and Solutions

### Issue: "Name doesn't match directory"
**Solution:** Ensure frontmatter name exactly matches directory name (lowercase-with-hyphens)

### Issue: "Author field is string"
**Solution:** Change from `"author": "Name"` to `"author": {"name": "Name"}`

### Issue: "Description too short"
**Solution:** Expand to at least 10 characters with meaningful description

### Issue: "Skill not activating"
**Solution:** Check:
- Plugin is enabled (`/plugin list`)
- Trigger phrases are natural and clear
- No typos in skill.md frontmatter

### Issue: "Validation scripts fail"
**Solution:**
1. Read error messages carefully
2. Run `"format this plugin"` in Claude Code
3. Review example-plugin for correct structure
4. Check CLAUDE.md for detailed requirements

---

## Getting Help

- **Documentation**: Read CLAUDE.md, ARCHITECTURE.md, IMPROVEMENTS.md
- **Examples**: Study example-plugin, plugin-formatter, claude-prioritise
- **Issues**: Open a GitHub issue with:
  - Clear description of problem
  - Steps to reproduce
  - Validation output
  - What you've tried

---

## Code of Conduct

### Be Respectful
- Respectful communication
- Constructive feedback
- Welcoming to newcomers
- Collaborative spirit

### Quality Contributions
- Test your code
- Follow guidelines
- Document thoroughly
- Respond to feedback

### No Spam or Low-Effort PRs
- No duplicate plugins
- No malicious code
- No placeholder content
- No untested submissions

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

## Questions?

- Open an issue for questions
- Reference existing plugins for examples
- Use the plugin-formatter to validate
- Check CLAUDE.md for architecture details

**Thank you for contributing to Claude Priority! 🎉**
