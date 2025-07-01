#!/bin/bash

# Usage: ./archive_files_by_date.sh /path/to/source YYYY-MM-DD YYYY-MM-DD

if [ $# -ne 3 ]; then
  echo "Usage: $0 SOURCE_DIR FROM_DATE TO_DATE"
  echo "Example: $0 /var/log 2022-01-01 2022-12-31"
  exit 1
fi

SOURCE_DIR="$1"
FROM_DATE="$2"
TO_DATE="$3"

# Validate dates
if ! date -d "$FROM_DATE" >/dev/null || ! date -d "$TO_DATE" >/dev/null; then
  echo "Error: Invalid date format. Use YYYY-MM-DD."
  exit 1
fi

# Create output dir (e.g., /tmp/20220101_20221231_logs)
OUTPUT_DIR="/tmp/$(date -d "$FROM_DATE" +%Y%m%d)_$(date -d "$TO_DATE" +%Y%m%d)_logs"
mkdir -p "$OUTPUT_DIR"

echo "Copying files modified between $FROM_DATE and $TO_DATE..."
find "$SOURCE_DIR" -type f -newermt "$FROM_DATE" ! -newermt "$(date -d "$TO_DATE + 1 day" +%Y-%m-%d)" \
  -exec rsync -a --relative {} "$OUTPUT_DIR" \;

echo "Files copied to: $OUTPUT_DIR"
