# Linux User Account Management System

A Bash-based Linux user management utility that simplifies common account administration tasks through command-line options.

## Features

- **Create Users:** Create new Linux accounts and securely set passwords.
- **Delete Users:** Delete existing accounts after confirmation.
- **Reset Passwords:** Securely update passwords for existing users.
- **List Users:** Display system usernames and their corresponding UIDs.
- **Help & Usage:** Display command-line options and usage instructions.

## Technologies Used

- Linux
- Bash Shell Scripting
- Vim
- AWK
- Linux User Management Utilities

## Project Structure

```text
Task-01-User-Account-Management/
│
├── user_manager.sh
└── README.md
```

## Usage

Make the script executable:

```bash
chmod +x user_manager.sh
```

### 1. Create a User

```bash
sudo ./user_manager.sh -c
```

### 2. Delete a User

```bash
sudo ./user_manager.sh -d
```

### 3. Reset User Password

```bash
sudo ./user_manager.sh -r
```

### 4. List All Users and UIDs

```bash
sudo ./user_manager.sh -l
```

### 5. Display Help

```bash
./user_manager.sh -h
```

## Available Options

| Short Option | Long Option | Description |
|---|---|---|
| `-c` | `--create` | Create a user account |
| `-d` | `--delete` | Delete an existing account |
| `-r` | `--reset` | Reset account password |
| `-l` | `--list` | List usernames and UIDs |
| `-h` | `--help` | Display help information |

## Concepts Practiced

- Bash functions
- Command-line arguments
- Case statements
- Conditional statements
- User input using `read`
- Hidden password input
- Linux user administration
- Error handling and exit status
- AWK text processing

## Security Considerations

- Administrative operations require root privileges.
- Password input is hidden from terminal display.
- Existing usernames are checked before account operations.
- User deletion requires confirmation.
- Passwords are not printed in success messages.

## Learning Outcome

Built a command-line Linux account management utility while gaining practical experience with Bash scripting, Linux administration, user authentication and error handling.
