#!/usr/bin/env bash
#
# OSINT Investigation Setup Script
# Initializes the investigation environment with optional SpiderFoot integration
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      OSINT Investigation Environment Setup                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo

# Check for required tools
check_requirements() {
    echo -e "${YELLOW}Checking requirements...${NC}"

    local missing=()

    command -v python3 >/dev/null 2>&1 || missing+=("python3")
    command -v jq >/dev/null 2>&1 || missing+=("jq")
    command -v uv >/dev/null 2>&1 || missing+=("uv (pip install uv)")

    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${RED}Missing required tools:${NC}"
        printf '  - %s\n' "${missing[@]}"
        echo
        echo "Please install missing tools and re-run setup."
        exit 1
    fi

    echo -e "${GREEN}✓ All requirements met${NC}"
}

# Create directory structure
create_directories() {
    echo -e "${YELLOW}Creating directory structure...${NC}"

    local dirs=(
        "brief"
        "evidence/raw"
        "evidence/processed"
        "evidence/screenshots"
        "evidence/documents"
        "evidence/media"
        "analysis/timeline"
        "analysis/network-maps"
        "analysis/entity-profiles"
        "analysis/parties"
        "reports/drafts"
        "reports/final"
        "sources/verified"
        "sources/unverified"
        "sources/archived"
        "notes"
        "working"
        "context/logs"
        "graph"
        "imports/spiderfoot"
        "imports/manual"
        "scripts"
    )

    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done

    echo -e "${GREEN}✓ Directory structure created${NC}"
}

# Initialize Python virtual environment
setup_python_env() {
    echo -e "${YELLOW}Setting up Python environment...${NC}"

    if [ ! -d ".venv" ]; then
        uv venv .venv
    fi

    source .venv/bin/activate

    # Install graph processing dependencies
    uv pip install networkx python-dateutil jinja2 >/dev/null 2>&1

    echo -e "${GREEN}✓ Python environment ready${NC}"
}

# Initialize graph data files
init_graph_data() {
    echo -e "${YELLOW}Initializing graph data...${NC}"

    local timestamp=$(date -Iseconds)

    if [ ! -f "graph/entities.json" ] || [ ! -s "graph/entities.json" ]; then
        cat > graph/entities.json << EOF
{
  "\$schema": "./schema.json",
  "version": "1.0.0",
  "lastUpdated": "$timestamp",
  "investigation": null,
  "entities": []
}
EOF
    fi

    if [ ! -f "graph/relationships.json" ] || [ ! -s "graph/relationships.json" ]; then
        cat > graph/relationships.json << EOF
{
  "\$schema": "./schema.json",
  "version": "1.0.0",
  "lastUpdated": "$timestamp",
  "investigation": null,
  "relationships": []
}
EOF
    fi

    echo -e "${GREEN}✓ Graph data initialized${NC}"
}

