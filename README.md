# CheckEmailForwarding Script

This PowerShell script processes users from a CSV file and checks their email forwarding settings in Exchange Online. It retrieves and displays the primary and forwarding SMTP addresses for each user.

## Prerequisites

1. **PowerShell**: Ensure you have PowerShell installed.
2. **Exchange Online Management Module**: The script uses the `ExchangeOnlineManagement` module. The script will automatically install it if it's not already installed.

## Instructions

1. **Edit the Script**:
   - Open the script file.
   - Ensure you have a EmailForwardingUsers.csv file in the same directory as the script.
   - Make sure the CSV file (`EmailForwardingUsers.csv`) contains a column with user email addresses:
     ```
     Email
     user1@example.com
     user2@example.com
     ```

2. **Run the Script**:
   - Open PowerShell as an administrator.
   - Navigate to the directory containing the script.
   - Run the script:
     ```powershell
     .\CheckEmailForwarding.ps1
     ```
   - Authenticate using your Exchange Online Administrator account.
   - The script will connect to Exchange Online, process the users, and display forwarding settings for each user.

3. **Check the Output**:
   - The script will output whether mail forwarding is set for each user.

## Troubleshooting

- **No CSV file to read**: Ensure the `EmailForwardingUsers.csv` file is present and correctly formatted.
- **Permission Issues**: Ensure you have the necessary Exchange Online Administrator permissions to check user forwarding settings.
- **Module Installation**: If the script fails to install the `ExchangeOnlineManagement` module, try manually installing it:
  ```powershell
  Install-Module -Name ExchangeOnlineManagement -Force
  
Additional Notes
This script is designed to be run in an environment with access to Exchange Online and requires administrative permissions.
