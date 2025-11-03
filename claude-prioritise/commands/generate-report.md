---
description: Generate weekly or sprint report from activity log
---

You are a project reporter. Generate comprehensive reports from the activity log.

## Report Generation Process

1. **Ask for report type**:
   - Weekly report (last 7 days)
   - Sprint report (last 2 weeks)
   - Custom date range
   - Full project summary

2. **Read activity log**:
   ```bash
   cat persistence/log.md
   ```

3. **Parse log entries**:
   - Extract session dates
   - Identify accomplishments
   - Count tasks completed
   - Note key milestones

4. **Generate structured report**:

   ## 📈 Project Report: [Time Period]

   **Period**: [Start Date] to [End Date]

   ### Summary
   - Sessions: X
   - Tasks Completed: Y
   - Files Created: Z
   - Major Milestones: N

   ### Key Accomplishments

   1. **[Feature/Area]**
      - Accomplishment 1
      - Accomplishment 2

   2. **[Feature/Area]**
      - Accomplishment 1
      - Accomplishment 2

   ### Metrics

   - **Productivity**: [Tasks per session]
   - **Focus Areas**: [Most worked on areas]
   - **Completion Rate**: [Percentage of planned work done]

   ### Highlights

   - 🎉 [Major achievement]
   - ✨ [Notable improvement]
   - 🔧 [Technical advancement]

   ### Next Period Goals

   Based on current backlog:
   1. [Priority 1]
   2. [Priority 2]
   3. [Priority 3]

   ### Issues & Blockers

   - [Any issues encountered]
   - [Blockers or dependencies]

5. **Export options**:
   "Would you like to:
   - Save report to file? (e.g., reports/report-2025-11-03.md)
   - Copy to clipboard?
   - Display only?"

## Report Templates

### Weekly Report Format
```markdown
# Weekly Report: Week of [Date]

## Summary
[3-5 sentence overview]

## Completed This Week
- [x] Task 1
- [x] Task 2

## In Progress
- [ ] Task 3
- [ ] Task 4

## Planned for Next Week
- [ ] Task 5
- [ ] Task 6

## Metrics
- Commits: X
- PRs: Y
- Issues Closed: Z
```

### Sprint Report Format
```markdown
# Sprint Report: Sprint [N]

## Sprint Goal
[What was the sprint goal?]

## Completed Stories
1. [Story 1] - [Points]
2. [Story 2] - [Points]

## Sprint Metrics
- Velocity: X points
- Completion: Y%
- Bugs Fixed: Z

## Retrospective
- What went well
- What to improve
- Action items
```

## Data Sources

Extract from log.md:
- Session dates and summaries
- Key Accomplishments sections
- Statistics sections
- Files Created/Modified lists

Supplement with:
- Git commit history
- GitHub issues (if MCP connected)
- Todo completion rates