# Create Python helper scripts
create_scripts() {
    echo -e "${YELLOW}Creating helper scripts...${NC}"

    # Graph export script
    cat > scripts/export_graph.py << 'PYTHON'
#!/usr/bin/env python3
"""
Export investigation graph to various formats.

Usage:
    python export_graph.py --format [dot|gexf|csv|cypher|mermaid]
    python export_graph.py --format mermaid --output network.md
"""

import json
import argparse
import sys
from pathlib import Path
from datetime import datetime

def load_graph():
    """Load entities and relationships from JSON files."""
    graph_dir = Path(__file__).parent.parent / "graph"

    with open(graph_dir / "entities.json") as f:
        entities_data = json.load(f)

    with open(graph_dir / "relationships.json") as f:
        relationships_data = json.load(f)

    return entities_data.get("entities", []), relationships_data.get("relationships", [])

def get_entity_label(entity):
    """Get display label for an entity."""
    if entity.get("codename"):
        return entity["codename"]
    props = entity.get("properties", {})
    return props.get("name") or props.get("username") or props.get("address") or entity["id"][:8]

def export_dot(entities, relationships):
    """Export to Graphviz DOT format."""
    lines = ["digraph Investigation {", "  rankdir=LR;", "  node [shape=box];", ""]

    # Entity type colors
    colors = {
        "PERSON": "lightblue",
        "ORGANIZATION": "lightgreen",
        "USERNAME": "lightyellow",
        "EMAIL": "lightpink",
        "DOMAIN": "lightgray",
        "IP_ADDRESS": "orange",
        "LOCATION": "lightcoral"
    }

    # Add nodes
    for entity in entities:
        label = get_entity_label(entity)
        color = colors.get(entity["type"], "white")
        lines.append(f'  "{entity["id"]}" [label="{label}\\n({entity["type"]})" fillcolor="{color}" style=filled];')

    lines.append("")

    # Add edges
    for rel in relationships:
        lines.append(f'  "{rel["source"]}" -> "{rel["target"]}" [label="{rel["type"]}"];')

    lines.append("}")
    return "\n".join(lines)

def export_gexf(entities, relationships):
    """Export to GEXF format for Gephi."""
    timestamp = datetime.now().isoformat()

    lines = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<gexf xmlns="http://gexf.net/1.3" version="1.3">',
        f'  <meta lastmodifieddate="{timestamp[:10]}">',
        '    <creator>OSINT Investigation</creator>',
        '  </meta>',
        '  <graph mode="static" defaultedgetype="directed">',
        '    <attributes class="node">',
        '      <attribute id="0" title="type" type="string"/>',
        '      <attribute id="1" title="codename" type="string"/>',
        '      <attribute id="2" title="confidence" type="string"/>',
        '    </attributes>',
        '    <nodes>'
    ]

    for entity in entities:
        label = get_entity_label(entity)
        lines.append(f'      <node id="{entity["id"]}" label="{label}">')
        lines.append('        <attvalues>')
        lines.append(f'          <attvalue for="0" value="{entity["type"]}"/>')
        lines.append(f'          <attvalue for="1" value="{entity.get("codename", "")}"/>')
        lines.append(f'          <attvalue for="2" value="{entity.get("confidence", "")}"/>')
        lines.append('        </attvalues>')
        lines.append('      </node>')

    lines.append('    </nodes>')
    lines.append('    <edges>')

    for i, rel in enumerate(relationships):
        lines.append(f'      <edge id="{i}" source="{rel["source"]}" target="{rel["target"]}" label="{rel["type"]}"/>')

    lines.append('    </edges>')
    lines.append('  </graph>')
    lines.append('</gexf>')

    return "\n".join(lines)

def export_csv(entities, relationships):
    """Export to CSV format (two files content)."""
    # Entities CSV
    entity_lines = ["id,type,codename,label,confidence"]
    for entity in entities:
        label = get_entity_label(entity)
        entity_lines.append(f'{entity["id"]},{entity["type"]},{entity.get("codename", "")},"{label}",{entity.get("confidence", "")}')

    # Relationships CSV
    rel_lines = ["source,target,type,confidence"]
    for rel in relationships:
        rel_lines.append(f'{rel["source"]},{rel["target"]},{rel["type"]},{rel.get("confidence", "")}')

    return "=== ENTITIES ===\n" + "\n".join(entity_lines) + "\n\n=== RELATIONSHIPS ===\n" + "\n".join(rel_lines)

def export_cypher(entities, relationships):
    """Export as Neo4j Cypher statements."""
    lines = ["// Neo4j Cypher import statements", "// Run these in Neo4j Browser or cypher-shell", ""]

    # Create nodes
    for entity in entities:
        label = get_entity_label(entity)
        props = json.dumps(entity.get("properties", {}))
        lines.append(f'CREATE (n:{entity["type"]} {{id: "{entity["id"]}", label: "{label}", codename: "{entity.get("codename", "")}", properties: \'{props}\'}});')

    lines.append("")

    # Create relationships
    for rel in relationships:
        lines.append(f'MATCH (a {{id: "{rel["source"]}"}}), (b {{id: "{rel["target"]}"}}) CREATE (a)-[:{rel["type"]}]->(b);')

    return "\n".join(lines)

