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
