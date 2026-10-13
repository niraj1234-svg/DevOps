
#!/usr/bin/env bash

set -u

TARGET="${1:-https://example.com}"
HOST=$(printf '%s\n' "$TARGET" |
    sed -E 's#^https?://##; s#/.*##')

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
LOG_FILE="$PROJECT_DIR/logs/health-check.csv"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$(dirname "$LOG_FILE")"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "timestamp,target,dns_status,http_status,response_time_seconds" > "$LOG_FILE"
fi

echo "================================"
echo "        NetWatch Monitor"
echo "================================"
echo "Target: $TARGET"
echo "Time:   $TIMESTAMP"
echo

if getent hosts "$HOST" >/dev/null 2>&1; then
    DNS_STATUS="PASS"
else
    DNS_STATUS="FAIL"
fi

RESULT=$(curl -sS -L --max-time 10 \
    -o /dev/null \
    -w '%{http_code} %{time_total}' \
    "$TARGET" 2>/dev/null) || RESULT="000 0"

HTTP_CODE=$(printf '%s' "$RESULT" | awk '{print $1}')
RESPONSE_TIME=$(printf '%s' "$RESULT" | awk '{print $2}')

if [[ "$DNS_STATUS" == "PASS" ]]; then
    echo "[PASS] DNS resolution"
else
    echo "[FAIL] DNS resolution"
fi

if [[ "$HTTP_CODE" =~ ^[23][0-9][0-9]$ ]]; then
    echo "[PASS] HTTP status: $HTTP_CODE"
else
    echo "[FAIL] HTTP status: $HTTP_CODE"
fi

echo "Response time: ${RESPONSE_TIME}s"

printf '"%s","%s","%s","%s","%s"\n' \
    "$TIMESTAMP" "$TARGET" "$DNS_STATUS" \
    "$HTTP_CODE" "$RESPONSE_TIME" >> "$LOG_FILE"

echo
echo "Log saved: $LOG_FILE"