def export_mermaid(entities, relationships):
    """Export as Mermaid diagram."""
    lines = ["```mermaid", "graph TD"]

    # Group entities by type for subgraphs
    by_type = {}
    for entity in entities:
        t = entity["type"]
        if t not in by_type:
            by_type[t] = []
        by_type[t].append(entity)

    # Create subgraphs
    for entity_type, type_entities in by_type.items():
        lines.append(f"    subgraph {entity_type}s")
        for entity in type_entities:
            label = get_entity_label(entity)
            # Use short ID for mermaid
            short_id = entity["id"].replace("-", "")[:8]
            lines.append(f'        {short_id}["{label}"]')
        lines.append("    end")

    lines.append("")

    # Create edges
    for rel in relationships:
        src_short = rel["source"].replace("-", "")[:8]
        tgt_short = rel["target"].replace("-", "")[:8]
        lines.append(f'    {src_short} -->|{rel["type"]}| {tgt_short}')

    lines.append("```")
    return "\n".join(lines)

def main():
    parser = argparse.ArgumentParser(description="Export investigation graph")
    parser.add_argument("--format", "-f", choices=["dot", "gexf", "csv", "cypher", "mermaid"], required=True)
    parser.add_argument("--output", "-o", help="Output file (default: stdout)")

    args = parser.parse_args()

    entities, relationships = load_graph()

    if not entities:
        print("No entities in graph.", file=sys.stderr)
        sys.exit(0)

    exporters = {
        "dot": export_dot,
        "gexf": export_gexf,
        "csv": export_csv,
        "cypher": export_cypher,
        "mermaid": export_mermaid
    }

    output = exporters[args.format](entities, relationships)

    if args.output:
        with open(args.output, "w") as f:
            f.write(output)
        print(f"Exported to {args.output}", file=sys.stderr)
    else:
        print(output)

if __name__ == "__main__":
    main()
PYTHON

    chmod +x scripts/export_graph.py

    # SpiderFoot import script
    cat > scripts/import_spiderfoot.py << 'PYTHON'
#!/usr/bin/env python3
"""
Import SpiderFoot investigation data into the graph format.

Usage:
    python import_spiderfoot.py <spiderfoot_export.json>
    python import_spiderfoot.py <spiderfoot_export.csv>
"""

import json
import csv
import sys
import uuid
from pathlib import Path
from datetime import datetime

# SpiderFoot type mappings
SF_TYPE_MAP = {
    "HUMAN_NAME": "PERSON",
    "COMPANY_NAME": "ORGANIZATION",
    "AFFILIATE_COMPANY_NAME": "ORGANIZATION",
    "EMAILADDR": "EMAIL",
    "EMAILADDR_GENERIC": "EMAIL",
    "PHONE_NUMBER": "PHONE",
    "DOMAIN_NAME": "DOMAIN",
    "INTERNET_NAME": "DOMAIN",
    "AFFILIATE_INTERNET_NAME": "DOMAIN",
    "IP_ADDRESS": "IP_ADDRESS",
    "IPV6_ADDRESS": "IP_ADDRESS",
    "USERNAME": "USERNAME",
    "SOCIAL_MEDIA": "USERNAME",
    "BITCOIN_ADDRESS": "CRYPTOCURRENCY",
    "GEOINFO": "LOCATION",
    "PHYSICAL_ADDRESS": "LOCATION",
    "RAW_FILE_META": "DOCUMENT",
    "LINKED_URL_INTERNAL": "DOCUMENT",
    "PASSWORD_COMPROMISED": "CREDENTIAL",
    "HASH_COMPROMISED": "CREDENTIAL",
    "MALICIOUS_HASH": "MALWARE"
}

def load_spiderfoot_json(filepath):
    """Load SpiderFoot JSON export."""
    with open(filepath) as f:
        data = json.load(f)
    return data

