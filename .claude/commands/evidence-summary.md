# Evidence Summary

Generate a complete inventory of all collected evidence with metadata and verification status.

## Purpose

Create a comprehensive evidence index showing:
- What evidence has been collected
- Where it is stored
- Its provenance and chain of custody
- Verification status
- How it relates to investigation findings

## Instructions

### 1. Scan Evidence Directories

Review all evidence in:
- `evidence/raw/` - Original unprocessed files
- `evidence/processed/` - Cleaned/extracted data
- `evidence/screenshots/` - Visual captures
- `evidence/documents/` - PDFs, text files
- `evidence/media/` - Images, video, audio

### 2. Generate Evidence Index

Create `analysis/evidence-index-YYYY-MM-DD.md`:

```markdown
# Evidence Index

**Investigation:** [Name]
**Generated:** YYYY-MM-DD
**Total Items:** [Count]

---

## Summary by Type

| Type | Count | Verified | Unverified |
|------|-------|----------|------------|
| Screenshots | X | X | X |
| Documents | X | X | X |
| Media | X | X | X |
| Data Files | X | X | X |

---

## Summary by Entity

| Entity | Evidence Items | Key Items |
|--------|---------------|-----------|
| [Name] | X | [Most important] |

---

## Complete Evidence Catalog

### Screenshots

| ID | Filename | Source | Date Collected | Subject | Verified | Notes |
|----|----------|--------|----------------|---------|----------|-------|
| S001 | ... | ... | YYYY-MM-DD | ... | Yes/No | ... |

### Documents

| ID | Filename | Source | Date Collected | Subject | Verified | Notes |
|----|----------|--------|----------------|---------|----------|-------|
| D001 | ... | ... | YYYY-MM-DD | ... | Yes/No | ... |

### Media

| ID | Filename | Source | Date Collected | Subject | Verified | Notes |
|----|----------|--------|----------------|---------|----------|-------|
| M001 | ... | ... | YYYY-MM-DD | ... | Yes/No | ... |

### Raw Data

| ID | Filename | Source | Date Collected | Subject | Verified | Notes |
|----|----------|--------|----------------|---------|----------|-------|
| R001 | ... | ... | YYYY-MM-DD | ... | Yes/No | ... |

---

## Chain of Custody Log

| Evidence ID | Action | Date | Notes |
|-------------|--------|------|-------|
| S001 | Collected | YYYY-MM-DD | Original screenshot from [source] |
| S001 | Processed | YYYY-MM-DD | Cropped, annotated version created |

---

## Verification Status

### Verified
[List of verified evidence with verification method]

### Pending Verification
[List of evidence awaiting verification]

### Unable to Verify
[List with explanation why]

---

## Evidence Gaps

[What evidence is missing or would strengthen findings]

| Finding | Current Evidence | Missing Evidence |
|---------|-----------------|------------------|
| ... | ... | ... |

---

## Metadata Audit

| Evidence ID | Has .meta.md | Complete | Issues |
|-------------|--------------|----------|--------|
| ... | Yes/No | Yes/No | ... |
```

### 3. Check Metadata Files

For each evidence file, verify companion `.meta.md` exists with:
- Source URL/location
- Collection date/time
- Collection method
- Relevance to investigation
- Chain of custody notes

Flag any missing or incomplete metadata.

### 4. Output

Save to `analysis/evidence-index-YYYY-MM-DD.md`

Report to user:
- Total evidence count by type
- Verification status summary
- Missing metadata warnings
- Evidence gaps identified
- Recommendations for additional collection
