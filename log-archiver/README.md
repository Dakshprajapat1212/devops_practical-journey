
the project task resource:-https://roadmap.sh/projects/log-archive-tool
📄 Log Archiving Script — Documentation

1. Introduction

This Bash script automates the process of archiving log files from a specified directory, compressing them into .tar.gz format, and saving them to a central archive folder.
It also keeps a history log of all archives created.

This is useful for:
	•	DevOps Engineers managing logs
	•	SysAdmins doing periodic backups
	•	Developers maintaining server cleanup scripts

⸻

2. Features

✅ Takes any directory as input
✅ Bundles & compresses all files into .tar.gz
✅ Saves archives in a central folder ($HOME/log-archives)
✅ Maintains a history log with timestamps
✅ Works with sudo for protected directories
✅ Simple & reusable

⸻

3. Full Script

#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"                                    # Directory to archive
ARCHIVE_DIR="$HOME/log-archives"                # Where archives will be stored
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")               # Unique timestamp
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"  # Archive file name
HISTORY_FILE="$ARCHIVE_DIR/archive_history.log"  # Log file to track archives

# Check if log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory $LOG_DIR does not exist."
    exit 1
fi

# Create archive directory if not exists
mkdir -p "$ARCHIVE_DIR"

# Create tar.gz archive (compress all files inside the log directory)
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Record action in history file
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archived $LOG_DIR to $ARCHIVE_DIR/$ARCHIVE_NAME" >> "$HISTORY_FILE"

# Success message
echo "Archive created: $ARCHIVE_DIR/$ARCHIVE_NAME"


⸻

4. How It Works
	1.	User runs

./logar.sh /var/log

or with sudo if accessing protected files:

sudo ./logar.sh /var/log

	2.	Script checks if:
	•	Input directory exists
	•	Archive directory exists (creates it if not)
	3.	Bundles (tar) all files from log directory
	4.	Compresses (-z) into .tar.gz format
	5.	Saves file into $HOME/log-archives
Example:

logs_archive_20250815_073338.tar.gz


	6.	Logs metadata in archive_history.log

⸻

5. Example Output

$ ./logar.sh /var/log
Archive created: /home/ubuntu/log-archives/logs_archive_20250815_073338.tar.gz

History File:

[2025-08-15 07:33:38] Archived /var/log to /home/ubuntu/log-archives/logs_archive_20250815_073338.tar.gz


⸻

6. Common Commands
	•	Check folder size

du -sh /var/log
sudo du -sh /var/log

	•	Check archive size

du -sh log-archives
sudo du -sh /root/log-archives/logs_archive_20250815_073518.tar.gz

	•	List archives with sizes

ls -lh $HOME/log-archives


⸻

7. Troubleshooting
	•	Permission denied while archiving
→ Run with sudo if source folder contains protected files.
	•	Archive stored in /root/log-archives
→ This happens if run with sudo (uses root’s $HOME).
Use full path for ARCHIVE_DIR to avoid this. Example:

ARCHIVE_DIR="/home/ubuntu/log-archives"


	•	Command not found after rename
→ Ensure filename is correct:

chmod +x logar.sh
./logar.sh /var/log



⸻

8. Future Improvements
	•	Auto-delete archives older than X days
	•	Send archive to AWS S3 for cloud backup
	•	Email notification after archive creation
	•	Cron job scheduling for automation

⸻



<img width="1470" height="956" alt="Screenshot 2025-08-15 at 1 09 02 PM" src="https://github.com/user-attachments/assets/7cda62cb-6ec1-46e5-8cbc-b10d8f05b1d7" />



