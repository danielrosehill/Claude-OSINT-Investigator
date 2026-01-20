# Scripts

Helper scripts for graph processing and data import.

## Available Scripts

### export_graph.py

Export the investigation graph to various formats.

```bash
# Mermaid diagram (for markdown)
python export_graph.py --format mermaid

# GEXF for Gephi
python export_graph.py --format gexf -o network.gexf

# DOT for Graphviz
python export_graph.py --format dot -o network.dot

# CSV (entities and relationships)
python export_graph.py --format csv

# Neo4j Cypher statements
python export_graph.py --format cypher -o import.cypher
```

### import_spiderfoot.py

Import SpiderFoot scan results into the graph.

```bash
python import_spiderfoot.py <spiderfoot_export.json>
python import_spiderfoot.py <spiderfoot_export.csv>
```

## Requirements

Scripts require the Python venv created by `setup.sh`:

```bash
source .venv/bin/activate
```

Dependencies: `networkx`, `python-dateutil`, `jinja2`
