---
description: Create a new Claude Code plugin from template
---

You are a plugin scaffolding expert. Create a complete Claude Code plugin structure from scratch.

## Plugin Creation Process

1. **Gather plugin information**:
   Ask the user for:
   - Plugin name (will be converted to lowercase-with-hyphens)
   - Description (10-200 characters)
   - Author name
   - Author email (optional)
   - Author URL (optional)
   - License (suggest MIT, Apache-2.0, GPL-3.0)
   - Plugin type: skill / agent / command / hook / mcp / combination

2. **Create directory structure**:
   ```bash
   mkdir -p {plugin-name}/.claude-plugin
   mkdir -p {plugin-name}/skills/{plugin-name}
   mkdir -p {plugin-name}/agents
   ```

3. **Generate plugin.json**:
   ```json
   {
     "name": "{plugin-name}",
     "version": "0.1.0",
     "description": "{user-provided description}",
     "author": {
       "name": "{author-name}",
       "email": "{author-email}",
       "url": "{author-url}"
     },
     "license": "{license}",
     "keywords": ["keyword1", "keyword2"]
   }
   ```

4. **Create appropriate structure based on type**:

   **For Skill Plugin**:
   - Create `skills/{plugin-name}/skill.md` with template
   - Add frontmatter with name, description, license
   - Add SKILL: heading and sections

   **For Agent Plugin**:
   - Create `agents/{plugin-name}-tutor.md` with template
   - Add frontmatter and agent instructions

   **For Command Plugin**:
   - Create `commands/` directory
   - Add example command file
   - Create `.hooks.json` if needed

   **For Hook Plugin**:
   - Create `hooks/` directory
   - Add example hook script
   - Create `.hooks.json` configuration

   **For MCP Plugin**:
   - Create `.mcp.json` configuration
   - Add example MCP server config
   - Add documentation

5. **Generate README.md**:
   ```markdown
   # {Plugin Name}

   {Description}

   ## Installation

   ## Usage

   ## Features

   ## License

   {License} - See LICENSE file for details
   ```

6. **Generate plugin.md**:
   ```markdown
   # {Plugin Name}

   ## Purpose
   {Description}

   ## Features
   - Feature 1
   - Feature 2

   ## Version History

   ### v0.1.0 (YYYY-MM-DD)
   - Initial release
   ```

7. **Create LICENSE file**:
   Add appropriate license text based on user selection

8. **Add .gitignore** (if needed):
   ```
   .DS_Store
   node_modules/
   *.log
   ```

9. **Validate the generated plugin**:
   ```bash
   cd plugin-formatter/skills/plugin-formatter/scripts
   ./validate-naming.sh /path/to/new-plugin
   ./validate-json.sh /path/to/new-plugin
   ./validate-frontmatter.sh /path/to/new-plugin
   ```

10. **Report results**:
    ```
    ✅ Plugin created: {plugin-name}/

    Structure:
    {plugin-name}/
    ├── .claude-plugin/plugin.json
    ├── skills/{plugin-name}/skill.md
    ├── README.md
    ├── plugin.md
    └── LICENSE

    Next steps:
    1. Customize skill.md with your plugin behavior
    2. Update README.md with usage instructions
    3. Test your plugin: /plugin install ./{plugin-name}
    4. Validate: /validate-plugin
    ```

## Template Customization

Based on plugin type, include:
- **Skills**: activation triggers, behavior sections
- **Agents**: interactive tutor pattern, conversation flow
- **Commands**: command frontmatter, prompt template
- **Hooks**: hook scripts, configuration files
- **MCP**: server configuration, connection details

All templates should follow the patterns from `example-plugin/` as reference.
