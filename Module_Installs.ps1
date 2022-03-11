Install-Module -Name AzureAD -Scope AllUsers


Install-Module -Name MSOnline -Scope AllUsers


Install-Module -Name AWS.Tools.Common


Install-Module -Name MicrosoftTeams


Install-Module -Name Microsoft.Graph


Connect-MsolService


Connect-AzureAD


Connect-MgGraph


Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"



#Disable Directory Sync
Set-MsolDirSyncEnabled -EnableDirSync $false
(Get-MSOLCompanyInformation).DirectorySynchronizationEnabled

#Now manually delete the accounts


#remove synced accounts from o365 AD
Remove-MsolUser -UserPrincipalName Sync_DC01_b2d643bd53b6@puckfoo.onmicrosoft.com


#re-enable directory sync
Set-MsolDirSyncEnabled -EnableDirSync $true
