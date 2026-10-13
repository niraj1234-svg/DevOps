
# NetWatch — Linux Network Monitoring Tool

NetWatch is a Bash-based network monitoring project that
checks website DNS resolution, HTTP status codes, and
response times.

## Features

- DNS resolution checks
- HTTP/HTTPS health checks using curl
- Response-time measurement
- Timestamped CSV logging
- Automated checks using cron
- Summary report generation

## Tech Stack

- Ubuntu Linux
- Bash scripting
- curl
- Git and GitHub
- cron

## Project Structure

- `scripts/health-check.sh` — performs website health checks
- `scripts/report.sh` — summarizes monitoring records
- `logs/` — stores CSV monitoring history
- `docs/` — project documentation

## Usage

Run a health check:

```bash
./scripts/health-check.sh https://example.com
```

Generate a summary report:

```bash
./scripts/report.sh
```

View monitoring history:

```bash
cat logs/health-check.csv
```

## Learning Outcomes

- Linux networking and troubleshooting
- Bash scripting
- DNS and HTTP diagnostics
- CSV logging
- Cron automation
- Git version control

## Future Improvements

- Better HTTP failure classification
- Failure notifications
- Docker containerization
- AWS deployment
- Monitoring dashboard
