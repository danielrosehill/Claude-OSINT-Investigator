# Graph Data

Machine-parseable relationship graph for programmatic analysis.

## Files

- `schema.json` - Entity and relationship type definitions (compatible with SpiderFoot)
- `entities.json` - All entities (nodes) in the investigation
- `relationships.json` - All relationships (edges) between entities

## Entity Format

```json
{
  "id": "entity-uuid-here",
  "type": "PERSON",
  "codename": "ALPHA",
  "properties": {
    "name": "John Doe",
    "aliases": ["JD", "johnd"],
    "occupation": "Software Engineer"
  },
  "sources": [
    {
      "type": "MANUAL",
      "reference": "evidence/raw/2024-01-15_linkedin_profile.pdf",
      "date": "2024-01-15"
    }
  ],
  "confidence": "HIGH",
  "created": "2024-01-15T10:30:00Z",
  "updated": "2024-01-16T14:22:00Z",
  "notes": "Primary subject of investigation",
  "spiderfootId": null
}
```

## Relationship Format

```json
{
  "id": "rel-uuid-here",
  "type": "WORKS_FOR",
  "source": "entity-uuid-1",
  "target": "entity-uuid-2",
  "direction": "directed",
  "properties": {
    "role": "Senior Developer",
    "since": "2020-03",
    "verified": true
  },
  "sources": [
    {
      "type": "SOCIAL_MEDIA",
      "reference": "evidence/raw/2024-01-15_linkedin_profile.pdf",
      "date": "2024-01-15"
    }
  ],
  "confidence": "CONFIRMED",
  "created": "2024-01-15T10:35:00Z",
  "notes": null,
  "spiderfootId": null
}
```

## SpiderFoot Compatibility

The schema maps SpiderFoot entity types to our types. When importing SpiderFoot data:

| SpiderFoot Type | Maps To |
|-----------------|---------|
| HUMAN_NAME | PERSON |
| COMPANY_NAME | ORGANIZATION |
| EMAILADDR | EMAIL |
| PHONE_NUMBER | PHONE |
| DOMAIN_NAME | DOMAIN |
| IP_ADDRESS | IP_ADDRESS |
| USERNAME | USERNAME |
| SOCIAL_MEDIA | USERNAME |
| BITCOIN_ADDRESS | CRYPTOCURRENCY |

## Querying with jq

```bash
# List all persons
jq '.entities[] | select(.type == "PERSON")' entities.json

# Find relationships for a specific entity
jq --arg id "entity-uuid" '.relationships[] | select(.source == $id or .target == $id)' relationships.json

# Get all high-confidence relationships
jq '.relationships[] | select(.confidence == "HIGH" or .confidence == "CONFIRMED")' relationships.json

# Count entities by type
jq '.entities | group_by(.type) | map({type: .[0].type, count: length})' entities.json

# Export edges for network visualization
jq '.relationships[] | {source: .source, target: .target, type: .type}' relationships.json
```

## Export Formats

The graph data can be converted to other formats:

- **Mermaid**: For markdown visualization (see `/network` command)
- **DOT/Graphviz**: `python scripts/export_graph.py --format dot`
- **GEXF**: For Gephi import `python scripts/export_graph.py --format gexf`
- **CSV**: For spreadsheet analysis `python scripts/export_graph.py --format csv`
- **Neo4j Cypher**: For graph database import

## For Claude

When working with graph data:

1. Always use `graph/entities.json` as the source of truth for entities
2. Update both the graph files AND the markdown profiles when adding entities
3. Generate UUIDs for new entities: `uuidgen` or Python `uuid.uuid4()`
4. Maintain bidirectional sync between profiles and graph data
5. Use the schema to validate entity and relationship types
