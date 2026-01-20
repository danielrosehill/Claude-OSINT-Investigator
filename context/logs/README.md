# Investigation Logs

Daily session logs capturing observations, findings, and progress during investigation work.

## Structure

Each day's work is logged in `log-YYYY-MM-DD.md` files.

## Log Format

```markdown
# Investigation Log - YYYY-MM-DD

**Investigation:** [Case name]

---

## HH:MM - [CATEGORY]

[Content]

**Source:** [If applicable]
**Entities:** [Names mentioned]
**Follow-up:** [Actions needed]
```

## Categories

| Category | Use For |
|----------|---------|
| FINDING | New information discovered |
| OBSERVATION | Something potentially relevant |
| HYPOTHESIS | Working theory to test |
| CORRELATION | Connection identified |
| QUESTION | Open question to investigate |
| TECHNICAL | Tool/process notes |

## For Claude

Use `/log` command to quickly add entries. Logs help:
- Track investigation progress
- Capture fleeting observations
- Build audit trail of work
- Feed into `/status` reports
- Identify patterns across sessions

Review recent logs before starting new sessions to maintain continuity.
