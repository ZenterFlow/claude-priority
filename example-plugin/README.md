# Example Plugin

**A complete reference implementation demonstrating all Claude Code plugin features and best practices**

## What This Plugin Teaches
- How to structure a Claude Code plugin correctly
- Creating effective skills with clear triggers and behavior
- Implementing interactive agents for complex workflows
- Proper frontmatter and metadata formatting
- Naming conventions (lowercase-with-hyphens)
- Documentation best practices
- Validation and testing approaches

## Skills Included

1. **hello-world**: Simple greeting skill demonstrating basic skill structure, activation triggers, and responses. Perfect for learning the fundamentals.

2. **status-checker**: Interactive skill that performs system diagnostics, demonstrates formatted output, and provides actionable recommendations. Shows how to use tools and handle dependencies.

## Agent

**example-plugin-tutor**: Interactive guide that walks you through plugin development concepts, demonstrates skills in action, explains best practices, and helps troubleshoot issues. Tailors explanations to your experience level.

The agent provides:
- Step-by-step plugin creation guidance
- Live skill demonstrations
- Validation and debugging help
- Best practices teaching
- Hands-on learning opportunities

## How to Use

### Installation
```bash
# Add marketplace (if not already added)
/plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority

# Install example plugin
/plugin install example-plugin@claude-priority

# Enable plugin
/plugin enable example-plugin
```

### Activation
Activate by asking questions or using phrases like:
- "say hello" (hello-world skill)
- "check system status" (status-checker skill)
- "help with example plugin" (interactive agent)
- "how do I create a plugin?" (interactive agent)

### Example Sessions

**Simple Skill:**
```
User: "say hello"

Plugin: 👋 Hello! I'm the hello-world skill from the example-plugin.

I demonstrate:
• Basic skill structure
• Activation triggers
• Simple responses
• Frontmatter usage

Try asking:
- "check system status" (status-checker skill)
- "help with example plugin" (agent assistance)
```

**Interactive Skill:**
```
User: "check system status"

Plugin: 🔍 Running system diagnostics...

SYSTEM STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Operating System: Windows 11
✅ Git: v2.42.0
✅ Node.js: v20.10.0
⚠️  Python: Not found
...
```

**Agent Assistance:**
```
User: "How do I create a plugin?"

Agent: Great question! Let me walk you through plugin creation...

A plugin has 4 essential components:
1. plugin.json - Metadata
2. skills/ - Capabilities
3. agents/ - Interactive guides (optional)
4. README.md - Documentation

Would you like to:
A) See an example structure
B) Create a plugin together
C) Learn about a specific component
```

## File Structure
```
example-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin metadata (all fields demonstrated)
├── agents/
│   └── example-plugin-tutor.md  # Interactive teaching agent
├── skills/
│   ├── hello-world/             # Simple skill example
│   │   └── skill.md
│   └── status-checker/          # Interactive skill example
│       └── skill.md
├── plugin.md                    # Plugin documentation
└── README.md                    # This file
```

## What Makes This a Good Example

### 1. Perfect Structure
- All directories and files follow lowercase-with-hyphens convention
- Complete metadata in plugin.json (all optional fields included)
- Proper frontmatter in all skill.md files
- Comprehensive documentation

### 2. Progressive Complexity
- **hello-world**: Absolute basics
- **status-checker**: Intermediate features
- **example-plugin-tutor**: Advanced agent patterns

### 3. Best Practices Demonstrated
- ✅ Descriptive skill names
- ✅ Clear, natural trigger phrases
- ✅ Well-documented behavior
- ✅ Example usage included
- ✅ Proper error handling
- ✅ Formatted output
- ✅ Actionable responses

### 4. Learning Resources
- Inline comments in plugin.json
- Detailed explanations in skill.md files
- Interactive agent for Q&A
- References to validation tools
- Links to templates

## Validation

This plugin passes all validation checks:

```bash
# Run naming validation
./plugin-formatter/skills/plugin-formatter/scripts/validate-naming.sh example-plugin

# Run JSON validation
./plugin-formatter/skills/plugin-formatter/scripts/validate-json.sh example-plugin

# Run frontmatter validation
./plugin-formatter/skills/plugin-formatter/scripts/validate-frontmatter.sh example-plugin
```

All checks: ✅ PASS

## Use Cases

### For Learning
- Study the structure to understand plugin anatomy
- Copy and modify for your own plugins
- Reference skill patterns
- Learn from the agent implementation

### For Development
- Use as a template for new plugins
- Copy skills and adapt them
- Reference for validation compliance
- Test validation scripts

### For Teaching
- Share with others learning plugin development
- Use in tutorials and workshops
- Demonstrate best practices
- Interactive learning with the agent

## Dependencies

**Required:**
- Claude Code (obviously!)

**Optional (for status-checker):**
- Git (for repository checks)
- Node.js (for version detection)
- Python (for version detection)
- GitHub CLI (for enhanced features)

## Status
Active - 2 skills, 1 agent

Perfect example implementation demonstrating all marketplace features and conventions.

## Version
v1.0.0 (2025-11-02)

## License
MIT
