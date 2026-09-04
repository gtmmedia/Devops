#!/bin/bash

set -euo pipefail

# Store system information in variables
current_date=$(date)
hostname=$(hostname)
username=$(whoami)
disk_usage=$(df -h)

# Take user input
read -r -p "Enter the directory name: " directory
directory="${directory//$'\r'/}"

if [[ -z "$directory" ]]; then
	echo "Error: directory name cannot be empty." >&2
	exit 1
fi


mkdir -p "$directory"


file="$directory/processes.txt"
touch "$file"

ps aux > "$file"

echo "========================================"
echo "System Information"
echo "========================================"
echo "Current Date: $current_date"
echo "Hostname: $hostname"
echo "Username: $username"

echo
echo "Disk Usage:"
echo "$disk_usage"

echo
echo "Running Processes:"
ps aux

echo
echo "Process information has been saved to: $file"
echo "========================================"