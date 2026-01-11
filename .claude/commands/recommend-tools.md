# Recommend OSINT Tools

Suggest MCP servers and tools based on investigation needs.

## Instructions

### 1. Review Investigation Context

Read:
- `brief/brief.md` for investigation objectives
- `context/osint-mcp-servers.json` for available MCP options

### 2. Analyze Requirements

Based on the investigation type, identify needed capabilities:

**People Investigations:**
- Username enumeration (Maigret)
- Social media analysis
- Public records search

**Infrastructure/Technical Investigations:**
- Network scanning (Shodan, ZoomEye)
- Domain analysis (DNSTwist)
- Threat intelligence (VirusTotal)

**Brand/Corporate Investigations:**
- Domain monitoring (DNSTwist)
- Network reconnaissance (OSINT Toolkit)
- Corporate records

### 3. Generate Recommendations

Present to user:

```markdown
# Recommended OSINT MCP Servers

Based on your investigation objectives, I recommend the following tools:

## High Priority

### [Tool Name]
- **Why**: [How it helps this investigation]
- **Install**: [GitHub URL]
- **API Key Required**: Yes/No
- **Key Capabilities**: [List]

## Medium Priority

[Additional tools that could be useful]

## Installation Notes

[Any specific setup requirements]

## Alternative Approaches

[If MCP not available, suggest manual methods]
```

### 4. Check Current Setup

Ask user:
- Which OSINT MCPs are already installed?
- Are API keys available for tools that need them?
- Any tools they prefer to avoid?

### 5. Provide Installation Guidance

For recommended tools:
- Link to GitHub repository
- Note API key requirements
- Suggest adding to `.mcp.json` in project

### 6. Reference

Full list of OSINT MCPs: https://github.com/soxoj/awesome-osint-mcp-servers

The `context/osint-mcp-servers.json` file contains curated recommendations with capability descriptions.
