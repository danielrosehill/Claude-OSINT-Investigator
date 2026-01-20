# Investigation Agents

Specialized agents for autonomous investigation tasks. These agents can be invoked for focused work on specific aspects of the investigation.

## Available Agents

### evidence-processor

**Purpose:** Catalog and process collected evidence systematically.

**Capabilities:**
- Scan evidence directories for new files
- Generate metadata files for evidence lacking documentation
- Extract text from images/documents where possible
- Identify entities mentioned in evidence
- Flag duplicate or related evidence
- Verify file integrity (checksums)

**Invocation:** When new evidence is collected and needs processing.

**Output:** Updated evidence metadata, entity extraction notes, processing log.

---

### entity-profiler

**Purpose:** Build comprehensive profiles for persons, organizations, or accounts.

**Capabilities:**
- Aggregate information from multiple sources about an entity
- Cross-reference public records, social media, corporate registries
- Identify inconsistencies in entity's public information
- Map known associates and affiliations
- Track entity's digital footprint across platforms
- Generate structured profile documents

**Invocation:** When investigating a specific entity in depth.

**Output:** Entity profile document in `analysis/entity-profiles/`.

---

### correlation-analyst

**Purpose:** Identify connections and patterns across investigation data.

**Capabilities:**
- Cross-reference entities across evidence and sources
- Identify temporal patterns (events clustering around dates)
- Detect relationship patterns (shared addresses, companies, associates)
- Find contradictions between sources
- Surface non-obvious connections
- Generate correlation reports

**Invocation:** After accumulating evidence, to synthesize findings.

**Output:** Correlation analysis notes, network map updates, timeline additions.

---

### timeline-builder

**Purpose:** Construct and maintain chronological event reconstruction.

**Capabilities:**
- Extract dated events from evidence and sources
- Reconcile conflicting dates across sources
- Identify gaps in timeline
- Detect temporal anomalies (impossible sequences)
- Generate timeline visualizations
- Track timeline confidence levels

**Invocation:** When building or updating investigation timeline.

**Output:** Timeline document in `analysis/timeline/`.

---

### network-mapper

**Purpose:** Map relationships and connections between entities.

**Capabilities:**
- Identify relationship types (professional, personal, financial, etc.)
- Determine relationship strength based on evidence
- Detect network structures (hubs, clusters, bridges)
- Identify isolated entities requiring more investigation
- Generate network diagrams (Mermaid)
- Track relationship changes over time

**Invocation:** When mapping connections between entities.

**Output:** Network map in `analysis/network-maps/`.

---

### source-validator

**Purpose:** Assess reliability and authenticity of sources.

**Capabilities:**
- Evaluate source credibility indicators
- Check for signs of manipulation or fabrication
- Cross-reference claims against independent sources
- Assess information recency and relevance
- Document source limitations
- Rate source reliability

**Invocation:** When new sources are added or verification needed.

**Output:** Source assessment notes, updates to `sources/sources-index.md`.

---

### report-generator

**Purpose:** Compile investigation materials into formatted reports.

**Capabilities:**
- Synthesize findings from all analysis products
- Structure reports for specific audiences
- Ensure proper evidence citations
- Include confidence assessments
- Generate executive summaries
- Format for readability

**Invocation:** When producing deliverables or status reports.

**Output:** Report documents in `reports/drafts/`.

---

### gap-analyst

**Purpose:** Identify what's missing from the investigation.

**Capabilities:**
- Compare investigation objectives against current findings
- Identify entities mentioned but not profiled
- Find timeline gaps requiring investigation
- Detect unverified claims needing corroboration
- Suggest additional OSINT techniques to try
- Prioritize gaps by importance

**Invocation:** Periodically during investigation to guide next steps.

**Output:** Gap analysis notes, suggested leads, updated todo items.

---

### graph-manager

**Purpose:** Maintain the machine-parseable investigation graph.

**Capabilities:**
- Add/update/remove entities in `graph/entities.json`
- Manage relationships in `graph/relationships.json`
- Ensure graph-profile synchronization
- Validate entity and relationship types against schema
- Generate UUIDs for new graph entries
- Merge duplicate entities
- Export graph to various formats (Mermaid, GEXF, DOT, CSV, Cypher)
- Query graph for patterns and paths

**Invocation:** When graph data needs updates or queries.

**Output:** Updated graph JSON files, export files, query results.

**Graph Operations:**
```bash
# Add entity
jq '.entities += [<new_entity>]' graph/entities.json > tmp && mv tmp graph/entities.json

# Export formats
python scripts/export_graph.py --format mermaid
python scripts/export_graph.py --format gexf -o network.gexf
```

---

### spiderfoot-integrator

**Purpose:** Bridge between SpiderFoot automated collection and Claude analysis.

**Capabilities:**
- Import SpiderFoot JSON/CSV exports into investigation graph
- Map SpiderFoot entity types to our schema
- Suggest SpiderFoot modules based on investigation needs
- Interpret SpiderFoot scan results
- Prioritize SpiderFoot findings for manual follow-up
- Identify high-value targets from automated scans
- Correlate SpiderFoot data with manual OSINT findings

**Invocation:** When importing from or planning SpiderFoot scans.

**Output:** Imported graph data, scan recommendations, prioritized findings.

**SpiderFoot Commands:**
```bash
# Start SpiderFoot web UI
sf -l

# Run targeted scan
sf -s <target> -m <modules> -o json > imports/spiderfoot/scan.json

# Import results
python scripts/import_spiderfoot.py imports/spiderfoot/scan.json
```

---

### migration-processor

**Purpose:** Import existing investigation materials into this framework.

**Capabilities:**
- Analyze existing case file structures
- Extract entities from unstructured notes
- Identify relationships from narrative text
- Map files to appropriate directories
- Create metadata for imported evidence
- Generate migration reports
- Preserve original file integrity

**Invocation:** When importing existing investigations via `/migrate`.

**Output:** Migrated files, populated graph, entity profiles, migration report.

---

## Agent Invocation

Agents are invoked implicitly through commands or can be referenced when describing needed work:

| Command | Primary Agent(s) |
|---------|-----------------|
| `/collect` | evidence-processor |
| `/profile` | entity-profiler |
| `/timeline` | timeline-builder |
| `/network` | network-mapper, graph-manager, correlation-analyst |
| `/leads` | gap-analyst |
| `/status` | gap-analyst, correlation-analyst |
| `/report` | report-generator |
| `/dossier` | report-generator, correlation-analyst |
| `/evidence-summary` | evidence-processor, source-validator |
| `/migrate` | migration-processor, entity-profiler, graph-manager |
| `/import-spiderfoot` | spiderfoot-integrator, graph-manager |

## Agent Principles

All agents follow core investigation principles:

1. **Evidence-based**: Claims require citations
2. **Confidence-rated**: Assessments include certainty levels
3. **Transparent**: Methods documented
4. **Ethical**: Only public/authorized information
5. **Preserving**: Original evidence never modified
