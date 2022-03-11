Connect-MsolService -Credential rholland@puckfoo.com


#Disable Directory Sync
Set-MsolDirSyncEnabled -EnableDirSync $false
(Get-MSOLCompanyInformation).DirectorySynchronizationEnabled

#Now manually delete the accounts


#remove synced accounts from o365 AD
Remove-MsolUser -UserPrincipalName Sync_DC01_b2d643bd53b6@puckfoo.onmicrosoft.com


#re-enable directory sync
Set-MsolDirSyncEnabled -EnableDirSync $true
