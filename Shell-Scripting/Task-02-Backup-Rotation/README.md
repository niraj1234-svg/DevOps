# Task 02: Automated Backup & Recovery Using Cron

## Overview
A Bash-based automated backup system that creates timestamped
backup directories, copies source files, and maintains only the
latest three backups using an automatic rotation mechanism.

## Features
- Accepts source directory as a command-line argument.
- Validates directory existence and permissions.
- Creates timestamped backup directories.
- Copies files and hidden files while preserving metadata.
- Excludes previously generated backup directories.
- Retains only the latest three backups.
- Removes older backups automatically.
- Supports Cron scheduling.
- Logs backup execution details.

## Project Structure

Task-02-Backup-Rotation/
├── backup_with_rotation.sh
└── README.md

## Usage

Make the script executable:

chmod +x backup_with_rotation.sh

Run the backup:

./backup_with_rotation.sh /home/ubuntu/important-data

## Backup Naming Convention

backup_YYYY-MM-DD_HH-MM-SS

## Backup Rotation

The script automatically retains the latest three backups
and deletes older timestamped backup directories.

## Cron Scheduling

Configured to run daily at 2:00 AM:

0 2 * * * /home/ubuntu/DevOps-repo/Shell-Scripting/Task-02-Backup-Rotation/backup_with_rotation.sh /home/ubuntu/important-data >> /home/ubuntu/backup-cron.log 2>&1

## Log File

/home/ubuntu/backup-cron.log

## Concepts Learned
- Bash scripting
- Command-line arguments
- Directory validation
- Date and timestamp handling
- File copying
- Bash arrays and loops
- Backup rotation
- Cron scheduling
- Linux permissions
- Logging and error handling

## Testing
- Successfully created timestamped backups.
- Verified copied files and subdirectories.
- Tested backup rotation with four executions.
- Confirmed only three backups remained.
- Tested invalid and missing arguments.
- Verified Cron service status.

## Future Improvements
- Store backups on a separate disk or remote server.
- Add email notifications.
- Implement backup restoration.
- Add checksum verification.
