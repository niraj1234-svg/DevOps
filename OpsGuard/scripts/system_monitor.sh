#!/bin/bash

# OpsGuard System Health Monitor

OPSGUARD_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load configuration
source "$OPSGUARD_ROOT/lib/config_loader.sh" || exit 1

echo "========== OPSGUARD SYSTEM REPORT =========="

# CPU Usage
CPU_USAGE=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {print $4}' | awk '{print 100-$1}')

# RAM Usage
RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

# Disk Usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "CPU Usage:  $CPU_USAGE%"
echo "RAM Usage:  $RAM_USAGE%"
echo "Disk Usage: $DISK_USAGE%"

# Threshold Alerts

echo ""
echo "========== HEALTH ALERTS ==================="

if (( $(printf "%.0f" "$CPU_USAGE") >= CPU_THRESHOLD )); then
    echo "WARNING: High CPU Usage!"
else
    echo "CPU Status: NORMAL"
fi

if (( RAM_USAGE >= RAM_THRESHOLD )); then
    echo "WARNING: High RAM Usage!"
else
    echo "RAM Status: NORMAL"
fi

if (( DISK_USAGE >= DISK_THRESHOLD )); then
    echo "WARNING: High Disk Usage!"
else
    echo "Disk Status: NORMAL"
fi

# Save report to log file

LOG_FILE="$OPSGUARD_ROOT/logs/system_monitor.log"

{
    echo "Timestamp: $(date)"
    echo "CPU: ${CPU_USAGE}% | RAM: ${RAM_USAGE}% | Disk: ${DISK_USAGE}%"
    echo "--------------------------------------------"
} >> "$LOG_FILE"

echo ""
echo "Report saved to: $LOG_FILE"

echo "============================================"
