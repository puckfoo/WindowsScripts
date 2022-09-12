Start-Transcript -Path "D:\Misc\DCPromo.txt" -NoClobber
Get-Date
Get-WindowsFeature | Where-Object Installed | Format-Table Name
Install-WindowsFeature –Name AD-Domain-Services -IncludeManagementTools
Get-ADDomainController -Filter * | Format-Table Name, Site, IPv4Address -AutoSize
Import-Module ADDSDeployment

Install-ADDSDomainController `
  -NoGlobalCatalog:$false `
  -CreateDnsDelegation:$false `
  -CriticalReplicationOnly:$false `
  -DatabasePath "E:\NTDS" `
  -DomainName "mummra.net" `   #change domain
  -InstallDns:$false `
  -LogPath "F:\NTDS" `
  -NoRebootOnCompletion:$false `
  -SysvolPath "E:\SYSVOL" `
  -Confirm:$false `
  -SafeModeAdministratorPassword `
   (ConvertTo-SecureString 'u4I0HrfE' -AsPlainText -Force) 
