# Testing Checklist for Claude Priority Marketplace

This document provides a step-by-step testing procedure to verify the marketplace and plugins are working correctly.

## Pre-Testing Setup

**Current Directory Structure:**
```
claude-priority/
├── .claude-plugin/
│   └── marketplace.json ✓
├── plugin-formatter/
│   ├── .claude-plugin/
│   │   └── plugin.json ✓
│   ├── agents/
│   │   └── plugin-formatter-tutor.md ✓
│   ├── skills/
│   │   └── plugin-formatter/
│   │       ├── skill.md ✓
│   │       ├── rules.md ✓
│   │       ├── schemas/ ✓
│   │       └── templates/ ✓
│   ├── plugin.md ✓
│   └── README.md ✓
├── claude-prioritise/
│   ├── .claude-plugin/
│   │   └── plugin.json ✓
│   ├── agents/
│   │   └── claude-prioritise-tutor.md ✓
│   ├── skills/
│   │   └── project-status/
│   │       └── skill.md ✓
│   ├── persistence/
│   │   ├── log.md ✓
│   │   ├── ideas.md ✓
│   │   └── todo.md ✓
│   ├── plugin.md ✓
│   └── README.md ✓
└── README.md
```

---

## Test 1: Marketplace Installation

### Commands to Run:
```
/plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority
```

