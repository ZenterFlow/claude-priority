---
description: Validate JSON schema compliance for plugin.json and marketplace.json
---

You are a JSON schema validation expert. Check plugin.json and marketplace.json files against official Claude Code schemas.

## Validation Process

1. **Locate JSON files**:
   - Find `.claude-plugin/plugin.json` in current plugin
   - Find `.claude-plugin/marketplace.json` if in marketplace root
   - Find `.hooks.json` if hooks are configured
   - Find `.mcp.json` if MCP servers are configured

2. **Validate JSON syntax**:
   ```bash
   python -m json.tool file.json
   ```
   Report any syntax errors with line numbers

3. **Check against schema**:
   Use schemas from `plugin-formatter/skills/plugin-formatter/schemas/`

   **plugin.json required fields**:
   - ✅ name (string, lowercase-with-hyphens)

   **Recommended fields**:
   - version (semantic: X.Y.Z)
   - description (10-200 chars)
   - author (object with name, optional email/url)
   - homepage (URL)
   - repository (URL)
   - license (string)
   - keywords (array)

4. **Check field formats**:
   - **version**: Must match `^\d+\.\d+\.\d+$`
   - **author**: Must be object, not string
   - **name**: Must match `^[a-z0-9-]+$`
   - **URLs**: Must be valid URI format
   - **email**: Must be valid email format

5. **Validate component paths** (if present):
   - **agents**: String or array of `.md` file paths
   - **commands**: String or array of directory/file paths
   - **hooks**: Path to `.json` config or inline object
   - **mcpServers**: Path to `.json` config or inline object
   - All paths must start with `./`

6. **Check referenced files exist**:
   - If agents field points to file, verify it exists
   - If commands field points to directory, verify it exists
   - If hooks/mcpServers point to files, verify they exist

7. **Report results**:

   ### Schema Validation Results

   **plugin.json**:
   - ✅ Valid JSON syntax
   - ✅ Required fields present
   - ⚠️ Missing recommended field: license
   - ❌ Invalid version format: "1.0" (should be "1.0.0")

   **Fixes needed**:
   1. Update version to semantic format
   2. Add license field

   **Quick fix**:
   ```json
   {
     "version": "1.0.0",
     "license": "MIT"
   }
   ```

8. **Suggest improvements**:
   - Add missing recommended fields
   - Fix format violations
   - Add keywords for better discovery
   - Complete author information

Use `/format-plugin` to apply automatic fixes, or manually edit the JSON files.
