# SFTP File Upload Script with Expect

This script uses the Expect tool to automate the process of uploading a file from a local machine to a remote server using SFTP.

## Prerequisites

- Ensure you have Expect installed on your system.
  - On Debian-based systems, you can install it with: `sudo apt-get install expect`
  - On Red Hat-based systems, you can install it with: `sudo yum install expect`
- Ensure you have SFTP access to the remote server.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. Open the script file `sftp_upload.sh` and update the variables with your specific configuration:

    ```tcl
    # Variables
    set remotehost "remote_host"             # Replace with your remote host address
    set username "your_username"             # Replace with your username
    set local_file_path "/path/to/your/local/file.txt"    # Replace with the path to your local file
    set remote_file_path "/path/to/your/remote/file.txt"  # Replace with the path on the remote server
    ```

3. Make the script executable:

    ```bash
    chmod +x sftp_upload.sh
    ```

4. Run the script, providing your password as an argument:

    ```bash
    ./sftp_upload.sh your_password
    ```

## Script Description

- **Start SFTP Session:**

  The script initiates an SFTP session to the remote host specified by the `remotehost` variable using the username specified by the `username` variable.

- **Handle the Authenticity Prompt:**

  If this is the first time connecting to the remote host, the script will handle the authenticity prompt by sending `yes` to continue connecting.

- **Upload the File:**

  The script uploads the local file specified by the `local_file_path` variable to the remote path specified by the `remote_file_path` variable.

- **Close the Connection:**

  The script closes the SFTP session after the file upload is complete.

## Example

Here is an example of how to configure the script:

```tcl
# Variables
set remotehost "example.com"                # Remote host address
set username "user123"                      # Your username
set local_file_path "/home/user/file.txt"   # Path to the local file
set remote_file_path "/remote/path/file.txt" # Path on the remote server

# Usage
./sftp_upload.sh your_password