def load_spiderfoot_csv(filepath):
    """Load SpiderFoot CSV export."""
    data = []
    with open(filepath, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    return data

def process_spiderfoot_data(sf_data):
    """Convert SpiderFoot data to our graph format."""
    entities = {}
    relationships = []
    timestamp = datetime.now().isoformat()

    for item in sf_data:
        # Handle both JSON and CSV formats
        sf_type = item.get("type") or item.get("Type", "")
        sf_data_val = item.get("data") or item.get("Data", "")
        sf_source = item.get("source") or item.get("Source", "")
        sf_module = item.get("module") or item.get("Module", "")

        # Map to our entity type
        entity_type = SF_TYPE_MAP.get(sf_type, "CUSTOM")

        # Create entity if not exists
        entity_key = f"{entity_type}:{sf_data_val}"
        if entity_key not in entities:
            entity_id = str(uuid.uuid4())
            entities[entity_key] = {
                "id": entity_id,
                "type": entity_type,
                "codename": None,
                "properties": get_properties_for_type(entity_type, sf_data_val),
                "sources": [],
                "confidence": "MEDIUM",
                "created": timestamp,
                "updated": timestamp,
                "notes": f"Imported from SpiderFoot ({sf_module})",
                "spiderfootType": sf_type
            }

        # Add source reference
        entities[entity_key]["sources"].append({
            "type": "SPIDERFOOT",
            "reference": f"SpiderFoot: {sf_module}",
            "date": timestamp,
            "originalType": sf_type
        })

        # Create relationship if there's a source entity
        if sf_source and sf_source != sf_data_val:
            source_type = SF_TYPE_MAP.get(item.get("source_type", ""), "CUSTOM")
            source_key = f"{source_type}:{sf_source}"

            if source_key in entities:
                relationships.append({
                    "id": str(uuid.uuid4()),
                    "type": "LINKED_TO",
                    "source": entities[source_key]["id"],
                    "target": entities[entity_key]["id"],
                    "direction": "directed",
                    "properties": {"context": f"Discovered via {sf_module}"},
                    "sources": [{"type": "SPIDERFOOT", "reference": sf_module, "date": timestamp}],
                    "confidence": "MEDIUM",
                    "created": timestamp,
                    "notes": None,
                    "spiderfootId": None
                })

    return list(entities.values()), relationships

def get_properties_for_type(entity_type, value):
    """Generate properties based on entity type."""
    if entity_type == "PERSON":
        return {"name": value}
    elif entity_type == "ORGANIZATION":
        return {"name": value}
    elif entity_type == "EMAIL":
        return {"address": value, "domain": value.split("@")[-1] if "@" in value else None}
    elif entity_type == "PHONE":
        return {"number": value}
    elif entity_type == "DOMAIN":
        return {"domain": value}
    elif entity_type == "IP_ADDRESS":
        return {"address": value, "version": "v6" if ":" in value else "v4"}
    elif entity_type == "USERNAME":
        return {"username": value}
    elif entity_type == "CRYPTOCURRENCY":
        return {"address": value, "currency": "BTC"}
    elif entity_type == "LOCATION":
        return {"address": value}
    else:
        return {"value": value}

def merge_with_existing(new_entities, new_relationships, graph_dir):
    """Merge imported data with existing graph."""
    entities_file = graph_dir / "entities.json"
    relationships_file = graph_dir / "relationships.json"

    # Load existing
    with open(entities_file) as f:
        existing_entities = json.load(f)
    with open(relationships_file) as f:
        existing_relationships = json.load(f)

    # Add new entities
    existing_entities["entities"].extend(new_entities)
    existing_entities["lastUpdated"] = datetime.now().isoformat()

    # Add new relationships
    existing_relationships["relationships"].extend(new_relationships)
    existing_relationships["lastUpdated"] = datetime.now().isoformat()

    # Save
    with open(entities_file, "w") as f:
        json.dump(existing_entities, f, indent=2)
    with open(relationships_file, "w") as f:
        json.dump(existing_relationships, f, indent=2)

    return len(new_entities), len(new_relationships)

def main():
    if len(sys.argv) < 2:
        print("Usage: python import_spiderfoot.py <spiderfoot_export.json|csv>")
        sys.exit(1)

    filepath = Path(sys.argv[1])

    if not filepath.exists():
        print(f"File not found: {filepath}")
        sys.exit(1)

    # Load based on extension
    if filepath.suffix.lower() == ".json":
        sf_data = load_spiderfoot_json(filepath)
    elif filepath.suffix.lower() == ".csv":
        sf_data = load_spiderfoot_csv(filepath)
    else:
        print("Unsupported file format. Use JSON or CSV.")
        sys.exit(1)

    # Process
    entities, relationships = process_spiderfoot_data(sf_data)

    # Merge with existing graph
    graph_dir = Path(__file__).parent.parent / "graph"
    num_entities, num_rels = merge_with_existing(entities, relationships, graph_dir)

    print(f"Imported {num_entities} entities and {num_rels} relationships from SpiderFoot")

if __name__ == "__main__":
    main()
PYTHON

    chmod +x scripts/import_spiderfoot.py

    echo -e "${GREEN}✓ Helper scripts created${NC}"
}

