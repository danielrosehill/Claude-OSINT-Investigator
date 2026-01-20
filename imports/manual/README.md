# Manual Imports

Place existing case files here for migration into the framework.

## Supported Formats

- Markdown files (.md)
- Text files (.txt)
- Documents (.pdf, .docx)
- Images (.png, .jpg)
- Data files (.json, .csv)

## Migration Process

1. Place files/folders here
2. Run `/migrate imports/manual/<folder>`
3. Claude will analyze structure and extract:
   - Entities (people, organizations, etc.)
   - Relationships between entities
   - Timeline events
   - Evidence files
4. Review migration report in `notes/migration-report.md`
5. Verify extracted entities and relationships

## After Migration

- Original files are preserved (copied, not moved)
- Evidence goes to `evidence/raw/`
- Entities added to `graph/entities.json`
- Relationships added to `graph/relationships.json`
- Profiles created in `analysis/entity-profiles/`
