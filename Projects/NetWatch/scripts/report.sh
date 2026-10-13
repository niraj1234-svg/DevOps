#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
LOG_FILE="$PROJECT_DIR/logs/health-check.csv"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "No monitoring log found."
    exit 1
fi

echo "=================================="
echo "      NetWatch Summary Report"
echo "=================================="
echo "Generated: $(date)"
echo

TOTAL=$(tail -n +2 "$LOG_FILE" | wc -l)
HTTP_OK=$(awk -F',' 'NR > 1 && $4 ~ /"2[0-9][0-9]"/ {n++} END {print n+0}' "$LOG_FILE")
HTTP_FAILED=$(awk -F',' 'NR > 1 && $4 ~ /"000"/ {n++} END {print n+0}' "$LOG_FILE")
DNS_FAILED=$(awk -F',' 'NR > 1 && $3 ~ /"FAIL"/ {n++} END {print n+0}' "$LOG_FILE")

echo "Total checks:       $TOTAL"
echo "HTTP 2xx responses: $HTTP_OK"
echo "No HTTP response:   $HTTP_FAILED"
echo "DNS failures:       $DNS_FAILED"
echo
echo "Latest records:"
tail -n 5 "$LOG_FILE"
