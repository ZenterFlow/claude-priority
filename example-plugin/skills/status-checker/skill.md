---
name: status-checker
description: Demonstrates interactive skill with system checks and formatted output
license: MIT
---

# SKILL: status-checker

An interactive skill that demonstrates how to perform system checks, format output, and provide actionable information.

## Triggers
- "check system status"
- "show system info"
- "verify setup"
- "system diagnostics"

## Behaviour

### Step 1: Environment Detection
Detects the current environment:
- Operating system (Windows, macOS, Linux)
- Shell type (bash, zsh, PowerShell)
- Working directory
- Git repository status (if applicable)

### Step 2: System Checks
Performs various checks:
- Git installation and version
- Node.js availability
- Python availability
- GitHub CLI (gh) availability

### Step 3: Report Generation
Generates a formatted status report:
```
🔍 SYSTEM STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Operating System: Windows 11
✅ Shell: PowerShell 7.3
✅ Git: v2.42.0
✅ Node.js: v20.10.0
⚠️  Python: Not found
✅ GitHub CLI: v2.40.0
✅ Working Dir: C:\Projects\my-app
✅ Git Repo: Yes (branch: main)

📊 Summary: 6/7 checks passed
```

### Step 4: Recommendations
Provides actionable recommendations:
- Missing tools to install
- Configuration suggestions
- Next steps

## Example Usage

**User**: "check system status"

**Skill**:
```
🔍 Running system diagnostics...

SYSTEM STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Operating System: Windows 11
✅ Shell: PowerShell 7.3.0
✅ Git: v2.42.0.windows.1
✅ Node.js: v20.10.0
⚠️  Python: Not found
✅ GitHub CLI: v2.40.0
✅ Working Directory: C:\Projects\claude-priority
✅ Git Repository: Yes (branch: main, clean)

📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
6 of 7 checks passed

💡 RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  Python not found
   → Install Python 3.8+ for full functionality
   → Download: https://www.python.org/downloads/

✅ System is ready for plugin development!
```

## Integration
- Uses Bash tool to run system commands
- Demonstrates formatted output
- Shows how to handle missing dependencies gracefully
- Example of multi-step skill workflow

## Dependencies
- Git (required for repository checks)
- Optional: Node.js, Python, GitHub CLI

## Version
v1.0.0 - Initial release with system diagnostics and formatted reporting
