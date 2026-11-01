# OpsGuard — Linux System Health Monitor

OpsGuard is a lightweight Linux system monitoring tool built using Bash scripting.

It monitors CPU, RAM, and disk usage, checks configurable thresholds, generates health alerts, and stores monitoring reports in log files.

## Features

- CPU usage monitoring
- RAM usage monitoring
- Disk usage monitoring
- Configurable monitoring thresholds
- Automatic health status alerts
- Timestamped log generation
- Central configuration management

## Project Structure

```text
OpsGuard/
├── config/
│   └── opsguard.conf
├── lib/
│   └── config_loader.sh
├── logs/
│   └── system_monitor.log
├── scripts/
│   └── system_monitor.sh
└── README.md
```

## Requirements

- Linux / Ubuntu
- Bash
- `top`
- `free`
- `df`
- `awk`

## Usage

Clone the repository and enter the project directory.

Run:

```bash
chmod +x scripts/system_monitor.sh
./scripts/system_monitor.sh
```

## Configuration

Edit `config/opsguard.conf` to customize:

- CPU threshold
- RAM threshold
- Disk threshold
- Backup retention
- Monitoring interval
- Logging level

## Concepts Learned

- Linux system monitoring
- Bash scripting
- Shell functions and variables
- Configuration management
- Input validation
- Conditional statements
- Log management
- Exit codes

## Future Scope

- Automated monitoring with Cron
- Email alerts
- Remote server monitoring
- Advanced monitoring dashboard

## Author

Built as a hands-on Linux and Shell Scripting DevOps learning project.
