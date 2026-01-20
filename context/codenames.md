# Entity Code Names

This file maps code names to real entity identifiers for the investigation.

## Purpose

Code names provide:
- **Privacy** - Discuss findings without exposing real names
- **Consistency** - Single reference across all documents
- **Sharing** - Share analysis without revealing subjects
- **Clarity** - Distinguish between entities with similar names

## Code Name Registry

| Code Name | Type | Real Identity | Notes |
|-----------|------|---------------|-------|
| | | | |

## Naming Conventions

Choose a consistent scheme:
- **Phonetic alphabet** - ALPHA, BRAVO, CHARLIE...
- **Colors** - RED, BLUE, GREEN...
- **Cities** - PARIS, TOKYO, CAIRO...
- **Animals** - FALCON, WOLF, RAVEN...
- **Custom theme** - Related to investigation context

## Usage Rules

1. **All documents** should use code names, not real identities
2. **This file** is the only place real names appear
3. **Profiles** are filed by code name: `analysis/entity-profiles/CODENAME.md`
4. **Evidence metadata** references code names in "Entities Mentioned"
5. **Reports** can be de-anonymized by substitution when needed

## For Claude

- When user introduces a new entity, ask if they want to assign a code name
- Use code names consistently in all analysis and logs
- Reference this file to resolve code names when needed
- When generating reports, ask if output should use code names or real identities