**Alternative (if backslashes don't work):**
```
/plugin marketplace add C:/Users/jonat/Documents/Tech/claude-priority
```

**Alternative (using current directory):**
```
/plugin marketplace add .
```

### Expected Results:
- [ ] Success message appears
- [ ] No error messages

### Verification Command:
```
/plugin marketplace list
```

### Expected Output:
- [ ] "claude-priority" appears in the marketplace list
- [ ] Shows version "1.0.0"
- [ ] Shows 2 plugins available

### Troubleshooting:
- If marketplace doesn't appear: Check that `.claude-plugin/marketplace.json` exists
- If path error: Try using forward slashes or relative path

---

## Test 2: View Available Plugins

### Command to Run:
```
/plugin
```

### Expected Results:
- [ ] UI/menu shows available plugins
- [ ] "plugin-formatter" appears in the list
- [ ] "claude-prioritise" appears in the list
- [ ] Descriptions are visible
- [ ] Can see they're from "claude-priority" marketplace

### Indicators of Success:
- Both plugins listed with their descriptions
- Category shows "tools"
- Version shows "1.0.0"

---

## Test 3: Install plugin-formatter

### Command to Run:
```
/plugin install plugin-formatter@claude-priority
```

### Expected Results:
- [ ] Installation starts
- [ ] Success message appears
- [ ] No errors during installation

### Verification Command:
```
/plugin list
```

### Expected Output:
- [ ] "plugin-formatter" appears in installed plugins list
- [ ] Shows version "1.0.0"
- [ ] Shows status (may be "disabled" initially)

### File System Check:
After installation, check if plugin files were copied to Claude's plugin directory:
- Windows: `%APPDATA%\Claude\plugins\plugin-formatter\`
- Mac: `~/Library/Application Support/Claude/plugins/plugin-formatter/`

**Files that should exist:**
- [ ] `.claude-plugin/plugin.json`
- [ ] `agents/plugin-formatter-tutor.md`
- [ ] `skills/plugin-formatter/skill.md`

---

## Test 4: Install claude-prioritise

### Command to Run:
```
/plugin install claude-prioritise@claude-priority
```

### Expected Results:
- [ ] Installation starts
- [ ] Success message appears
- [ ] No errors during installation

### Verification Command:
```
/plugin list
```

### Expected Output:
- [ ] "claude-prioritise" appears in installed plugins list
- [ ] Shows version "1.0.0"
- [ ] Shows status (may be "disabled" initially)

---

## Test 5: Enable plugin-formatter

### Command to Run:
```
/plugin enable plugin-formatter
```

### Expected Results:
- [ ] Plugin enabled successfully
- [ ] Success confirmation message

### Verification Command:
```
/plugin list
```

### Expected Output:
- [ ] "plugin-formatter" shows status "enabled" or has a checkmark
- [ ] No error indicators

---

## Test 6: Enable claude-prioritise

### Command to Run:
```
/plugin enable claude-prioritise
```

### Expected Results:
- [ ] Plugin enabled successfully
- [ ] Success confirmation message

### Verification Command:
```
/plugin list
```

### Expected Output:
- [ ] "claude-prioritise" shows status "enabled" or has a checkmark
- [ ] No error indicators

---

## Test 7: Test plugin-formatter Functionality

### Test Phrase 1:
```
format this plugin
```

### Expected Results:
- [ ] Plugin responds (not "I don't understand")
- [ ] Response mentions plugin formatting
- [ ] May ask for plugin directory or show formatting analysis

### Test Phrase 2:
```
validate plugin format
```

### Expected Results:
- [ ] Similar response to Test Phrase 1
- [ ] Shows it's analyzing or checking plugin structure

### Test Phrase 3:
```
check plugin compliance
```

### Expected Results:
- [ ] Plugin engages with the request
- [ ] Shows it understands plugin validation context

### Indicators of Success:
- Plugin recognizes the trigger phrases
- Provides relevant responses about plugin formatting
- Doesn't say "I don't have access to that skill"

---

## Test 8: Test claude-prioritise Functionality

### Test Phrase 1:
```
What should I work on?
```

### Expected Results:
- [ ] Plugin responds with project status information
- [ ] Shows format with status indicators (📊, 🎯, 🚀) or similar
- [ ] Provides task suggestions

### Example Expected Output:
```
📊  Current status: X done, Y in progress, Z not started
🎯  Last activity:  [some recent activity]
🚀  Suggested next steps:
- [task 1]
- [task 2]
- [task 3]
```

### Test Phrase 2:
```
Show project status
```

### Expected Results:
- [ ] Similar output to Test Phrase 1
- [ ] Shows understanding of project status context

### Test Phrase 3:
```
Update backlog
```

### Expected Results:
- [ ] Plugin engages with backlog management
- [ ] May update or show current backlog

### File System Check:
After running, check if persistence files were updated:
- [ ] `persistence/log.md` has new entries
- [ ] `persistence/todo.md` exists and has content
- [ ] `persistence/ideas.md` exists

---

## Test 9: Test Agent Invocation (Advanced)

If Claude Code supports agent invocation:

### For plugin-formatter-tutor:
```
Can you help me format a plugin?
```

### Expected Results:
- [ ] Agent responds with guidance
- [ ] Shows understanding of plugin formatting process

### For claude-prioritise-tutor:
```
Help me prioritize my tasks
```

### Expected Results:
- [ ] Agent provides priority guidance
- [ ] Shows project management context

---

## Test 10: Test Skill Discovery

### Command:
```
/skills list
```
(if this command exists)

### Expected Results:
- [ ] Shows "plugin-formatter" skill
- [ ] Shows "project-status" skill
- [ ] Skills are marked as available/enabled

---

## Final Verification Checklist

### Marketplace Level:
- [ ] Marketplace added successfully
- [ ] Marketplace appears in list
- [ ] Both plugins visible in marketplace

### Installation Level:
- [ ] Both plugins installed without errors
- [ ] Both plugins appear in `/plugin list`
- [ ] Plugin files exist in Claude's plugin directory

### Enablement Level:
- [ ] Both plugins enabled successfully
- [ ] Both show "enabled" status

### Functionality Level:
- [ ] plugin-formatter responds to trigger phrases
- [ ] claude-prioritise responds to trigger phrases
- [ ] Agents accessible (if applicable)
- [ ] Skills function correctly

### Persistence Level (claude-prioritise):
- [ ] Persistence directory created
- [ ] Log file updated on use
- [ ] Todo and ideas files exist and are usable

---

## Success Criteria

**Complete Success = ALL of the following:**
1. ✅ Marketplace installed and listed
2. ✅ Both plugins installed
3. ✅ Both plugins enabled
4. ✅ plugin-formatter responds to at least 2 out of 3 test phrases
5. ✅ claude-prioritise responds to at least 2 out of 3 test phrases
6. ✅ No error messages at any step

**Partial Success = Some issues but core functionality works:**
- Marketplace and plugins installed
- At least one plugin working
- Minor issues with triggers or features

**Failure Indicators:**
- ❌ Cannot add marketplace
- ❌ Plugins won't install
- ❌ Plugins install but won't enable
- ❌ Plugins enabled but don't respond to any trigger phrases
- ❌ Consistent error messages

---

## Common Issues and Solutions

### Issue: "Marketplace not found"
**Solution:** Check the path is correct and `.claude-plugin/marketplace.json` exists

### Issue: "Plugin installation failed"
**Solution:** Check `plugin.json` syntax, ensure all required fields present

### Issue: "Plugin enabled but doesn't respond"
**Solution:** Check that `skill.md` has correct frontmatter and trigger phrases

### Issue: "Skills not recognized"
**Solution:** Verify skill directory structure and `skill.md` format

### Issue: "Agent not found"
**Solution:** Check agent markdown file exists in `agents/` directory

---

## Logging Test Results

Record your results here:

**Date Tested:** _______________

**Test 1 (Marketplace Install):** ☐ Pass ☐ Fail
**Test 2 (View Plugins):** ☐ Pass ☐ Fail
**Test 3 (Install plugin-formatter):** ☐ Pass ☐ Fail
**Test 4 (Install claude-prioritise):** ☐ Pass ☐ Fail
**Test 5 (Enable plugin-formatter):** ☐ Pass ☐ Fail
**Test 6 (Enable claude-prioritise):** ☐ Pass ☐ Fail
**Test 7 (Test plugin-formatter):** ☐ Pass ☐ Fail
**Test 8 (Test claude-prioritise):** ☐ Pass ☐ Fail

**Overall Result:** ☐ Complete Success ☐ Partial Success ☐ Failure

**Notes:**
_______________________________________________
_______________________________________________
_______________________________________________
