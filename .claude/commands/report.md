# Generate Investigation Report

Create a formal investigation report based on collected evidence and analysis.

## Instructions

### 1. Gather Context

Ask the user:
- What type of report? (Executive Summary / Full Technical / Legal-Ready)
- Who is the intended audience?
- Any specific sections to emphasize or exclude?
- Desired length/detail level?

### 2. Review All Materials

Read and synthesize:
- `brief/brief.md` - Investigation parameters
- `analysis/entity-profiles/` - All entity documentation
- `analysis/timeline/` - Chronological findings
- `analysis/network-maps/` - Relationship analysis
- `evidence/` - Supporting evidence inventory
- `sources/` - Source documentation

### 3. Generate Report

Create report in `reports/drafts/` using this structure:

```markdown
# [Investigation Title] - Final Report

**Prepared by**: [Investigator/Client info]
**Date**: [Report date]
**Classification**: [If applicable]
**Version**: Draft v1

---

## Executive Summary

[1-2 paragraphs summarizing key findings and conclusions]

---

## 1. Introduction

### 1.1 Background
[Context for the investigation]

### 1.2 Objectives
[List from brief]

### 1.3 Scope
[What was and wasn't investigated]

### 1.4 Methodology
[OSINT methods and tools used]

---

## 2. Subject Overview

[Summary of investigation subject(s)]

---

## 3. Findings

### 3.1 [Finding Category 1]
[Detailed findings with evidence citations]

---

## 4. Timeline of Events

[Consolidated timeline from analysis/timeline/]

---

## 5. Network Analysis

[Relationship mapping from analysis/network-maps/]

---

## 6. Assessment

### 6.1 Confidence Levels
[Overall confidence in findings]

### 6.2 Limitations
[What couldn't be determined]

### 6.3 Information Gaps
[Outstanding questions]

---

## 7. Conclusions

[Summary conclusions addressing each objective]

---

## 8. Recommendations

[If applicable - suggested next steps or actions]

---

## Appendices

### Appendix A: Evidence Index
[List of all evidence with locations]

### Appendix B: Source List
[All sources consulted]
```

### 4. Review with User

- Present draft to user
- Incorporate feedback
- Move final version to `reports/final/` only after approval
