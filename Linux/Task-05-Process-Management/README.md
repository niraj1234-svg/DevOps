# Task 05 – Linux Process Management & Monitoring

## Objective

Monitor running processes, inspect system resource utilization, capture command output in a log file, and terminate a background process.

## 1. Start a Background Process

```bash
ping google.com > ping_test.log &
```

- `ping google.com` sends network requests to Google.
- `>` redirects command output into `ping_test.log`.
- `&` runs the process in the background.

The shell returned process ID (PID) `2065`.

## 2. Find the Running Process

```bash
ps aux | grep 'ping google.com'
```

This command lists processes and filters the output for the ping process.

A cleaner alternative is:

```bash
ps aux | grep '[p]ing google.com'
```

## 3. Monitor System Resources

```bash
top
```

`top` displays running processes and system resource usage, including CPU and memory utilization.

The ping process was observed in the process list.

## 4. Monitor with htop

```bash
htop
```

`htop` is an interactive process-monitoring utility.

## 5. Inspect Process Output

```bash
tail -n 10 ping_test.log
```

This displays the last ten lines of the ping log.

Successful ping replies were observed in the log.

## 6. Terminate the Background Process

```bash
kill 2065
```

Verify process status:

```bash
ps -p 2065
```

## Commands and Concepts Used

| Command | Purpose |
|---|---|
| `ping` | Test network connectivity |
| `&` | Run a process in the background |
| `ps aux` | List running processes |
| `grep` | Filter process output |
| `top` | Monitor CPU and memory |
| `htop` | Interactive process monitoring |
| `tail` | Read the end of a log file |
| `kill` | Send a termination signal to a process |

## Result

Started and monitored a background process, inspected system resource usage, captured process output in a log file, and issued a termination command for the process.
