#!/bin/bash

###################################
# This script used for:
# 1. Check the desired log path exists or not.
# 2. If exists, compress the log files older than 7 days 
# 3. and deletes the zipped log files older than 30 days
# 4. You can schedule a cronjob of this script to run daily
###################################

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
