# Investigate Leads

Systematically explore and document investigative leads.

## Arguments

$ARGUMENTS - Optional: specific lead to investigate

## Instructions

### 1. Review Current Leads

Check `notes/leads.md` for existing leads tracking. If it doesn't exist, create it.

### 2. If No Specific Lead Provided

Present the user with:
- List of current uninvestigated leads
- Recommended priority based on:
  - Relevance to objectives (from brief)
  - Potential information value
  - Ease of investigation
  - Time sensitivity

Ask which lead to pursue.

### 3. Investigate the Lead

For each lead:

1. **Document Starting Point**
   - What is the lead?
   - Where did it come from?
   - What do we hope to learn?

2. **Execute Investigation**
   - Use appropriate OSINT tools and methods
   - Follow the trail systematically
   - Document each step taken

3. **Collect Evidence**
   - Save raw data to `evidence/raw/`
   - Take screenshots where appropriate
   - Create metadata files for provenance

4. **Assess Results**
   - Did this lead produce useful information?
   - What new leads emerged?
   - What entities were discovered?

### 4. Update Leads Tracker

Maintain `notes/leads.md`:

```markdown
# Investigation Leads

## Active Leads

### [Lead Description]
- **Source**: Where this lead came from
- **Priority**: High / Medium / Low
- **Status**: Not Started / In Progress / Complete / Dead End
- **Assigned**: [Date started]
- **Notes**: [Progress notes]

## Completed Leads

### [Lead Description]
- **Outcome**: What was found
- **New Leads Generated**: [List any]
- **Evidence Created**: [Links to evidence files]

## Dead Ends

### [Lead Description]
- **Reason**: Why this didn't pan out
- **Date Closed**: [Date]
```

### 5. Generate New Leads

After investigating, identify:
- New usernames or accounts to investigate
- New connections or relationships
- New platforms or sources to check
- Patterns suggesting other avenues

Add these to the leads tracker with appropriate priority.

### 6. Report to User

Summarize:
- What was investigated
- Key findings
- New leads generated
- Recommended next steps
