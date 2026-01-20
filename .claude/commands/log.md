# Quick Log Entry

Capture observations, findings, or notes quickly during investigation work.

## Instructions

Create or append to today's investigation log at `context/logs/log-YYYY-MM-DD.md`.

### Log Entry Format

```markdown
## HH:MM - [Category]

[Content]

**Source:** [If applicable]
**Entities:** [Names/identifiers mentioned]
**Follow-up:** [If action needed]
```

### Categories

- **FINDING** - New information discovered
- **OBSERVATION** - Something that may be relevant
- **HYPOTHESIS** - Working theory to investigate
- **CORRELATION** - Connection identified between entities/events
- **QUESTION** - Open question requiring investigation
- **TECHNICAL** - Tool usage, data processing notes

### Workflow

1. Check if `context/logs/log-YYYY-MM-DD.md` exists
2. If not, create with header:
   ```markdown
   # Investigation Log - YYYY-MM-DD

   **Investigation:** [Name from brief/brief.md]

   ---
   ```
3. Append the new entry with timestamp
4. If entry suggests a lead, note for `/leads`
5. If entry identifies correlation, consider `/network` update

### Arguments

**$ARGUMENTS** - Content to log. If empty, ask what to log.

### Example

`/log Found company registration showing John Smith as director since 2019`

Creates:
```markdown
## 14:32 - FINDING

Found company registration showing John Smith as director since 2019

**Source:** Companies House
**Entities:** John Smith, [Company Name]
**Follow-up:** Collect registration document, cross-reference with LinkedIn dates
```

### Integration

- Feeds into `/status` reports
- Significant findings become `/leads`
- Entity mentions inform `/profile` work
- Correlations update `/network`
- Timeline-relevant entries go to `/timeline`
