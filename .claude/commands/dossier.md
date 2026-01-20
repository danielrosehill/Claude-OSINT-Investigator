# Investigation Dossier

Generate a comprehensive case dossier synthesizing all investigation materials.

## Purpose

A dossier compiles and correlates all investigation findings into a single document showing:
- Who is involved and how they connect
- What happened and when
- What evidence supports each finding
- What questions remain open

## Instructions

### 1. Gather Materials

Review and synthesize:
- `brief/brief.md` - Investigation parameters
- `analysis/entity-profiles/` - All entity profiles
- `analysis/timeline/` - Chronological reconstruction
- `analysis/network-maps/` - Relationship mapping
- `context/logs/` - Investigation session logs
- `sources/sources-index.md` - All sources used
- `evidence/` - All collected evidence

### 2. Dossier Structure

Create `reports/drafts/dossier-YYYY-MM-DD.md`:

```markdown
# Investigation Dossier

**Case:** [Investigation name]
**Prepared:** YYYY-MM-DD
**Status:** [Active/Complete/Suspended]

---

## Executive Summary

[2-3 paragraphs: what was investigated, key findings, conclusions]

---

## Entities

[All entities by code name - see context/codenames.md for identity mapping]

| Code Name | Type | Role | Key Facts | Connections |
|-----------|------|------|-----------|-------------|
| [CODENAME] | Person/Org/Account | Subject/Associate | Brief summary | Links to others |

---

## Key Findings

### 1. [Finding Title]
**Confidence:** High/Medium/Low
**Evidence:** [File references]

[Detailed explanation with citations]

### 2. [Finding Title]
...

---

## Correlations Discovered

[Connections and patterns identified across entities/events]

| Connection | Entity A | Entity B | Evidence | Significance |
|------------|----------|----------|----------|--------------|
| [Type] | ... | ... | [File] | [Why it matters] |

---

## Timeline Summary

| Date | Event | Entities | Source | Confidence |
|------|-------|----------|--------|------------|
| ... | ... | ... | ... | H/M/L |

[Reference full timeline in analysis/timeline/]

---

## Network Summary

[Key relationships and network structure]

[Reference full network map in analysis/network-maps/]

---

## Evidence Index

| ID | Description | Location | Type | Verified |
|----|-------------|----------|------|----------|
| E001 | ... | evidence/raw/... | Doc/Screenshot/Media | Yes/No |

---

## Source Assessment

| Source | Reliability | Notes |
|--------|-------------|-------|
| ... | High/Medium/Low | ... |

---

## Open Questions

- [ ] Question 1
- [ ] Question 2

---

## Methodology

[Brief description of techniques and tools used]

---

## Appendices

- A: Full Entity Profiles [links]
- B: Complete Timeline [link]
- C: Network Diagram [link]
- D: Evidence Metadata [links]
```

### 3. Synthesis Focus

The dossier should demonstrate:
- **Correlation**: How separate pieces of information connect
- **Patterns**: Recurring behaviors, relationships, or events
- **Gaps**: What information is missing
- **Confidence**: How certain each finding is

### 4. Quality Checks

- [ ] All claims cite evidence
- [ ] Confidence levels stated
- [ ] No speculation as fact
- [ ] Entity names consistent
- [ ] Cross-references work
- [ ] Open questions captured

### 5. Output

Save to `reports/drafts/dossier-YYYY-MM-DD.md`

Report to user:
- Dossier location
- Entities covered
- Evidence items indexed
- Correlations identified
- Gaps requiring attention
