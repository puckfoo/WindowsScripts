Get-Module -ListAvailable | Where HelpInfoUri | Update-Help

Update-Help -Force -Verbose -ErrorAction SilentlyContinue