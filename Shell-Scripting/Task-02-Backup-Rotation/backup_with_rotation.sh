#!/bin/bash

# Check whether source directory is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

SOURCE_DIR="$1"

# Validate source directory
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Convert source path to absolute path
SOURCE_DIR=$(realpath "$SOURCE_DIR")

# Prevent backing up the root directory
if [[ "$SOURCE_DIR" == "/" ]]; then
    echo "Error: Root directory cannot be used."
    exit 1
fi

# Check write permission
if [[ ! -w "$SOURCE_DIR" ]]; then
    echo "Error: No write permission for source directory."
    exit 1
fi

echo "Source directory: $SOURCE_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup directory
BACKUP_DIR="$SOURCE_DIR/backup_$TIMESTAMP"

if ! mkdir -p "$BACKUP_DIR"; then
    echo "Error: Could not create backup directory."
    exit 1
fi

echo "Backup directory created: $BACKUP_DIR"

# Copy source files into backup directory
shopt -s dotglob nullglob

for ITEM in "$SOURCE_DIR"/*; do
    ITEM_NAME=$(basename "$ITEM")

    # Skip previously generated backup directories
    if [[ "$ITEM_NAME" =~ ^backup_[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}$ ]]; then
        continue
    fi

    # Skip the backup directory currently being created
    if [[ "$ITEM" == "$BACKUP_DIR" ]]; then
        continue
    fi

    if ! cp -a -- "$ITEM" "$BACKUP_DIR/"; then
        echo "Error: Backup failed while copying $ITEM"
        rm -rf -- "$BACKUP_DIR"
        exit 1
    fi
done

echo "Files copied successfully!"


# Find all generated backup directories
mapfile -t BACKUPS < <(
    find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 \
    -type d \
    -regextype posix-extended \
    -regex '.*/backup_[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}' \
    | sort
)

# Keep only the latest 3 backups
BACKUP_COUNT=${#BACKUPS[@]}

if (( BACKUP_COUNT > 3 )); then
    DELETE_COUNT=$((BACKUP_COUNT - 3))

    for ((i = 0; i < DELETE_COUNT; i++)); do
        echo "Removing old backup: ${BACKUPS[$i]}"
        rm -rf -- "${BACKUPS[$i]}"
    done
fi

echo "Backup rotation completed."
echo "Total backups retained: $(find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d -regextype posix-extended -regex '.*/backup_[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}' | wc -l)"
