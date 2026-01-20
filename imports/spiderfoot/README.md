# SpiderFoot Imports

Place SpiderFoot export files here for import.

## Exporting from SpiderFoot

### CLI Export
```bash
sf -s <target> -o json > scan_results.json
sf -s <target> -o csv > scan_results.csv
```

### Web UI Export
1. Open SpiderFoot web interface (default: http://localhost:5001)
2. Navigate to your scan
3. Click "Export"
4. Select JSON or CSV format
5. Save to this directory

## Importing

```bash
# Using the import script
python scripts/import_spiderfoot.py scan_results.json

# Or using the Claude command
/import-spiderfoot imports/spiderfoot/scan_results.json
```

## File Naming

Recommended naming: `YYYY-MM-DD_<target>_scan.json`

Example: `2024-01-15_example-com_scan.json`
