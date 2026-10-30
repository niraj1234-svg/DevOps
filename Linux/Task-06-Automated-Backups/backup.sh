#!/bin/bash

SOURCE="/home/ubuntu/DevOps-repo/Linux/devops_workspace"
DEST="/backups"
DATE=$(date +%F)

mkdir -p "$DEST"

if tar -czf "$DEST/backup_$DATE.tar.gz" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"; then
    echo -e "\e[32mBackup completed successfully: backup_$DATE.tar.gz\e[0m"
else
    echo -e "\e[31mBackup failed!\e[0m"
    exit 1
fi