# Install SpiderFoot (optional)
install_spiderfoot() {
    echo
    echo -e "${YELLOW}SpiderFoot Integration${NC}"
    echo "SpiderFoot is an OSINT automation tool that can collect data from 200+ sources."
    echo
    read -p "Would you like to install SpiderFoot? [y/N] " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Installing SpiderFoot...${NC}"

        # Check if already installed
        if command -v sf >/dev/null 2>&1; then
            echo -e "${GREEN}SpiderFoot already installed${NC}"
            return
        fi

        # Install via pip in our venv
        source .venv/bin/activate
        uv pip install spiderfoot >/dev/null 2>&1

        if command -v sf >/dev/null 2>&1; then
            echo -e "${GREEN}✓ SpiderFoot installed${NC}"
            echo
            echo "SpiderFoot commands:"
            echo "  sf -l                  # Start web UI on localhost:5001"
            echo "  sf -s target.com       # Scan a target"
            echo "  sf -m all -o json      # Output as JSON for import"
        else
            echo -e "${YELLOW}SpiderFoot installation may require additional steps.${NC}"
            echo "See: https://github.com/smicallef/spiderfoot"
        fi
    else
        echo "Skipping SpiderFoot installation."
        echo "You can install it later with: uv pip install spiderfoot"
    fi
}

# Initialize git if needed
init_git() {
    if [ ! -d ".git" ]; then
        echo -e "${YELLOW}Initializing git repository...${NC}"
        git init >/dev/null 2>&1

        # Create .gitignore
        cat > .gitignore << 'EOF'
# Virtual environment
.venv/
venv/

# Python
__pycache__/
*.py[cod]
.Python

# SpiderFoot
*.sqlite
spiderfoot.db

# Sensitive data (add patterns as needed)
# *.eml
# credentials*

# OS files
.DS_Store
Thumbs.db

# IDE
.idea/
.vscode/
*.swp
EOF

        echo -e "${GREEN}✓ Git repository initialized${NC}"
    fi
}

# Main setup
main() {
    check_requirements
    echo
    create_directories
    setup_python_env
    init_graph_data
    create_scripts
    init_git
    install_spiderfoot

    echo
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║      Setup Complete!                                       ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo "Next steps:"
    echo "  1. Run Claude Code in this directory"
    echo "  2. Use /onboarding to set up your investigation"
    echo "  3. Use /recommend-tools for OSINT tool suggestions"
    echo
    echo "Import existing data:"
    echo "  - /migrate <path>           Import existing case files"
    echo "  - /import-spiderfoot <file> Import SpiderFoot export"
    echo
    echo "Graph analysis:"
    echo "  python scripts/export_graph.py --format mermaid"
    echo "  python scripts/export_graph.py --format gexf -o network.gexf"
    echo
}

main "$@"
