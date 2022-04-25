Function Get-GC {
    [CmdletBinding()]
    $LocalSite = (Get-ADDomainController -Discover).Site
    $NewTargetGC = Get-ADDomainController -Discover -Service 6 -SiteName $LocalSite
    $NewTargetGCHostName = $NewTargetGC.HostName
    $DC = "$NewTargetGCHostName" + ":" + "3268"

    return $DC

}






Function Search-ADGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SecurityGroup
    )

    $SecGroup = Get-ADGroup -Filter 'groupcategory -eq "security"' | Where-Object {$_.Name -like "*$SecurityGroup*"} | fl SamAccountName
    return $SecGroup 
}


Search-ADGroup 'servercert'






Function Get-ADGroupMembership {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SecurityGroup
    )

    try
    {
        $GetSecGroup = Get-ADObject -Filter {(ObjectClass -eq "group") -and (SamAccountName -eq $SecurityGroup)} -Properties SamAccountName, DistinguishedName
        $SecGroup = ($GetSecGroup).SamAccountName
        $GroupMemberShip = (Get-ADGroupMember -Identity $SecurityGroup -Recursive).SamAccountName
        return $GroupMemberShip
    }
    catch [Microsoft.ActiveDirectory.Managment.ADException]
    {
        
        if ($Error[0].FullyQualifiedErrorId) {
            Write-Warning "An account exists in $SecGroup from another forest and is no longer accessible.  Please remove the accounts, and try again"

        }
    }
}

Get-ADGroupMembership servercert











Function Add-UsersToADGroup {
  [CmdletBinding(DefaultParameterSetName = 'UserNames')]
    param (
        [Parameter(Mandatory = $true,
        ParameterSetName = "UserNames")]
        [string[]]$UserNames,
        [Parameter(Mandatory = $true,
        ParameterSetName = "Path")]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SecurityGroup
    )

    $dc = Get-UGC

    try 
    {
        $GetSecGroup = Get-ADObject -Filter {(ObjectClass -eq "group") -and (SamAccountName -eq $SecurityGroup)} -Properties SamAccountName, DistinguishedName
        $SecGroup = ($GetSecGroup).SamAccountName
        $GroupMemberShip = (Get-ADGroupMember -Identity $SecGroup -Recursive).SamAccountName
    }

    catch [Microsoft.ActiveDirectory.Management.ADException]
    {
        if ($Error[0].FullyQualifiedErrorID) {
            Write-Warning "An account exists in $SecGroup from another forest and is no longer accessible.  Please remove the accounts, and try again"
        }
    }


      if ($UserNames) {
        foreach ($User in $UserNames) {
            $User = Get-ADUser -Identity $User -Server $dc
            $SamAccountName = $User.SamAccountName

            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Add @{member = $user.DistinguishedName }
            } 
        }
    } Else {
        $csv = Import-Csv $Path
        foreach ($record in $csv) {
            $ID = $record.SamAccountName
            $User = Get-ADUser -Identity $id -Server $dc
            $SamAccountName = $user.SamAccountName
            
            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "$SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Add @{member = $user.DistinguishedName}
            }  
        }
    }
}



Add-UsersToADGroup -UserNames bbaggins -SecurityGroup test







Function Remove-UsersFromADGroup {
    [CmdletBinding(DefaultParameterSetName = 'UserNames')]
    param (
        [Parameter(Mandatory = $true,
        ParameterSetName = "UserNames")]
        [string[]]$UserNames,
        [Parameter(Mandatory = $true,
        ParameterSetName = "Path")]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SecurityGroup
    )


    $dc = Get-GC

    $GetSecGroup = Get-ADObject -Filter {(ObjectClass -eq "group") -and (SamAccountName -eq $SecurityGroup)} -Properties SamAccountName, DistinguishedName
    $SecGroup = ($GetSecGroup).SamAccountName
    $GroupMemberShip = (Get-ADGroupMember -Identity $SecGroup -Recursive).SamAccountName



    if ($UserNames) {
        foreach ($User in $UserNames) {
            $User = Get-ADUser -Identity $User -Server $dc
            $SamAccountName = $User.SamAccountName

            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Remove @{member = $user.DistinguishedName }
            } 
        }
    } Else {
        $csv = Import-Csv $Path
        foreach ($record in $csv) {
            $ID = $record.SamAccountName
            $User = Get-ADUser -Identity $id -Server $dc
            $SamAccountName = $user.SamAccountName
            
            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "$SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Remove @{member = $user.DistinguishedName}
            }  
        }
    }
}



Remove-UsersFromADGroup -UserNames bbaggins -SecurityGroup test








Function Get-ADUserGroupMembership {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$User
    )


    try
    {
        Get-ADPrincipalGroupMembership -Identity $user | Select-Object name
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        Write-Host $ErrorMessage -ForegroundColor Yellow
    }
}


Get-ADUserGroupMembership -User 








Function Add-UsersToDistributionGroup {
  [CmdletBinding(DefaultParameterSetName = 'UserNames')]
    param (
        [Parameter(Mandatory = $true,
        ParameterSetName = "UserNames")]
        [string[]]$UserNames,
        [Parameter(Mandatory = $true,
        ParameterSetName = "Path")]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$DistributionGroup
    )

    $dc = Get-GC

    try 
    {
        $GetDistributionGroup = Get-DistributionGroup -Filter {PrimarySmtpAddress -eq "}
        $SecGroup = ($GetSecGroup).SamAccountName
        $GroupMemberShip = (Get-ADGroupMember -Identity $SecGroup -Recursive).SamAccountName
    }

    catch [Microsoft.ActiveDirectory.Management.ADException]
    {
        if ($Error[0].FullyQualifiedErrorID) {
            Write-Warning "An account exists in $SecGroup from another forest and is no longer accessible.  Please remove the accounts, and try again"
        }
    }


      if ($UserNames) {
        foreach ($User in $UserNames) {
            $User = Get-ADUser -Identity $User -Server $dc
            $SamAccountName = $User.SamAccountName

            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Add @{member = $user.DistinguishedName }
            } 
        }
    } Else {
        $csv = Import-Csv $Path
        foreach ($record in $csv) {
            $ID = $record.SamAccountName
            $User = Get-ADUser -Identity $id -Server $dc
            $SamAccountName = $user.SamAccountName
            
            if ($GroupMemberShip -notcontains $SamAccountName) {
                Write-Host "$SamAccountName isn't a member of $SecGroup" -ForegroundColor Yellow
            } Else {
                Write-Host "Removing $SamAccountName from security group $SecGroup" -ForegroundColor Yellow
                Set-ADObject -Identity $GetSecGroup -Add @{member = $user.DistinguishedName}
            }  
        }
    }
}