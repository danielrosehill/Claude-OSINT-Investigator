# Collect Evidence

Systematically collect and document evidence from a source.

## Arguments

$ARGUMENTS - The URL, platform, or source to collect from

## Instructions

### 1. Identify Source Type

Determine what kind of collection is needed:
- Web page / article
- Social media profile
- Social media post/thread
- Document / file
- Search results
- API response

### 2. Collection Process

**For Web Content:**
1. Use WebFetch to retrieve content
2. Note the URL and access timestamp
3. Save raw content to `evidence/raw/`
4. Request user screenshot if visual preservation needed

**For Social Media:**
1. Document platform and identifier
2. Collect available public information
3. Note what data points were accessible
4. Flag time-sensitive content for user screenshot

**For Documents:**
1. Save original to `evidence/documents/`
2. Note source and how obtained
3. Create processed/extracted version if needed

### 3. Create Evidence Record

For each piece of evidence, create a companion metadata file:

Filename: `[evidence-filename].meta.md`

```markdown
# Evidence Metadata

**File**: [Original filename]
**Type**: [Web page / Social media / Document / etc.]
**Collected**: [YYYY-MM-DD HH:MM UTC]

---

## Source Information

- **URL/Location**: [Full URL or source description]
- **Platform**: [If applicable]
- **Access Method**: [Direct / WebFetch / User-provided / etc.]

---

## Content Summary

[Brief description of what this evidence contains]

---

## Relevance

**Related to**: [Which investigation objective/question]
**Entities mentioned**: [List any subjects, persons, orgs]
**Key information**: [What makes this valuable]

---

## Verification Status

- [ ] Source authenticity confirmed
- [ ] Content integrity verified
- [ ] Cross-referenced with other sources

---

## Processing Notes

[Any transformations, extractions, or analysis performed]

---

## Chain of Custody

| Date | Action | By |
|------|--------|-----|
| [Date] | Collected | Claude |
```

### 4. Naming Convention

Use consistent naming:
```
YYYY-MM-DD_source_subject_description.ext
```

Examples:
- `2024-01-15_twitter_johndoe_profile.md`
- `2024-01-15_linkedin_acme-corp_about.md`
- `2024-01-15_news_subject-arrest_article.md`

### 5. Update Indexes

After collection:
- Add to `sources/sources-index.md` (create if needed)
- Update relevant entity profiles
- Note in leads tracker if this opens new avenues
- Flag for timeline if contains dated events
