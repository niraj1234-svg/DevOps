#!/bin/bash

# Linux User Account Management System

# Function to create a new user
create_user() {

    # Take username input
    read -r -p "Enter new username: " username

    # Validate username
    if [[ ! "$username" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]; then
        echo "Invalid username!"
        return 1
    fi

    # Check whether user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists!"
        return 1
    fi

    # Take password securely
    read -r -s -p "Enter password: " password
    echo ""

    if [[ -z "$password" ]]; then
        echo "Password cannot be empty!"
        return 1
    fi

    # Create user account
    if useradd -m "$username"; then

        # Set password
        if printf '%s:%s\n' "$username" "$password" | chpasswd; then
            echo "User '$username' created successfully!"
        else
            echo "Password setup failed. Removing incomplete account."
            userdel "$username"
            unset password
            return 1
        fi

    else
        echo "User creation failed!"
        unset password
        return 1
    fi

    unset password
}

# Display heading
echo "======================================"
echo "  LINUX USER ACCOUNT MANAGEMENT"
echo "======================================"

# Function to display help information
show_help() {

    echo "=========================================="
    echo "       LINUX USER ACCOUNT MANAGER"
    echo "=========================================="

    echo "Usage: sudo ./user_manager.sh [OPTION]"
    echo ""
    echo "Available Options:"
    echo ""
    echo "  -c, --create    Create a new user account"
    echo "  -d, --delete    Delete an existing user"
    echo "  -r, --reset     Reset user password"
    echo "  -l, --list      List users and their UIDs"
    echo "  -h, --help      Display help information"
    echo ""
    echo "Examples:"
    echo "  sudo ./user_manager.sh -c"
    echo "  sudo ./user_manager.sh -d"
    echo "  sudo ./user_manager.sh -r"
    echo "  sudo ./user_manager.sh -l"
    echo "  ./user_manager.sh -h"
}

# Function to list all system users and their UIDs
list_users() {

    echo "=========================================="
    echo "          SYSTEM USER ACCOUNTS"
    echo "=========================================="

    printf "%-25s %-10s\n" "USERNAME" "UID"
    echo "------------------------------------------"

    awk -F: '{
        printf "%-25s %-10s\n", $1, $3
    }' /etc/passwd
}

# Function to reset an existing user's password
reset_password() {

    # Ask for username
    read -r -p "Enter username: " username

    # Check whether user exists
    if ! id "$username" &>/dev/null; then
        echo "User '$username' does not exist!"
        return 1
    fi

    # Ask for new password securely
    read -r -s -p "Enter new password: " password
    echo ""

    # Validate password
    if [[ -z "$password" ]]; then
        echo "Password cannot be empty!"
        unset password
        return 1
    fi

    # Update password
    if printf '%s:%s\n' "$username" "$password" | chpasswd; then
        echo "Password for '$username' updated successfully!"
    else
        echo "Password reset failed!"
        unset password
        return 1
    fi

    # Clear password variable
    unset password
}

# Function to delete an existing user
delete_user() {

    # Ask for username
    read -r -p "Enter username to delete: " username

    # Check whether username exists
    if ! id "$username" &>/dev/null; then
        echo "User '$username' does not exist!"
        return 1
    fi

    # Ask for confirmation
    read -r -p "Are you sure you want to delete '$username'? (y/n): " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then

        # Delete user and its home directory
        if userdel -r "$username"; then
            echo "User '$username' deleted successfully!"
        else
            echo "Failed to delete user '$username'!"
            return 1
        fi

    else
        echo "User deletion cancelled."
    fi
} 

# Display help without requiring root privileges
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Handle missing arguments
if [[ $# -eq 0 ]]; then
    echo "No option provided!"
    show_help
    exit 1
fi

# Validate command-line option
case "$1" in
    -c|--create|-d|--delete|-r|--reset|-l|--list)
        ;;
    *)
        echo "Invalid Option: $1"
        show_help
        exit 1
        ;;
esac

# Administrator permission check
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run this script using sudo."
    exit 1
fi

# Handle options
case "$1" in

    -c|--create)
        create_user
        ;;

    -d|--delete)
    delete_user
    ;;

    -r|--reset)
    reset_password
    ;;


    -l|--list)
    list_users
    ;;

     -h|--help)
    show_help
    ;;

    *)
        echo "Invalid Option!"
        exit 1
        ;;

esac
