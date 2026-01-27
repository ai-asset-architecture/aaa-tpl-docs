#!/bin/bash
# Auto-archive script for aaa-tpl-docs
# Moves files older than 30 days to archive/YYYY-MM/

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ARCHIVE_DIR="$REPO_ROOT/archive"
AUDIT_DIR="$REPO_ROOT/internal/development/audits"

# Cutoff date (30 days ago)
CUTOFF_DATE=$(date -v-30d +%Y%m%d 2>/dev/null || date -d "30 days ago" +%Y%m%d)

echo "🗂️  Auto-Archive Script"
echo "Cutoff date: $CUTOFF_DATE"
echo ""

# Archive old audit files
find "$AUDIT_DIR" -type f -name "*.md" ! -name "LATEST*.md" | while read -r file; do
    filename=$(basename "$file")
    
    # Extract date from filename (YYYYMMDD format)
    if [[ $filename =~ ([0-9]{8}) ]]; then
        file_date="${BASH_REMATCH[1]}"
        
        # Compare dates
        if [ "$file_date" -lt "$CUTOFF_DATE" ]; then
            # Extract year-month for archive folder
            year_month="${file_date:0:4}-${file_date:4:2}"
            dest_dir="$ARCHIVE_DIR/$year_month/audits"
            
            mkdir -p "$dest_dir"
            mv "$file" "$dest_dir/"
            echo "✅ Archived: $filename → $year_month/audits/"
        fi
    fi
done

echo ""
echo "✨ Auto-archive complete!"
