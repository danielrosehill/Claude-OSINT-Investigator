# Migrate Existing Case Files

Import an existing investigation folder/files into this OSINT framework.

## Arguments

$ARGUMENTS - Path to existing case folder or files to import

## Instructions

### 1. Analyze Source Structure

If $ARGUMENTS is provided, scan that path. Otherwise, ask the user for the source location.

Examine the source to understand:
- Directory structure
- File types present (markdown, txt, documents, images)
- Naming conventions used
- Existing organization scheme

```bash
# List structure
find <path> -type f | head -50

# Identify file types
find <path> -type f | sed 's/.*\.//' | sort | uniq -c | sort -rn
```

### 2. Identify Content Types

Categorize discovered files:

| Source Content | Target Location |
|----------------|-----------------|
| Investigation notes/brief | `brief/` |
| Person/entity profiles | `analysis/entity-profiles/` |
| Screenshots/images | `evidence/screenshots/` |
| Documents/PDFs | `evidence/documents/` |
| Raw data files | `evidence/raw/` |
| Timeline documents | `analysis/timeline/` |
| Relationship/network notes | `analysis/network-maps/` |
| Source links/references | `sources/` |
| Reports/summaries | `reports/` |
| Working notes | `notes/` |

### 3. Extract Entities

Scan all text files for entities to add to the graph:

**Look for:**
- Names (people, organizations)
- Email addresses
- Usernames/handles
- Phone numbers
- Domains/URLs
- Physical addresses
- Identifying numbers

For each entity found:
1. Determine entity type (PERSON, ORGANIZATION, EMAIL, etc.)
2. Check if already in `graph/entities.json`
3. If new, create entity entry with:
   - Generated UUID
   - Appropriate type
   - Properties extracted from context
   - Source reference to the original file
   - Confidence level based on context

### 4. Extract Relationships

Analyze content for relationships between entities:

**Patterns to look for:**
- "[Person] works for [Organization]"
- "[Person] is connected to [Person]"
- "[Email] belongs to [Person]"
- "[Domain] owned by [Organization]"
- Co-occurrence in same document/context
- Explicit relationship statements

For each relationship:
1. Identify source and target entities
2. Determine relationship type
3. Add to `graph/relationships.json`

### 5. Copy and Organize Files

For each file being migrated:

```bash
# Copy to appropriate location with standardized naming
cp "<source>" "evidence/raw/YYYY-MM-DD_<descriptive_name>.<ext>"
```

Create metadata files for evidence:
```markdown
# Evidence Metadata: <filename>

**Original Path**: <source path>
**Import Date**: <today>
**Original Modified**: <file mtime>
**File Hash**: <sha256>

## Content Summary
<Brief description of what this file contains>

## Entities Mentioned
- <List of entities extracted>

## Notes
<Any context from the migration>
```

### 6. Create Entity Profiles

For each significant entity discovered, create profile in `analysis/entity-profiles/`:

Use the entity profile template from `/profile` command, populated with:
- Information gathered from source files
- Cross-references to evidence files
- Connections to other entities

### 7. Build Initial Network

Update `analysis/network-maps/` with relationship visualization:
- Generate Mermaid diagram from `graph/relationships.json`
- Create connection matrix table

Run export script:
```bash
python scripts/export_graph.py --format mermaid > analysis/network-maps/imported-network.md
```

### 8. Generate Migration Report

Create `notes/migration-report.md`:

```markdown
# Migration Report

**Source**: <original path>
**Date**: <today>
**Migrated By**: Claude OSINT Agent

## Summary

- **Files Processed**: X
- **Files Copied**: X
- **Entities Extracted**: X
- **Relationships Identified**: X

## Files Migrated

| Original | Destination | Type |
|----------|-------------|------|
| ... | ... | ... |

## Entities Added

| ID | Type | Label | Source |
|----|------|-------|--------|
| ... | ... | ... | ... |

## Relationships Added

| Source | Type | Target | Evidence |
|--------|------|--------|----------|
| ... | ... | ... | ... |

## Issues/Warnings

- <Any files that couldn't be processed>
- <Ambiguous entities requiring review>
- <Missing information>

## Recommended Next Steps

1. Review extracted entities for accuracy
2. Assign code names to sensitive entities
3. Run /status to identify gaps
4. Consider running SpiderFoot for additional data collection
```

### 9. Verify Import

After migration:
1. Check `graph/entities.json` has new entries
2. Verify files copied to correct locations
3. Confirm entity profiles created
4. Test graph export works

```bash
# Verify graph has data
jq '.entities | length' graph/entities.json
jq '.relationships | length' graph/relationships.json

# Test export
python scripts/export_graph.py --format mermaid
```

### 10. User Review

Present migration summary to user and ask:
- Are entity extractions correct?
- Should any entities be merged (duplicates)?
- Are relationships accurately captured?
- Any files that should be excluded?

Make corrections based on feedback.
