# Example: Skill with Missing/Incorrect Frontmatter

## BEFORE Formatting

### File: skills/tide-calculator/skill.md

```markdown
# SKILL: Tide Calculator

Calculate tide heights and times for any location.

## Triggers
- "calculate tide"
- "what's the tide?"
- "tide height at..."

## Behaviour
This skill uses tidal data to calculate heights...
```

**Problems:**
1. ❌ Missing frontmatter entirely
2. ❌ No `name` field (required)
3. ❌ No `description` field (required)
4. ❌ No `license` field (required)
5. ❌ Title uses "Tide Calculator" but directory is "tide-calculator"

---

### File: skills/chart-symbols/skill.md

```markdown
---
name: Chart-Symbols
description: Learn chart symbols
---

# SKILL: Chart Symbols

Identify and interpret chart symbols.
```

**Problems:**
1. ❌ Frontmatter `name` is "Chart-Symbols" but directory is "chart-symbols"
2. ❌ Title "Chart Symbols" doesn't match directory name
3. ⚠️ Description is very brief (but meets 10-char minimum)

---

### File: skills/weather-analysis/skill.md

```markdown
---
name: weather-analysis
description: Analyze weather patterns and forecast conditions for sailing safety and planning
license: Apache-2.0
---

SKILL: Weather Analysis

Analyze weather patterns for sailing.
```

**Problems:**
1. ❌ Title missing `#` markdown heading
2. ⚠️ Description exceeds recommended length (but valid)
