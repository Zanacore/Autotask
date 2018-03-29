#Email Settings
$smtpServer = "zanacore-com.mail.protection.outlook.com"
$smtpFrom = "reports@zanacore.com"
$smtpTo = "Jason@zanacore.com"
$messageSubject = "Autotask Contracts Count Check"

#AT Product Service ID's for Continuum (Get-AtwsService -Name 'Continuum' -BeginsWith Name)
$ATDesktopServiceID = 49,52
$ATServerServiceID = 48,55,58
[int]$TotalServers = "0"
[int]$TotalDesktops = "0"

#Grab todays Date
$Date = Get-date -day 1 -Hour 0 -Minute 00 -Second 00

#Add Autotask Module to PowerShell
Import-Module Autotask
# Enter your username and password to Autotask and Create a connection
$Credential = Get-Credential
Connect-AutotaskWebAPI -Credential $Credential

#Get List of Active Accounts
$Account = Get-AtwsAccount -active $TRUE -AccountType "Customer" | Select ID,AccountName | Sort AccountName
#$Account = Get-AtwsAccount -active $TRUE -AccountType "Customer" -AccountName "star*" -Like AccountName | Select ID,AccountName | Sort AccountName

Write-Host –NoNewLine 'Processing... '
[System.Collections.ArrayList]$Results = @()

#Step through each Account
foreach ($i in $Account)
{
    Write-Host $i.AccountName", " -NoNewline
	#Get List of NetGuard Contracts
	$Contracts = Get-AtwsContract -AccountId $i.Id -ContractCategory NetGuard,NetShield,NetWatch -Status 'Active'
    	
	#Get a list of Services on Contract and compare to config items
	foreach($s in $Contracts)
	{
        #Get number of Desktops & Servers under contract this month
		$ContractDesktops = (Get-AtwsContractServiceUnit -ContractID $s.ID -Serviceid $ATDesktopServiceID -StartDate $Date.AddMonths(-1) -EndDate $Date.AddMonths(1) -GreaterThan StartDate -LessThan EndDate | Select Units).Units
        $ContractDesktops = ($ContractDesktops)
        $ContractServers = (Get-AtwsContractServiceUnit -ContractID $s.ID -Serviceid $ATServerServiceID -StartDate $Date.AddMonths(-1) -EndDate $Date.AddMonths(1) -GreaterThan StartDate -LessThan EndDate | Select Units).Units
        $ContractServers = ($ContractServers)
        $CurrentDesktops = (Get-AtwsInstalledProduct -Type "Windows Desktop" -Active $true -account $i.id).count
        $CurrentServers = (Get-AtwsInstalledProduct -Type "Windows Server" -Active $true -account $i.id).count
        $SaveObj = $false
        $TotalServers += $CurrentServers
        $TotalDesktops = $TotalDesktops + $CurrentDesktops

        #Make sure Contract has Desktops on it
        If ($ContractDesktops) {
            #Check to see if Desktops Match
            If ($ContractDesktops -eq $CurrentDesktops) {
                #Write-Host $i.AccountName 'Desktops Correct'
                } Else {
                $SaveObj = $TRUE
            }
        }
        #Make sure Contract has Servers on it
        If ($ContractServers) {
            #Check to see if Servers Match
            If ($ContractServers -eq $CurrentServers) {
                #Write-Host $i.AccountName 'Servers Correct'
                } Else {
                $SaveObj = $TRUE
            }
        }

        #If data has changed, Lets save it
        If ($SaveObj -eq $TRUE) {
            $Data = [PSCustomObject]@{
    		    AccountName = $i.AccountName
                ContractDesktops = ($ContractDesktops[-1]) # | Measure-Object -sum).sum
                CurrentDekstops = $CurrentDesktops
                ContractServers = ($ContractServers[-1]) #  | Measure-Object -sum).sum
                CurrentServers = $CurrentServers
            }
            #Add Data to our Results Array
            $Results.Add($Data) | Out-Null
        }
	}
}

#Add Totals Row
$Data = [PSCustomObject]@{
    AccountName = "Totals"
    ContractDesktops = ""
    CurrentDekstops = $TotalDesktops
    ContractServers = ""
    CurrentServers = $TotalServers
}
#Add Data to our Results Array
$Results.Add($Data) | Out-Null

Write-Host ""
$Results | Format-Table

#Send Results in Email
$style = "<style>BODY{font-family: Arial; font-size: 10pt;}"
$style = $style + "TABLE{border: 1px solid black; border-collapse: collapse;}"
$style = $style + "TH{border: 1px solid black; background: #dddddd; padding: 5px; }"
$style = $style + "TD{border: 1px solid black; padding: 5px; }"
$style = $style + "</style>"
$message = New-Object System.Net.Mail.MailMessage $smtpfrom, $smtpto
$message.Subject = $messageSubject
$message.IsBodyHTML = $true
$message.Body = $Results | ConvertTo-Html -Head $style
$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($message)