#!/bin/bash

# Variables
NFS_SERVER="your_nfs_server"
NFS_PATH="/path/on/nfs"
MOUNT_POINT="/mnt/nfs"
LOCAL_FILE="path/to/local/file"
UPLOAD_FILE_NAME=$(basename ${LOCAL_FILE})
HOSTNAME=$(hostname) # Ensure the hostname is defined

# Define the UCS filename with hostname and a timestamp
UCS_FILENAME="/var/local/ucs/${HOSTNAME}_backup_$(date +%F_%H-%M-%S).ucs"

# Log the start of the backup process
logger -p local0.info "System backup started on $HOSTNAME"

# Save the system configuration
tmsh save sys config

# Save the system UCS file
tmsh save sys ucs $UCS_FILENAME

# Check if the UCS save was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to save UCS file"
  exit 1
fi

echo "Backup successful: $UCS_FILENAME"

# Mount the NFS share
sudo mount -t nfs ${NFS_SERVER}:${NFS_PATH} ${MOUNT_POINT}

# Check if the mount was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to mount NFS share"
  exit 1
fi

# Copy the file to the NFS mount point
cp ${UCS_FILENAME} ${MOUNT_POINT}/${UPLOAD_FILE_NAME}

# Check if the copy was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to copy file to NFS share"
  sudo umount ${MOUNT_POINT}
  exit 1
fi

# Count the number of files in the NFS directory
FILE_COUNT=$(ls -1 ${MOUNT_POINT} | wc -l)

# If there are more than 3 files, delete the oldest ones
if [[ ${FILE_COUNT} -gt 3 ]]; then
  # Find and delete the oldest files
  ls -t ${MOUNT_POINT} | tail -n +4 | xargs -I {} rm -f ${MOUNT_POINT}/{}
fi

# Unmount the NFS share
sudo umount ${MOUNT_POINT}

# Check if the unmount was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to unmount NFS share"
  exit 1
fi

echo "Script completed successfully"
