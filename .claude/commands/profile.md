# Create Entity Profile

Build a comprehensive profile for a person, organization, or other entity.

## Arguments

$ARGUMENTS - The entity name or identifier to profile

## Instructions

### 1. Confirm Subject

If $ARGUMENTS is provided, use it as the subject. Otherwise, ask the user:
- What entity should be profiled?
- What type? (Person / Organization / Online Account / Other)

**Code Names:** Check `context/codenames.md` to see if this entity has a code name. If not, ask the user if they'd like to assign one for privacy/consistency. Add new code names to the registry.

### 2. Check Existing Work

- Look in `analysis/entity-profiles/` for existing profiles on this entity
- Check `brief/brief.md` for context on why this entity is relevant

### 3. Gather Information

Using available OSINT tools and web searches, collect:

**For Persons:**
- Full name and known aliases
- Online presence (social media, websites)
- Professional information (employment, roles)
- Affiliations and connections
- Public records information
- Notable activities or events

**For Organizations:**
- Official name and DBAs
- Registration information
- Leadership and key personnel
- Online presence
- Business activities
- Affiliations and subsidiaries

**For Online Accounts:**
- Platform and username
- Account creation date (if discoverable)
- Posting history and patterns
- Connections and followers of interest
- Content themes and topics
- Associated accounts or identities

### 4. Create Profile Document

Save to `analysis/entity-profiles/[CODENAME].md` (use code name if assigned, otherwise entity name):

```markdown
# Entity Profile: [CODENAME]

**Code Name**: [CODENAME]
**Type**: [Person / Organization / Account]
**Created**: [Date]
**Last Updated**: [Date]
**Confidence**: [High / Medium / Low]

---

## Summary

[2-3 sentence overview of who/what this entity is and their relevance]

---

## Identifiers

| Type | Value | Source | Verified |
|------|-------|--------|----------|
| Name | | | |
| Username | | | |
| Email | | | |

---

## Detailed Findings

### [Category 1]
[Findings with evidence citations]

### [Category 2]
[Continue as needed]

---

## Connections

[List known connections to other entities in this investigation]
- [Entity] - [Relationship type] - [Evidence]

---

## Timeline

| Date | Event | Source |
|------|-------|--------|

---

## Open Questions

- [What we still don't know]

---

## Sources

- [List all sources with links to evidence files]
```

### 5. Update Cross-References

- Add entity to any relevant network maps in `analysis/network-maps/`
- Update timeline in `analysis/timeline/` if new events discovered
- Note connections to other profiled entities
