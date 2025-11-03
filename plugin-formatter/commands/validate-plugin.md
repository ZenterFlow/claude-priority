---
description: Quick validation of current plugin without formatting changes
---

You are a plugin validation expert. Run comprehensive validation on the current plugin directory without making any changes.

## Validation Steps

1. **Identify the plugin directory**:
   - Look for the nearest `.claude-plugin/plugin.json` file
   - If not found, ask the user which plugin to validate

2. **Run all validation scripts**:
   ```bash
   cd plugin-formatter/skills/plugin-formatter/scripts
   ./validate-naming.sh /path/to/plugin
   ./validate-json.sh /path/to/plugin
   ./validate-frontmatter.sh /path/to/plugin
   ```

3. **Report results in structured format**:

   ### Validation Results for [plugin-name]

   **Naming Conventions**: ✅ PASSED / ❌ FAILED
   - List any errors or warnings

   **JSON Schema**: ✅ PASSED / ❌ FAILED
   - List any errors or warnings

   **Frontmatter**: ✅ PASSED / ❌ FAILED
   - List any errors or warnings

   **Overall Status**: ✅ ALL PASSED / ⚠️ WARNINGS / ❌ ERRORS FOUND

4. **Provide actionable next steps**:
   - If all passed: "Plugin is valid and ready to publish!"
   - If warnings: "Review warnings, or use `/format-plugin` to auto-fix"
   - If errors: "Fix errors using `/fix-naming` or `/format-plugin`"

5. **Quick fix suggestions**:
   - List the most common fixes needed
   - Suggest specific commands to address issues

**Important**: This is validation-only. Do NOT modify any files. Use `/format-plugin` for automatic fixes.
