# Evidence

This folder contains all collected evidence organized by type and processing state.

## Structure

- **raw/** - Unprocessed data exactly as collected (preserve originals)
- **processed/** - Data that has been cleaned, formatted, or extracted
- **screenshots/** - Visual captures of web pages, social media, etc.
- **documents/** - PDFs, text files, leaked documents, etc.
- **media/** - Images, videos, audio files

## For Claude

When collecting evidence:
1. Always save raw data first before any processing
2. Use descriptive filenames with dates: `YYYY-MM-DD_source_description.ext`
3. Create a companion `.meta.md` file for each piece of evidence documenting:
   - Source URL/location
   - Date/time collected
   - Collection method
   - Relevance to investigation
   - Chain of custody notes

Evidence integrity is paramount. Never modify files in `raw/` - make copies to `processed/` for analysis.
