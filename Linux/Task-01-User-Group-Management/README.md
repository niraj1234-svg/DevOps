# Task 01: Linux User, Group, Sudo & SSH Management

## Objective
- Create a Linux user named `devops_user`.
- Create a group named `devops_team`.
- Add the user to the group.
- Set a password and grant sudo access.
- Restrict SSH login for the specified user.

## Commands Executed

### 1. Create group
```bash
sudo groupadd devops_team
```

### 2. Create user
```bash
sudo useradd -m devops_user
```

### 3. Add user to group
```bash
sudo usermod -aG devops_team devops_user
```

### 4. Set password
```bash
sudo passwd devops_user
```

### 5. Grant sudo access
```bash
sudo usermod -aG sudo devops_user
```

### 6. Restrict SSH login
Backup configuration:
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

Edit configuration:
```bash
sudo vim /etc/ssh/sshd_config
```

Add:
```text
DenyUsers devops_user
```

Validate and reload:
```bash
sudo sshd -t
sudo systemctl reload ssh
```

## Verification

### User and group
```bash
id devops_user
```

Output:
```text
uid=1005(devops_user) gid=1007(devops_user) groups=1007(devops_user),27(sudo),1006(devops_team)
```

### SSH restriction
```bash
sudo sshd -T | grep -i denyusers
```

Output:
```text
denyusers devops_user
```

### Password status
```bash
sudo passwd -S devops_user
```

Output:
```text
devops_user P 2026-10-30 0 99999 7 -1
```

### SSH service status
```bash
sudo systemctl is-active ssh
```

Output:
```text
active
```

## Learning Outcomes
- Linux user and group management.
- Managing supplementary group membership.
- Granting sudo privileges.
- Configuring SSH access restrictions.
- Validating SSH configuration and service status.

**Status:** Completed

