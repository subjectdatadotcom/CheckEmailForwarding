<#
.SYNOPSIS
This script checks if mail forwarding is enabled for a list of users and provides details of their forwarding settings.

.DESCRIPTION
The script ensures that the Exchange Online Management module is installed and imported. It reads a list of user email addresses from a CSV file, connects to Exchange Online, and checks if mail forwarding, including SMTP forwarding, is enabled for each user. It displays whether forwarding is set or not for each user’s mailbox, along with the primary and forwarding SMTP addresses.

.NOTES
The script requires an account with Exchange Online Administrator permissions for authentication and access to user mailboxes. Ensure the CSV file 'EmailForwardingUsers.csv' contains a list of users with a column named 'Email'.

.AUTHOR
SubjectData

.EXAMPLE
.\CheckEmailForwarding.ps1
This will run the script in the current directory, processing the 'EmailForwardingUsers.csv' file and checking the mail forwarding settings for each user.
#>

$moduleName = "ExchangeOnlineManagement"

# Check if the module is already installed
if (-not(Get-Module -Name $moduleName)) {
    # Install the module
    Install-Module -Name $moduleName -Force
}

# Import the module
Import-Module ExchangeOnlineManagement -Force

#Connect to Exchange Online
Connect-ExchangeOnline

$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$XLloc = "$myDir\"

#########################################################################################################################

## Make sure to disable mail forwarding including SMTP forwarding address for each user before Mail migration switch

#########################################################################################################################

try
{
    $Emails = import-csv ($XLloc+"EmailForwardingUsers.csv").ToString()
}
catch
{
    Write-Host "No CSV file to read" -BackgroundColor Black -ForegroundColor Red
    exit
}


foreach ($UserEmail in $Emails)
{
    try
    {
        if($UserEmail.'Email'.ToString() -ne "")
        {
            $MailForwarding = get-mailbox $UserEmail.'Email'.ToString() | Select PrimarySmtpAddress, ForwardingSmtpAddress

            if($MailForwarding.ForwardingSmtpAddress -ne $null)
            {
                Write-Host $UserEmail.'Email' "forwarding is set" $MailForwarding.PrimarySmtpAddress $MailForwarding.ForwardingSmtpAddress -BackgroundColor white -ForegroundColor Blue
            }
            else
            {
                Write-Host $UserEmail.'Email' "forwarding is not set" $MailForwarding.PrimarySmtpAddress $MailForwarding.ForwardingSmtpAddress -BackgroundColor Black -ForegroundColor Red
            }
        }
    }
    catch
    {
        Write-Host "Exception occured " $UserEmail.'Email' -BackgroundColor Black -ForegroundColor Red
    }
}