#!/bin/bash

# Define the source directories to back up
SOURCE_DIRS=(
  "/home/slaven"
)

# Define the backup destination
DESTINATION=""

# Get the current date for the backup filename
DATE=$(date +"%Y-%m-%d")

# Create the backup filename
BACKUP_FILENAME="backup-$DATE.tar.gz"

# Back up the list of installed software
INSTALLED_SOFTWARE_FILE="$DESTINATION/installed_software_$DATE.txt"
echo "Backing up the list of installed software..."
dpkg --get-selections >"$INSTALLED_SOFTWARE_FILE"

# Perform the backup using tar
echo "Starting backup..."
tar -czvf "$DESTINATION/$BACKUP_FILENAME" "${SOURCE_DIRS[@]}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully. Saved as $DESTINATION/$BACKUP_FILENAME"
  echo "Installed software list saved as $INSTALLED_SOFTWARE_FILE"
else
  echo "Backup failed!"
fi
