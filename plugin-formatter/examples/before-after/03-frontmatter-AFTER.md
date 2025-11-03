# Example: Skill with Missing/Incorrect Frontmatter

## AFTER Formatting

### File: skills/tide-calculator/skill.md

```markdown
---
name: tide-calculator
description: Calculate tide heights and times for any location
license: MIT
---

# SKILL: tide-calculator

Calculate tide heights and times for any location.

## Triggers
- "calculate tide"
- "what's the tide?"
- "tide height at..."

## Behaviour
This skill uses tidal data to calculate heights...
```

**Fixes Applied:**
1. ✅ Added missing frontmatter block
2. ✅ Added `name` field matching directory: "tide-calculator"
3. ✅ Added `description` extracted from content
4. ✅ Added `license: MIT` (default)
5. ✅ Updated title to match directory name

---

### File: skills/chart-symbols/skill.md

```markdown
---
name: chart-symbols
description: Learn chart symbols and interpret maritime notation
license: MIT
---

# SKILL: chart-symbols

Identify and interpret chart symbols.
```

**Fixes Applied:**
1. ✅ Updated frontmatter `name`: "Chart-Symbols" → "chart-symbols"
2. ✅ Updated title: "Chart Symbols" → "chart-symbols"
3. ✅ Enhanced description to be more descriptive
4. ✅ Added missing `license` field

---

### File: skills/weather-analysis/skill.md

```markdown
---
name: weather-analysis
description: Analyze weather patterns and forecast sailing conditions
license: Apache-2.0
---

# SKILL: weather-analysis

Analyze weather patterns for sailing.
```

**Fixes Applied:**
1. ✅ Added `#` to title heading
2. ✅ Trimmed description to recommended length (kept meaning intact)
3. ℹ️ Preserved Apache-2.0 license (user's choice)

---

## Summary

**Frontmatter Issues Fixed:**
- Added 1 missing frontmatter block
- Corrected 2 name fields to match directories
- Enhanced 2 descriptions
- Added 2 missing license fields
- Fixed 2 title headings

**Validation Result:** ✅ All skill.md files now comply with frontmatter requirements
