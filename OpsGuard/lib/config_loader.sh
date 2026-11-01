#!/bin/bash

# =====================================
# OPSGUARD CONFIGURATION LOADER
# =====================================

# Locate OpsGuard root directory
OPSGUARD_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Define configuration file path
CONFIG_FILE="$OPSGUARD_ROOT/config/opsguard.conf"

# Check whether configuration exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERROR: Configuration file not found: $CONFIG_FILE"
    return 1 2>/dev/null || exit 1
fi

# Load configuration
source "$CONFIG_FILE"


# Validate percentage values
validate_percentage() {
    local NAME="$1"
    local VALUE="$2"

    if ! [[ "$VALUE" =~ ^[0-9]+$ ]] || (( VALUE < 1 || VALUE > 100 )); then
        echo "ERROR: $NAME must be between 1 and 100."
        return 1
    fi
	}
# Validate monitoring thresholds
validate_percentage "CPU_THRESHOLD" "$CPU_THRESHOLD" || return 1
validate_percentage "RAM_THRESHOLD" "$RAM_THRESHOLD" || return 1
validate_percentage "DISK_THRESHOLD" "$DISK_THRESHOLD" || return 1


# Validate positive integer values
validate_positive_integer() {
    local NAME="$1"
    local VALUE="$2"

    if ! [[ "$VALUE" =~ ^[0-9]+$ ]] || (( VALUE < 1 )); then
        echo "ERROR: $NAME must be a positive integer."
        return 1
    fi
}

# Validate backup and monitoring settings
validate_positive_integer "BACKUP_RETENTION" "$BACKUP_RETENTION" || return 1

validate_positive_integer "MONITOR_INTERVAL" "$MONITOR_INTERVAL" || return 1


# Validate logging level
validate_log_level() {
    local VALUE="$1"

    case "$VALUE" in
        INFO|WARNING|ERROR)
            return 0
            ;;
        *)
            echo "ERROR: Invalid LOG_LEVEL. Use INFO, WARNING, or ERROR."
            return 1
            ;;
    esac
}
validate_log_level "$LOG_LEVEL" || return 1


# Final success messages
echo "All monitoring thresholds are valid."
echo "All numeric configuration values are valid."
echo "Logging configuration is valid."
echo "OpsGuard configuration loaded successfully."
