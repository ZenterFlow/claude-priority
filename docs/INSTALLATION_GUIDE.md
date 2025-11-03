# Claude Priority Marketplace - Installation & Testing Guide

This guide will help you install and test the Claude Priority marketplace and its plugins. No technical experience required!

---

## Part 1: Installing the Marketplace

### Step 1: Add the Marketplace to Claude Code

1. Open Claude Code
2. Type this command exactly as shown:
   ```
   /plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority
   ```
3. Press Enter

### Step 2: Check if Installation Worked

After pressing Enter, you should see a message that says something like:
- "Marketplace added successfully" or
- "claude-priority marketplace added"

**To double-check the installation:**

Type this command:
```
/plugin marketplace list
```

**What you should see:**
- A list of installed marketplaces
- "claude-priority" should appear in the list

**If you see "claude-priority" in the list = ✅ Installation successful!**

---

## Part 2: Viewing Available Plugins

### Step 3: See What Plugins Are Available

Type this command:
```
/plugin
```

**What you should see:**
A menu or list showing available plugins, including:
- **plugin-formatter** - Tool for formatting plugins
- **claude-prioritise** - Tool for managing project priorities

**If you see these two plugins = ✅ Marketplace is working correctly!**

---

## Part 3: Installing Plugins

### Step 4: Install the plugin-formatter Plugin

Type this command:
```
/plugin install plugin-formatter@claude-priority
```

**What you should see:**
- A message saying "Installing plugin-formatter..."
- Followed by "Plugin installed successfully" or similar

**To check if it installed:**
Type:
```
/plugin list
```

**What you should see:**
- A list of installed plugins
- "plugin-formatter" should be in the list (may show as "enabled" or "disabled")

**If you see plugin-formatter in the list = ✅ Plugin installed!**

### Step 5: Install the claude-prioritise Plugin

Type this command:
```
/plugin install claude-prioritise@claude-priority
```

Follow the same verification process as Step 4.

---

## Part 4: Enabling Plugins

Plugins need to be **enabled** before you can use them.

### Step 6: Enable plugin-formatter

Type this command:
```
/plugin enable plugin-formatter
```

**What you should see:**
- "Plugin enabled successfully" or similar message

**To check if it's enabled:**
Type:
```
/plugin list
```

**What to look for:**
- Next to "plugin-formatter" you should see "enabled" or a checkmark ✓

**If it shows "enabled" = ✅ Plugin is ready to use!**

### Step 7: Enable claude-prioritise

Type this command:
```
/plugin enable claude-prioritise
```

Follow the same verification as Step 6.

---

## Part 5: Testing the Plugins

Now let's make sure the plugins actually work!

### Test 1: Testing plugin-formatter

**Type this phrase:**
```
format this plugin
```

**What you should see:**
- The plugin should respond with information about formatting plugins
- You might see it analyzing files or asking for a plugin directory

**If you see a response from the plugin = ✅ plugin-formatter is working!**

**Alternative test phrase:**
```
validate plugin format
```

### Test 2: Testing claude-prioritise

**Type this phrase:**
```
What should I work on?
```

**What you should see:**
- A response showing project status
- Something like:
  ```
  📊  Current status: X done, Y in progress, Z not started
  🎯  Last activity: [some activity]
  🚀  Suggested next steps:
  - [suggested task 1]
  - [suggested task 2]
  ```

**If you see this kind of status report = ✅ claude-prioritise is working!**

**Alternative test phrases:**
```
Show project status
```
or
```
Update backlog
```

---

## Quick Checklist: How to Know Everything is Working

Use this checklist to verify everything is set up correctly:

- [ ] Marketplace appears in `/plugin marketplace list`
- [ ] Both plugins appear when you type `/plugin`
- [ ] Both plugins appear in `/plugin list` after installation
- [ ] Both plugins show "enabled" in `/plugin list`
- [ ] plugin-formatter responds when you say "format this plugin"
- [ ] claude-prioritise responds when you say "What should I work on?"

**If all boxes are checked = ✅ Complete success! Everything is working!**

---

## Troubleshooting

### If the marketplace doesn't appear:
1. Make sure you typed the path correctly
2. Check that the folder `C:\Users\jonat\Documents\Tech\claude-priority` exists
3. Try using forward slashes instead: `/plugin marketplace add C:/Users/jonat/Documents/Tech/claude-priority`

### If plugins don't appear:
1. Try typing `/plugin marketplace refresh`
2. Check that there's a `.claude-plugin` folder with `marketplace.json` inside

### If plugins won't enable:
1. Make sure they're installed first with `/plugin list`
2. Try uninstalling and reinstalling: `/plugin uninstall plugin-name` then install again

### If plugins don't respond:
1. Make sure they're enabled with `/plugin list`
2. Try disabling and re-enabling: `/plugin disable plugin-name` then `/plugin enable plugin-name`

---

## Summary of All Commands

For quick reference:

| Action | Command |
|--------|---------|
| Add marketplace | `/plugin marketplace add C:\Users\jonat\Documents\Tech\claude-priority` |
| List marketplaces | `/plugin marketplace list` |
| Browse plugins | `/plugin` |
| List installed plugins | `/plugin list` |
| Install plugin-formatter | `/plugin install plugin-formatter@claude-priority` |
| Install claude-prioritise | `/plugin install claude-prioritise@claude-priority` |
| Enable plugin-formatter | `/plugin enable plugin-formatter` |
| Enable claude-prioritise | `/plugin enable claude-prioritise` |
| Test plugin-formatter | Say: "format this plugin" |
| Test claude-prioritise | Say: "What should I work on?" |

---

## What Each Plugin Does

### plugin-formatter
**Purpose:** Helps you format and validate Claude Code plugins to make sure they follow the correct structure and rules.

**When to use it:** When you're creating or modifying a plugin and want to make sure it's set up correctly.

**How to use it:** Just say phrases like:
- "format this plugin"
- "validate plugin format"
- "check plugin compliance"

### claude-prioritise
**Purpose:** Helps you keep track of what you're working on, what's done, and what to do next.

**When to use it:** Whenever you want to see your project status or get suggestions on what to work on next.

**How to use it:** Just say phrases like:
- "What should I work on?"
- "Show project status"
- "Update backlog"

---

**That's it! You now have a fully functional Claude Code marketplace with two working plugins!**
