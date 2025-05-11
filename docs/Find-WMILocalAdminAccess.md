# Find-WMILocalAdminAccess.ps1

**Find-WMILocalAdminAccess.ps1** is a PowerShell script that helps you check local administrative access to multiple remote computers in your network. It uses WMI (Windows Management Instrumentation) to attempt to access each target computer and reports on the availability of local admin access, network connectivity issues, and other related problems.

This script was created as a more reliable and functional alternative to the script found [here](https://github.com/admin0987654321/admin1/blob/master/Find-WMILocalAdminAccess.ps1), which was not working as expected. If you're facing issues with the original script, this version addresses several bugs and offers improved error handling.

## Features:
- Checks the availability of computers using ICMP (ping).
- Attempts to verify local admin access using WMI.
- Supports both individual and batch checking (via file or Active Directory).
- Handles errors such as "Access Denied" and "RPC Server Unavailable."
- Provides a clean and easy-to-read summary of results.
- Option to stop execution after the first successful local admin access is found.

## Table of Contents:
1. [Prerequisites](#prerequisites)
2. [How to Use](#how-to-use)
3. [Script Parameters](#script-parameters)
4. [Example Usage](#example-usage)
5. [Output](#output)
6. [Notes](#notes)

## Prerequisites:
- Windows PowerShell 5.1 or higher.
- Access to remote computers for WMI queries (make sure appropriate firewall ports are open and WMI is enabled).
- The script assumes you have permission to query remote computers and check local admin access.

## How to Use:
### 1. Load Script:

```
. .\Find-WMILocalAdminAccess.md
```

### 2. Run the Script:
You can run the script on a single computer, a list of computers, or all computers in Active Directory.


### Check a Single Computer:

* Edit
```
Find-WMILocalAdminAccess -ComputerName "Computer1"
```

* Check Computers from a File:
Create a text file with one computer name per line, then run:

```
Find-WMILocalAdminAccess -ComputerFile "C:\computers.txt"
```

### Check All Computers in Active Directory
To check all computers in Active Directory, simply run the script with no parameters:

```
Find-WMILocalAdminAccess
```

### Stop After First Success
If you want to stop the script after the first success (i.e., a computer with confirmed local admin access), use the -StopOnSuccess switch:

```
Find-WMILocalAdminAccess -ComputerFile "C:\computers.txt" -StopOnSuccess
```

### Script Parameters
- **ComputerName** (optional) - The name of a single computer to check.  
  Example: "Computer1"

- **ComputerFile** (optional) - Path to a file containing a list of computer names (one per line).  
  Example: "C:\computers.txt"

- **StopOnSuccess** (optional) - Stops execution after the first computer with successful admin access is found.  
  Example: -StopOnSuccess

### Example Usage
- Check a single computer:

```
Find-WMILocalAdminAccess -ComputerName "Computer1"
```

- Check multiple computers from a file:

```
Find-WMILocalAdminAccess -ComputerFile "C:\computers.txt"
```

- Check all Active Directory computers:

```
Find-WMILocalAdminAccess
```

- Stop after the first success:

```
Find-WMILocalAdminAccess -ComputerFile "C:\computers.txt" -StopOnSuccess
```

### Output
The script outputs a table of results for each computer with the following status options:

- **Success**: Local admin access confirmed.
- **Access Denied**: Local admin access is denied (insufficient privileges).
- **Unreachable**: The Computer is unreachable (ping failed).
- **WMI RPC Failure**: WMI/RPC connectivity issue encountered.
- **Other Error**: An unexpected error occurred while accessing the computer.

### Example Output
```
Computer     Status
---------    --------
Computer1    Success
Computer2    Access Denied
Computer3    Unreachable
Computer4    WMI RPC Failure
```

![WhatsApp Image 2025-05-11 at 22 55 36](https://github.com/user-attachments/assets/90dec3b4-2ce1-48c3-bf10-efae1a8270eb)


### Notes
- The script assumes you have sufficient privileges to access remote computers via WMI.
- Ensure that remote computers allow WMI queries and that no firewall or network policy blocks these requests.
- The script requires the remote computers to have WMI enabled and the RPC ports open.
