#!/bin/bash

#Variables
LOG_DIR = /var/log/myapp
LOG_FILE = /var/log/myapp/log_rotation.log

#1. Check LOG_FILE is available or not
if [ ! -d "$LOG_DIR" ]; then
  echo "$LOG_DIR doesn't exist. Exiting" >> "$LOG_FILE"
  exit 1
fi

#2. If availabe, find and compress the logs older than 7 days
find "$LOG_DIR" -type f -name "*.log" -mtime +7 -mtime -30 ! name "*.gz" -exec gzip {} \; -exec echo "[$date] Compressed {}" >> "$LOG_FILE" \;

#3. Remove the zipped log files older than 30 days
find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -exec rm -rf {} \; exec echo "[$date] Removed {}" >> "$LOG_FILE" \;

#4. Done
echo "[$date] Log rotation completed successfully" "$LOG_FILE"
