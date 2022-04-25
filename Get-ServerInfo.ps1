function Get-ServerInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ServerName,
        [Parameter(Mandatory = $true)]
        [Validateset("domain01.com","domain02.com")]
        [string]$Domain
    )
    
    Get-ADObject -Filter {(ObjectClass -eq "Computer")} -Properties * -Server $Domain | Where-Object {$_.Name -eq $ServerName} | Format-Table Name, OperatingSystem, DNSHostName -AutoSize

}


Get-ServerInfo -ServerName Server01 -Domain domain01.com
