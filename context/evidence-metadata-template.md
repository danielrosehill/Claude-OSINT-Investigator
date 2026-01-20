# Evidence Metadata Template

Use this template when creating `.meta.md` companion files for evidence.

---

## Template

Save as `[evidence-filename].meta.md` alongside the evidence file.

```markdown
# Evidence Metadata

**File:** [filename.ext]
**Evidence ID:** [E001, S001, D001, M001, etc.]
**Type:** Screenshot / Document / Media / Data

---

## Collection Information

**Source:** [URL, platform, or origin]
**Source Type:** Website / Social Media / Public Record / Database / Other
**Date Collected:** YYYY-MM-DD HH:MM
**Collection Method:** [Browser screenshot / API / Download / Archive.org / etc.]
**Collected By:** [Investigator identifier]

---

## Content Summary

**Subject:** [Brief description of what this evidence shows]
**Entities Mentioned:** [List names, usernames, organizations]
**Date Range of Content:** [If content has dates, e.g., "Posts from 2019-2022"]
**Key Information:** [Most important facts this evidence establishes]

---

## Relevance

**Investigation Objective:** [Which objective this supports]
**Findings Supported:** [What claims this evidence supports]
**Confidence Contribution:** [How this affects confidence in findings]

---

## Verification

**Verification Status:** Verified / Unverified / Unable to Verify
**Verification Method:** [How verified, if applicable]
**Verification Date:** [If verified]
**Cross-References:** [Other evidence that corroborates this]

---

## Integrity

**Original Hash (SHA-256):** [Hash of original file]
**File Size:** [In bytes]
**Modifications:** None / [List any processing done]

---

## Chain of Custody

| Date | Action | Actor | Notes |
|------|--------|-------|-------|
| YYYY-MM-DD | Collected | [Name] | Original capture from [source] |
| YYYY-MM-DD | Stored | [Name] | Saved to evidence/raw/ |
| YYYY-MM-DD | Processed | [Name] | [Description of processing] |
| YYYY-MM-DD | Verified | [Name] | [Verification notes] |

---

## Notes

[Any additional observations, caveats, or context]

---

## Related Evidence

- [Link to related evidence file 1]
- [Link to related evidence file 2]
```

---

## Quick Reference

### Evidence ID Prefixes

| Prefix | Type |
|--------|------|
| S### | Screenshot |
| D### | Document |
| M### | Media (image/video/audio) |
| R### | Raw data file |
| E### | General evidence |

### Verification Status

| Status | Meaning |
|--------|---------|
| Verified | Independently confirmed authentic |
| Unverified | Not yet checked, assumed authentic |
| Unable to Verify | Cannot confirm, note limitations |

### Generating SHA-256 Hash

```bash
sha256sum filename.ext
```

---

## Minimum Required Fields

At minimum, every metadata file must include:

1. **File** - Which file this describes
2. **Source** - Where it came from
3. **Date Collected** - When collected
4. **Content Summary** - What it shows
5. **Entities Mentioned** - Who/what is referenced
6. **Verification Status** - Current verification state
