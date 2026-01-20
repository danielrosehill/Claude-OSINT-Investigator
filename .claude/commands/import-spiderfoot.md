# Import SpiderFoot Investigation

Import data from a SpiderFoot scan into the investigation graph.

## Arguments

$ARGUMENTS - Path to SpiderFoot export file (JSON or CSV)

## Instructions

### 1. Locate Export File

If $ARGUMENTS provided, use that path. Otherwise, check:
- `imports/spiderfoot/` for existing exports
- Ask user to provide path or run SpiderFoot export

**SpiderFoot Export Commands:**
```bash
# From SpiderFoot CLI
sf -s <target> -o json > imports/spiderfoot/scan_results.json

# From Web UI
# Navigate to scan results → Export → JSON/CSV
```

### 2. Validate Export

Check the export file is valid:
```bash
# For JSON
jq '.' <file> | head -20

# For CSV
head -20 <file>
```

Verify it contains SpiderFoot data fields:
- `type` or `Type` - Entity type
- `data` or `Data` - Entity value
- `module` or `Module` - Collection module
- `source` or `Source` - Parent entity (for relationships)

### 3. Run Import Script

```bash
source .venv/bin/activate
python scripts/import_spiderfoot.py <export_file>
```

The script will:
- Map SpiderFoot types to our schema
- Create entity entries with UUIDs
- Establish relationships based on parent-child data
- Merge with existing graph data

### 4. Review Imported Entities

After import, review what was added:

```bash
# Count new entities by type
jq '.entities | group_by(.type) | map({type: .[0].type, count: length})' graph/entities.json

# List entities with SpiderFoot origin
jq '.entities[] | select(.notes | contains("SpiderFoot")) | {type, label: .properties.name // .properties.address // .properties.username}' graph/entities.json
```

### 5. Prioritize Entities

SpiderFoot often discovers many entities. Prioritize for profiling:

**High Priority** (create profiles):
- PERSON entities
- ORGANIZATION entities
- Entities with many connections
- Entities matching investigation brief criteria

**Medium Priority** (review but may not profile):
- EMAIL addresses
- USERNAME/SOCIAL_MEDIA
- Domains directly related to targets

**Low Priority** (keep in graph but don't profile):
- IP addresses (unless specifically relevant)
- Generic infrastructure
- Third-party services

### 6. Create Profiles for Key Entities

For high-priority entities, create profiles in `analysis/entity-profiles/`:

```bash
# Get list of persons found
jq '.entities[] | select(.type == "PERSON") | .properties.name' graph/entities.json
```

For each key entity:
1. Check if profile already exists
2. If not, use `/profile` command to create
3. Link profile to SpiderFoot evidence

### 7. Assign Code Names

For sensitive entities that need anonymization:

1. Check `context/codenames.md` for existing assignments
2. Assign new code names for persons/organizations
3. Update entity records with codename field

### 8. Generate Network Visualization

Create visual representation of SpiderFoot discoveries:

```bash
# Generate Mermaid diagram
python scripts/export_graph.py --format mermaid > analysis/network-maps/spiderfoot-network.md

# Generate GEXF for Gephi analysis
python scripts/export_graph.py --format gexf -o analysis/network-maps/spiderfoot-network.gexf
```

### 9. Identify Investigation Targets

Cross-reference SpiderFoot findings with investigation brief:

1. Read `brief/brief.md` for investigation objectives
2. Identify which SpiderFoot entities are relevant
3. Flag entities that match target criteria
4. Note entities that are new leads

### 10. Document Import

Create import record in `notes/spiderfoot-imports.md`:

```markdown
# SpiderFoot Import Log

## Import: <date>

**Source File**: <filename>
**Scan Target**: <target>
**Scan Date**: <date if known>

### Statistics

- Entities Imported: X
- Relationships Created: X
- Entity Types: PERSON (X), EMAIL (X), DOMAIN (X), ...

### Key Findings

- <Notable entities discovered>
- <Unexpected connections>
- <Entities matching investigation criteria>

### Follow-up Actions

- [ ] Profile entity: <name>
- [ ] Investigate connection: <entity1> → <entity2>
- [ ] Verify: <unconfirmed finding>
```

### 11. SpiderFoot Type Reference

| SpiderFoot Type | Our Type | Notes |
|-----------------|----------|-------|
| HUMAN_NAME | PERSON | Names found in documents/pages |
| COMPANY_NAME | ORGANIZATION | Business names |
| EMAILADDR | EMAIL | Email addresses |
| PHONE_NUMBER | PHONE | Phone numbers |
| DOMAIN_NAME | DOMAIN | Registered domains |
| IP_ADDRESS | IP_ADDRESS | IPv4 addresses |
| IPV6_ADDRESS | IP_ADDRESS | IPv6 addresses |
| USERNAME | USERNAME | Account usernames |
| SOCIAL_MEDIA | USERNAME | Social media profiles |
| BITCOIN_ADDRESS | CRYPTOCURRENCY | Crypto wallet addresses |
| GEOINFO | LOCATION | Geographic data |
| PASSWORD_COMPROMISED | CREDENTIAL | Leaked credentials |

### 12. Suggest Follow-up Scans

Based on imported data, suggest additional SpiderFoot modules:

**If emails found:**
```bash
sf -m sfp_haveibeenpwned,sfp_emailrep -t <email>
```

**If domains found:**
```bash
sf -m sfp_dnsresolve,sfp_whois,sfp_certspotter -t <domain>
```

**If usernames found:**
```bash
sf -m sfp_accounts -t <username>
```
