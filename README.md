# Claude OSINT Investigator

A Claude Code template for conducting open-source intelligence (OSINT) investigations with structured workflows and evidence management.

## What This Is

This template transforms Claude Code into an OSINT investigation assistant. It provides:

- **Structured investigation workflow** - From brief to final report
- **Evidence management** - Organized storage with chain of custody documentation
- **Analysis frameworks** - Entity profiles, timelines, and network mapping
- **Slash commands** - Purpose-built commands for common OSINT tasks
- **MCP integration** - Recommendations for OSINT-focused MCP servers

## Getting Started

1. **Clone or use as template** for your investigation
2. Run `/onboarding` to establish your investigation brief
3. Run `/recommend-tools` to get MCP server suggestions for your investigation type
4. Begin investigating using the available commands

## Available Commands

| Command | Purpose |
|---------|---------|
| `/onboarding` | Initialize investigation, gather brief, define scope |
| `/status` | Generate progress report on investigation |
| `/report` | Create formal investigation report |
| `/profile [entity]` | Build detailed profile of person/org/account |
| `/leads` | Track and investigate leads systematically |
| `/timeline` | Build chronological timeline of events |
| `/network` | Map relationships and connections |
| `/collect [source]` | Collect and document evidence from a source |
| `/recommend-tools` | Suggest OSINT MCP servers for this investigation |

## Directory Structure

```
├── brief/              # Investigation brief and scope
├── evidence/           # Collected evidence (raw, processed, screenshots, etc.)
├── analysis/           # Analytical products (timelines, network maps, profiles)
├── reports/            # Formal deliverables (drafts and final)
├── sources/            # Source documentation and archives
├── notes/              # Working notes and hypotheses
├── working/            # Temporary workspace
└── context/            # Reference data for the agent
```

Each folder contains a README explaining its purpose and how Claude should use it.

## Recommended MCP Servers

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
