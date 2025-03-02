#!/bin/bash

# Define the backup source (where the backup is stored)
BACKUP_SOURCE=""

# Define the destination directory to restore the files
RESTORE_DESTINATION="/home/slaven"

# Find the latest backup file (assuming they follow the naming convention)
LATEST_BACKUP=$(ls -t "$BACKUP_SOURCE"/backup-*.tar.gz | head -n 1)

# Find the latest installed software list file
LATEST_INSTALLED_SOFTWARE=$(ls -t "$BACKUP_SOURCE"/installed_software_*.txt | head -n 1)

# Check if the latest backup file exists
if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup file found in $BACKUP_SOURCE!"
  exit 1
fi

# Check if the latest installed software list exists
if [ -z "$LATEST_INSTALLED_SOFTWARE" ]; then
  echo "No installed software list found in $BACKUP_SOURCE!"
  exit 1
fi

# Restore the files from the backup
echo "Restoring files from $LATEST_BACKUP to $RESTORE_DESTINATION..."
tar -xzvf "$LATEST_BACKUP" -C /

# Restore the list of installed software
echo "Restoring installed software from $LATEST_INSTALLED_SOFTWARE..."
sudo dpkg --set-selections <"$LATEST_INSTALLED_SOFTWARE"
sudo apt-get dselect-upgrade -y

# Check if the restore was successful
if [ $? -eq 0 ]; then
  echo "Restore completed successfully."
else
  echo "Restore failed!"
fi
