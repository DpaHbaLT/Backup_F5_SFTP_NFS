
# NFS File Upload Script

This script mounts an NFS share, copies a specified local file to the NFS share, and ensures that no more than three files are present in the NFS directory by deleting the oldest files if necessary. The script will then unmount the NFS share.

## Prerequisites

- Ensure you have NFS utilities installed on your system.
- You need appropriate permissions to mount and unmount NFS shares and to copy files to the NFS share.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. Open the script file `nfs_upload.sh` and update the variables with your specific configuration:

    ```bash
    # Variables
    NFS_SERVER="your_nfs_server"        # Replace with your NFS server address
    NFS_PATH="/path/on/nfs"             # Replace with the path on your NFS server
    MOUNT_POINT="/mnt/nfs"              # Replace with the local mount point
    LOCAL_FILE="path/to/local/file"     # Replace with the path to your local file
    ```

3. Make the script executable:

    ```bash
    chmod +x nfs_upload.sh
    ```

4. Run the script:

    ```bash
    ./nfs_upload.sh
    ```

## Script Description

- **Mount the NFS Share:**

  The script mounts the NFS share specified by the `NFS_SERVER` and `NFS_PATH` variables to the local directory specified by the `MOUNT_POINT` variable.

- **Copy the Local File:**

  The script copies the local file specified by the `LOCAL_FILE` variable to the NFS mount point, maintaining the same file name.

- **Manage File Count:**

  The script checks the number of files in the NFS directory. If there are more than three files, it deletes the oldest files, keeping only the three most recent ones.

- **Unmount the NFS Share:**

  The script unmounts the NFS share.

## Example

Here is an example of how to configure the script:

```bash
# Variables
NFS_SERVER="192.168.1.100"               # Your NFS server IP address
NFS_PATH="/exports/shared"               # The NFS export path
MOUNT_POINT="/mnt/nfs"                   # Local mount point
LOCAL_FILE="/home/user/myfile.txt"       # Path to the local file
