# Investigation Status Report

Generate a comprehensive status update on the current investigation.

## Instructions

1. **Read the Brief**
   - Review `brief/brief.md` to understand objectives

2. **Assess Evidence Collection**
   - List evidence collected in `evidence/` subdirectories
   - Note gaps in evidence
   - Identify pending collection tasks

3. **Review Analysis Progress**
   - Check `analysis/timeline/` for chronological work
   - Check `analysis/network-maps/` for relationship mapping
   - Check `analysis/entity-profiles/` for entity documentation

4. **Evaluate Progress Against Objectives**
   - For each objective in the brief:
     - Current status (not started / in progress / complete)
     - Key findings so far
     - Blockers or challenges
     - Next steps needed

5. **Generate Status Report**

   ```markdown
   # Investigation Status Report
   **Date**: [current date]
   **Investigation**: [title from brief]

   ## Executive Summary
   [2-3 sentence overview of current state]

   ## Objectives Progress
   | # | Objective | Status | Confidence |
   |---|-----------|--------|------------|

   ## Key Findings to Date
   - [bullet points of significant findings]

   ## Evidence Inventory
   - Raw evidence items: [count]
   - Processed items: [count]
   - Entity profiles: [count]

   ## Current Blockers
   - [any issues impeding progress]

   ## Recommended Next Steps
   1. [prioritized action items]

   ## Questions for User
   - [any decisions or input needed]
   ```

6. **Save Report**
   - Save to `notes/YYYY-MM-DD_status-report.md`
