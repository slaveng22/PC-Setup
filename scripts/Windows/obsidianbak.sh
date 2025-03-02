#!/bin/bash

# BAK to SSD
# Define the source and destination directories
source="<sourcedir>"
destination="<destinationdir>"

  # Create a timestamp for the new directory name
timestamp=$(date +%Y-%m-%d_%H-%M-%S)

# Create a new directory on the destination with the timestamp appended
new_dir_name=$(basename $source)_$timestamp
mkdir -p "$destination/$new_dir_name"

# Copy the contents of the source directory to the new directory on the destination
rsync -rvz $source "$destination/$new_dir_name"

# Delete directories in the destination older than 90 days
find "$destination" -mindepth 1 -maxdepth 1 -type d -mtime +90 -exec rm -rf
