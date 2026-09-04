#!/bin/bash

# Store system information in variables
current_date=$(date)
hostname=$(hostname)
username=$(whoami)
disk_usage=$(df -h)

# Take user input
read -p "Enter the directory name: " directory


mkdir -p "$directory"


file="$directory/processes.txt"
touch "$file"

ps aux > "$file"

echo "Current Date: $current_date"
echo "Hostname: $hostname"
echo "Username: $username"

echo "$disk_usage"

ps aux

echo "Process information has been saved to: $file"
echo "========================================"