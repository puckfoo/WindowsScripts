Function Get-ServerInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ServerName,
        [Parameter(Mandatory = $true)]
        [Validateset("domain01”,“domain02”,“domain02")]
        [string]$Domain
    )

    try
    {
  
     Get-ADObject -Filter {(ObjectClass -eq "Computer")} -Properties * -Server $Domain | Where {$_.Name -eq $ServerName } -Verbose | ft Name,OperatingSystem,DNSHostName -AutoSize

    }
    catch [System.Management.Automation.CommandNotFoundException]
    {

        if ($Error[0].FullyQualifiedErrorId) {
            Write-Warning "Be sure the Admin tools are install, otherwise known as rsat"    #Checking for admin tools installation
        }

    }
    catch [System.Security.Authentication.AuthenticationException]
    {

        if ($Error[0].FullyQualifiedErrorId) {
            Write-Warning "Incorrect domain credentials"                                     #Checking for correct domain credentials
        }

    }
    finally
    {

        $ErrorMessage = $_.Error.Message                                                     #Catch all
        Write-Host $ErrorMessage -ForegroundColor Yellow

    }

}


