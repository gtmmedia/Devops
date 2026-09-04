# Linux Fundamentals Homework

This folder covers file links, Linux user-management commands, system logs, and everyday Linux commands.

## Task 1: Soft links and hard links

### Difference

| Feature | Soft link (symbolic link) | Hard link |
| --- | --- | --- |
| Created with | `ln -s target link` | `ln target link` |
| Points to | The target path | The target inode and data |
| Works across file systems | Yes | No |
| Can link to directories | Usually yes | Usually no |
| Survives target deletion | No; becomes dangling | Yes, until the last hard link is removed |
| Inode number | Different from the target | Same as the target |

### Practice

```bash
mkdir -p link-practice
cd link-practice
printf "Linux links\n" > original.txt

# Create one symbolic link and one hard link.
ln -s original.txt soft-link.txt
ln original.txt hard-link.txt

# Compare inode numbers and link types.
ls -li original.txt soft-link.txt hard-link.txt
stat original.txt soft-link.txt hard-link.txt

# Both links read the same content.
cat soft-link.txt
cat hard-link.txt

# Deleting the original leaves the hard link usable but breaks the soft link.
rm original.txt
cat hard-link.txt
ls -l soft-link.txt

# Clean up the practice files.
cd ..
rm -rf link-practice
```

### Interview answer

A soft link is a separate file containing a path to another file. A hard link is another directory entry for the same inode. Soft links can cross file systems and can point to directories, while hard links normally cannot. Removing the original file breaks a soft link, but a hard link continues to work because the data remains until its last link is removed.

## Task 2: `adduser` versus `useradd`

| Command | Description |
| --- | --- |
| `adduser` | A friendlier Debian/Ubuntu Perl script that asks for the user details, creates the home directory, and sets up defaults. |
| `useradd` | A lower-level program that creates a user from explicit flags. It is useful for automation and scripts, but usually needs more options. |

On Ubuntu, `adduser` is generally preferred for creating a normal interactive user because it applies sensible defaults and guides the administrator through the process. `useradd` is useful when a precise, non-interactive account definition is required.

### Practice on Ubuntu

These commands require administrator privileges. Replace the example username if it already exists:

```bash
sudo adduser linux-homework-user
id linux-homework-user
getent passwd linux-homework-user
ls -ld /home/linux-homework-user
```

Remove the practice account after testing:

```bash
sudo deluser --remove-home linux-homework-user
```

Equivalent low-level example:

```bash
sudo useradd --create-home --shell /bin/bash linux-homework-user
sudo passwd linux-homework-user
sudo userdel --remove linux-homework-user
```

Do not run both creation examples with the same username without deleting the test account between them.

## Task 3: `journalctl`

`journalctl` reads logs collected by `systemd-journald`. It can show system events, boot messages, kernel messages, and logs for individual services.

### Useful commands

```bash
# View the complete journal.
journalctl

# Show the current boot, newest entries last.
journalctl -b
journalctl -b --no-pager -n 50

# Follow new log entries in real time.
sudo journalctl -f

# Show logs for a service. ssh.service may be sshd.service on some distributions.
sudo journalctl -u ssh.service --no-pager -n 50

# Show logs from the last hour.
sudo journalctl --since "1 hour ago"

# Show only warnings and more severe messages.
sudo journalctl -p warning..alert --since today
```

For a service name available on the current machine, use:

```bash
systemctl list-units --type=service --state=running
sudo journalctl -u <service-name>.service --no-pager -n 50
```

## Task 4: Linux command cheat sheet

| Command | Purpose | Example |
| --- | --- | --- |
| `pwd` | Print the current directory | `pwd` |
| `ls -la` | List files, including hidden files | `ls -la` |
| `cd` | Change directory | `cd /var/log` |
| `mkdir -p` | Create a directory tree | `mkdir -p project/logs` |
| `touch` | Create a file or update its timestamp | `touch notes.txt` |
| `cp` | Copy files or directories | `cp source.txt backup.txt` |
| `mv` | Move or rename files | `mv old.txt new.txt` |
| `rm` | Remove files | `rm unwanted.txt` |
| `cat` | Print a file | `cat /etc/hostname` |
| `less` | Read a file page by page | `less /var/log/syslog` |
| `head` / `tail` | Show the beginning or end of a file | `tail -f app.log` |
| `grep` | Search text | `grep -i error app.log` |
| `find` | Search for files | `find . -name "*.log"` |
| `chmod` | Change permissions | `chmod +x script.sh` |
| `chown` | Change owner and group | `sudo chown user:group file` |
| `df -h` | Show filesystem disk usage | `df -h` |
| `du -sh` | Show directory size | `du -sh .` |
| `free -h` | Show memory usage | `free -h` |
| `ps aux` | List running processes | `ps aux` |
| `top` | Monitor processes live | `top` |
| `kill` | Send a signal to a process | `kill PID` |
| `ip addr` | Show network addresses | `ip addr` |
| `ss -tuln` | Show listening sockets | `ss -tuln` |
| `curl` | Make an HTTP request | `curl -I https://example.com` |
| `tar` | Create or extract archives | `tar -czf backup.tar.gz folder/` |
| `man` | Read command documentation | `man journalctl` |

### Safe practice session

```bash
mkdir -p ~/linux-homework-practice
cd ~/linux-homework-practice
echo "practice" > notes.txt
grep practice notes.txt
find . -type f
du -sh .
df -h .
rm notes.txt
cd ..
rmdir linux-homework-practice
```

The commands that modify users, permissions, services, or system logs should be run only on a test machine or with an understanding of their effect.