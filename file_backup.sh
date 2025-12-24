#!/usr/bin/env bash
##############################
# Script Name: file_backup.sh
# Description: This script creates a backup of a specified directory with a timestamp.  
# Author: Prakash
# Date: 2024-06-10
# Version: 1.0
# Usage: ./file_backup.sh
##############################

source_dir="./"
backup_dir="/home/$USER/backups"

set -e 
# Script to create a backup of specified directory
echo "Script Started at Date: $(date)"
# create backup directory if it doesn't exist

timestamp=$(date +%Y-%m-%d_%H-%M-%S)
mkdir /home/$USER/backups
backup_file="backup_${timestamp}.tar.gz"

# Create the backup...
echo "Staring Backup..."
echo "Creating Backup of ${source_dir} to ${backup_dir} as ${backup_file}"
tar -czf "${backup_dir}/$backup_file" "${source_dir}" 2>>/dev/null

# Check if the backup was successful
if [ $? -eq 0 ]; then
       echo "Backup Created Successfully: $backup_file"
else 

    echo "Backup Failed"   
fi


