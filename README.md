# Claude OSINT Investigator

A Claude Code template for conducting open-source intelligence (OSINT) investigations with structured workflows and evidence management.

## What This Is

This template transforms Claude Code into an OSINT investigation assistant. It provides:

- **Structured investigation workflow** - From brief to final report
- **Evidence management** - Organized storage with chain of custody documentation
- **Analysis frameworks** - Entity profiles, timelines, and network mapping
- **Machine-parseable graph data** - Maltego-style relationship graphs in JSON
- **SpiderFoot integration** - Import automated OSINT scans for Claude analysis
- **Slash commands** - Purpose-built commands for common OSINT tasks
- **MCP integration** - Recommendations for OSINT-focused MCP servers

## Getting Started

1. **Clone or use as template** for your investigation
2. Run `./setup.sh` to initialize the environment (creates Python venv, graph data, optional SpiderFoot)
3. Run `/onboarding` to establish your investigation brief
4. Run `/recommend-tools` to get MCP server suggestions for your investigation type
5. Begin investigating using the available commands

**Importing Existing Work:**
- `/migrate <path>` - Import existing case files into this framework
- `/import-spiderfoot <file>` - Import SpiderFoot scan results

## Available Commands

| Command | Purpose |
|---------|---------|
| `/onboarding` | Initialize investigation, gather brief, define scope |
| `/status` | Generate progress report on investigation |
| `/report` | Create formal investigation report |
| `/dossier` | Generate comprehensive case dossier with all findings |
| `/profile [entity]` | Build detailed profile of person/org/account |
| `/leads` | Track and investigate leads systematically |
| `/timeline` | Build chronological timeline of events |
| `/network` | Map relationships and connections |
| `/collect [source]` | Collect and document evidence from a source |
| `/evidence-summary` | Generate complete evidence inventory with verification status |
| `/log [note]` | Quick capture of findings, observations, and correlations |
| `/recommend-tools` | Suggest OSINT MCP servers for this investigation |
| `/migrate [path]` | Import existing case files into this framework |
| `/import-spiderfoot [file]` | Import SpiderFoot scan results into graph |

## Directory Structure

```
├── brief/              # Investigation brief and scope
├── evidence/           # Collected evidence (raw, processed, screenshots, etc.)
├── analysis/           # Analytical products (timelines, network maps, profiles)
│   └── parties/       # Working files for entities under investigation
├── graph/              # Machine-parseable relationship data
│   ├── schema.json    # Entity/relationship type definitions
│   ├── entities.json  # All entities (nodes)
│   └── relationships.json # All relationships (edges)
├── reports/            # Formal deliverables (drafts and final)
├── sources/            # Source documentation and archives
├── imports/            # External data to import
│   ├── spiderfoot/    # SpiderFoot scan exports
│   └── manual/        # Existing case files to migrate
├── scripts/            # Helper scripts (graph export, SpiderFoot import)
├── notes/              # Working notes and hypotheses
├── working/            # Temporary workspace
└── context/            # Reference data and session logs
```

Each folder contains a README explaining its purpose and how Claude should use it.

## Key Features

### Information Synthesis
The template excels at correlating information across sources:
- **Correlation analysis** - Cross-reference entities, detect patterns, surface connections
- **Dramatis Personae** - Track all entities with roles and relationships
- **Evidence chain** - Rigorous chain of custody with SHA-256 verification

### Specialized Agents
Built-in agents for autonomous investigation tasks:
- `evidence-processor` - Catalog and process evidence
- `entity-profiler` - Build comprehensive profiles
- `correlation-analyst` - Identify patterns and connections
- `timeline-builder` - Chronological reconstruction
- `network-mapper` - Relationship mapping
- `graph-manager` - Maintain machine-parseable graph data
- `spiderfoot-integrator` - Bridge automated OSINT and analysis
- `gap-analyst` - Identify what's missing

See `.claude/agents.md` for full details.

### Graph Data (Maltego-style)
Machine-parseable relationship data for programmatic analysis:

- **Entities** - People, organizations, emails, domains, IPs, usernames, etc.
- **Relationships** - Typed connections with properties and confidence levels
- **Export formats** - Mermaid, GEXF (Gephi), DOT (Graphviz), CSV, Neo4j Cypher

Query with `jq`:
```bash
jq '.entities[] | select(.type == "PERSON")' graph/entities.json
jq '.relationships[] | select(.type == "WORKS_FOR")' graph/relationships.json
```

Export:
```bash
python scripts/export_graph.py --format mermaid
python scripts/export_graph.py --format gexf -o network.gexf
```

### SpiderFoot Integration
Use SpiderFoot for automated OSINT collection, Claude for analysis:

```bash
# Run SpiderFoot scan
sf -s target.com -o json > imports/spiderfoot/scan.json

# Import into investigation
/import-spiderfoot imports/spiderfoot/scan.json
```

SpiderFoot entity types are automatically mapped to the graph schema.

## Recommended Tools

### SpiderFoot
Automated OSINT collection from 200+ data sources. Installed optionally via `setup.sh`.

```bash
sf -l                    # Start web UI
sf -s target -o json     # Run scan, output JSON for import
```

### MCP Servers
Enhance investigations with OSINT-focused MCPs:

- **[Maigret](https://github.com/BurtTheCoder/mcp-maigret)** - Username enumeration across platforms
- **[Shodan](https://github.com/BurtTheCoder/mcp-shodan)** - Network and device intelligence
- **[DNSTwist](https://github.com/BurtTheCoder/mcp-dnstwist)** - Domain typosquatting detection
- **[VirusTotal](https://github.com/BurtTheCoder/mcp-virustotal)** - File and URL analysis

See [awesome-osint-mcp-servers](https://github.com/soxoj/awesome-osint-mcp-servers) for more.

## Ethical Use

This template is designed for legitimate OSINT investigations using publicly available information. It does not facilitate:

- Unauthorized access or hacking
- Harassment or stalking
- Privacy violations
- Any illegal activity

Users are responsible for ensuring their investigations comply with applicable laws and ethical standards.

## License

MIT
