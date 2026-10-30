# Task 06 – Automated Backups Using Shell Scripting and Cron

## Objective

Create a shell script to automatically back up a workspace into a compressed `.tar.gz` archive and schedule the backup using cron.

## 1. Source Workspace

The workspace used for this practical:

`/home/ubuntu/DevOps-repo/Linux/devops_workspace`

It contains:

`project_notes.txt`

## 2. Backup Script

Script name: `backup.sh`

```bash
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
```

## 3. Make Script Executable

```bash
chmod +x backup.sh
```

## 4. Execute Backup Script

```bash
sudo ./backup.sh
```

The script creates a compressed backup archive in `/backups`.

## 5. Verify Backup

List backup files:

```bash
ls -lh /backups/
```

Inspect archive contents:

```bash
tar -tzf /backups/backup_2026-10-30.tar.gz
```

The archive was verified to contain the workspace and `project_notes.txt`.

## 6. Schedule Automatic Backups Using Cron

Open the root user's crontab:

```bash
sudo crontab -e
```

Add the following entry:

```cron
0 2 * * * /home/ubuntu/DevOps-repo/Linux/Task-06-Automated-Backups/backup.sh >> /backups/cron.log 2>&1
```

## Cron Expression Explanation

| Field | Value | Meaning |
|---|---|---|
| Minute | 0 | At minute zero |
| Hour | 2 | At 2 AM |
| Day | * | Every day |
| Month | * | Every month |
| Weekday | * | Every weekday |

## 7. Verify Cron Execution

```bash
sudo crontab -l
```

Check cron logs:

```bash
sudo grep CRON /var/log/syslog | tail -n 20
```

Check backup execution output:

```bash
sudo cat /backups/cron.log
```

The cron job was tested with a temporary every-minute schedule. Successful backup messages were observed. The final schedule was configured for daily execution at 2 AM.

## Commands and Concepts Used

| Command | Purpose |
|---|---|
| `tar -czf` | Create compressed archive |
| `date +%F` | Generate date in YYYY-MM-DD format |
| `chmod +x` | Make script executable |
| `crontab -e` | Edit scheduled jobs |
| `crontab -l` | List scheduled jobs |
| `ls -lh` | List files with human-readable sizes |
| `tail` | Display recent log lines |

## Result

Successfully created a shell-based backup solution, generated and verified a compressed archive, tested automatic execution through cron, and configured the final schedule for daily backups at 2 AM.
