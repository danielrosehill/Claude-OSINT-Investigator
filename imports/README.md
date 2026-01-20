# Imports

External data to be imported into the investigation.

## Subdirectories

### spiderfoot/
SpiderFoot scan exports in JSON or CSV format.

**To import:**
```bash
python scripts/import_spiderfoot.py spiderfoot/scan_results.json
```

Or use: `/import-spiderfoot spiderfoot/scan_results.json`

### manual/
Other investigation materials to migrate into this framework.

**To import:**
Use `/migrate manual/<folder>` to process and import existing case files.

## After Import

Imported data flows into:
- `graph/entities.json` - Entity records
- `graph/relationships.json` - Relationship records
- `analysis/entity-profiles/` - Generated profiles for key entities
- `evidence/raw/` - Original files (if applicable)
