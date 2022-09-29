Function Get-ADGroupMembership {
    [CmdletBinding()]
    param(
        [string]$SecurityGroup,
        [Parameter(Mandatory = $true)]
        [Validateset("domain", "domain", "domain")]
        [string]$dc,
        [string]$path
    )

    $output = @()
    $csv = import-csv -Path $path
    
    foreach ($record in $csv) {
        $server = $record.name
        $securityGroup = $record.group
            
        try
        {
            
           if ((Get-ADGroup $securityGroup -Server $dc -Properties *).GroupScope -eq "DomainLocal"){
                $groupMemberShip = Get-ADGroup $securityGroup -Server $dc -Properties * | Get-ADGroupMember -Recursive   
        }

            Elseif ((Get-ADGroup -Identity $securityGroup).objectclass -eq "group") {    
                $getSecGroup = Get-ADObject -Filter {(ObjectClass -eq "group") -and (SamAccountName -eq $securityGroup)} -Properties SamAccountName -Server $dc
                $secGroup = ($GetSecGroup).SamAccountName
                $groupMemberShip = (Get-ADGroupMember -Identity $securityGroup -Recursive).SamAccountName 
        }

            Elseif ((Get-ADUser -Identity $SecurityGroup -Server $dc).objectClass -eq "user"){
                Write-Host "$SecurityGroup is a user account" 
        }

            foreach ($member in $groupMemberShip) {
                $user = Get-ADUser -Identity $member
    
                $obj = [PSCustomObject]@{
                            Server = $Server
                            SecurityGroup = $securityGroup
                            SamAccountName = $user.SamAccountName
                            FirstName = $user.GivenName
                            LastName = $user.SurName 
                            Date = Get-Date   
                }

                $output += $obj
            }

            $results = $output
        }
        catch
        {
        
            $ErrorMessage = $_.Exception.Message
            Write-Host $ErrorMessage -ForegroundColor Yellow
            $ErrorMessage | Out-File "C:\Users\rxh031\Desktop\Audit\file01.txt" -Append

            }
        }

   $results | export-csv -Path "C:\Users\rxh031\Desktop\Audit\file01.csv" -NoTypeInformation -Append
}



Get-ADGroupMembership -dc domain -path "C:\Users\rxh031\Desktop\Audit\Local Admins.csv"


