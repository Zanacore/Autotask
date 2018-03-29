#Add Autotask Module to PowerShell
Import-Module Autotask
# Enter your username and password to Autotask and Create a connection
$Credential = Get-Credential
Connect-AutotaskWebAPI -Credential $Credential

#Get List of ALL Accounts
$Account = Get-AtwsAccount -all | Select ID,AccountName,AccountType,Active | Sort AccountName

Write-Host –NoNewLine 'Processing, This can take a while '
[System.Collections.ArrayList]$Results = @()

#Step through each Account
foreach ($i in $Account)
{
    $Contacts = Get-AtwsContact -AccountID $i.ID | Select FirstName,Lastname,EmailAddress,Active

        foreach ($n in $Contacts) {
            Switch ($i.AccountType) {
                1 {$AccountType = 'Customer'}
                2 {$AccountType = 'Lead'}
                3 {$AccountType = 'Prospect'}
                4 {$AccountType = 'Dead'}
                6 {$AccountType = 'Cancellation'}
                7 {$AccountType = 'Vendor'}
                8 {$AccountType = 'Partner'}
            }
        
            $Data = [PSCustomObject]@{
    		    AccountName = $i.AccountName
                AccountType = $AccountType
                AccountActive = $i.Active
                FirstName = $n.FirstName
                LastName = $n.LastName
                Email = $n.EMailAddress
                ContactActive = $n.Active
                }
            #Add Data to our Results Array
            $Results.Add($Data) | Out-Null
        }
}

Write-Host ""
$Results | Format-Table

#At this point all data is saved to $Results and can be emailed, Displayed, or exported to CSV