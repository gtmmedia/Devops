# Shell Scripting Homework: System Information

This submission contains a Bash script that collects basic system information and saves the running-process list to a user-selected directory.

## Files

| File | Purpose |
| --- | --- |
| `system_info.sh` | Main system information script |
| `processes.txt` | Example captured process output |
| `system_data/processes.txt` | Example output directory and process file |

## Requirements covered

- Prints the current date using `date`.
- Prints the hostname using `hostname`.
- Prints the current username using `whoami`.
- Prints disk usage using `df -h`.
- Prints running processes using `ps aux`.
- Uses variables for collected values and file paths.
- Takes directory input with `read -p`.
- Creates the requested directory with `mkdir -p`.
- Creates the process file with `touch`.
- Saves process information using `ps aux > "$directory/processes.txt"`.

## Run the script

From this directory:

```bash
chmod +x system_info.sh
./system_info.sh
```

When prompted, enter a directory name such as `system_data`. The script creates the directory and writes the process report to `system_data/processes.txt`.

For a non-interactive test:

```bash
printf "system_data\n" | ./system_info.sh
```

## Commands and sample output

The following is a representative run. Date, hostname, username, process IDs, and process lists depend on the machine where the script runs.

```text
$ chmod +x system_info.sh
$ printf "system_data\n" | ./system_info.sh
Enter the directory name: ========================================
System Information
========================================
Current Date: Fri Sep  4 12:00:00 UTC 2026
Hostname: devops-machine
Username: student

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        80G   32G   45G  42% /

Running Processes:
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
student     1001  0.0  0.1  12000  4000 pts/0    Ss   12:00   0:00 -bash
student     1002  0.0  0.0   7000  2500 pts/0    R+   12:00   0:00 ps aux

Process information has been saved to: system_data/processes.txt
========================================
```

The complete process table is stored in the generated `processes.txt` file.

## Verification

```bash
test -d system_data && echo "Directory created"
test -f system_data/processes.txt && echo "File created"
test -s system_data/processes.txt && echo "Process output saved"
```

Expected result:

```text
Directory created
File created
Process output saved
```