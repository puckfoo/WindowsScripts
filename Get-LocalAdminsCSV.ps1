$date = Get-Date
$csv = Import-Csv "C:\temp\File.csv"
$output = "c:\temp\file01.put.csv"
$server = server.domain.com:3268 



foreach ($item in $csv) {
    $servername = $item.servername
    $element = $item.accounts
    $linesplit = $element.split("\")
    $domain = $linesplit[0]
    $account = $linesplit[1]

     if ($domain -eq 'domain1'){
        $dc = 'domain1'
    }
    elseif($domain -eq 'domain1'){
        $dc = 'domain2'
    }


      
    try{
        
        $GetSecGroup = Get-ADObject -filter {(ObjectClass -eq 'group') -and (Name -eq $account)} -Properties SamAccountName, DistinguishedName -Server $dc -ErrorAction Stop
        $SecGroup = ($GetSecGroup).SamAccountName
        $GroupMemberShip = (Get-ADGroupMember -Identity $SecGroup -Recursive -Server $dc).DistinguishedName 
           
        foreach ($obj in $GroupMemberShip){
            Get-ADUser -Identity $obj -Properties * -Server $server | Select GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$SecGroup}}, @{Name="ServerName";Expression={$ServerName}}, @{Name="Date";Expression={$date}} | Export-Csv $output -Append -NoTypeInformation   
            Write-Host "Working $obj"
        }
    }
    catch [System.Management.Automation.RuntimeException]{
        if ($Error[0].FullyQualifiedErrorId){
            Write-Host "The account $obj is not a group so it errors out" -ForegroundColor Yellow
            #$error[0] | fl -Property * -force   #Checking error content
        }
    }


    try{
            
        if (Get-ADObject -filter {(ObjectClass -eq 'user') -and (Name -eq $account)} -Server $server){
            $userobj = Get-ADUser -Identity $account -Server $server
            $userdn = $userobj.DistinguishedName
        
            foreach ($userobj in $userdn){
                Get-ADUser -Identity $userobj -Properties * -Server $server | Select-Object GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$Null}}, @{Name="ServerName";Expression={$ServerName}}, @{Name="Date";Expression={$date}} | Export-Csv $output -Append -NoTypeInformation
                Write-Host "Working $userobj"
            }
        }
    }
    catch [System.Management.Automation.RuntimeException]{
        if ($Error[0].FullyQualifiedErrorId){
            Write-Host "The account $userobj is not a group so it errors out" -ForegroundColor Yellow
            #$error[0] | fl -Property * -force   #Checking error content
        }   
    }  
    
    #This is only useful for two accounts gwb001, and sndiscoverywsvc because they are on every server.  This was done because I'm unable to access the local servers via powershell.
     try{
        $localelement = Get-LocalUser -Name $element -ErrorAction Stop
        $localname = ($localelement).Name
        $localsource = ($localelement).PrincipalSource

        if ($localsource -eq "Local"){
            $localaccount = Get-LocalUser -Name $localname -ErrorAction Stop
            $localaccount | Select-Object GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$Null}}, @{Name="ServerName";Expression={$ServerName}}, @{Name="Date";Expression={$date}} | Export-Csv $output -Append -NoTypeInformation
            Write-Host "Working $localaccount" 
        }
    }
    catch [System.Management.Automation.RuntimeException]{
        if ($Error[0].FullyQualifiedErrorId){
            Write-Host "The account $element is not a local machine account" -ForegroundColor Yellow
            #$error[0] | fl -Property * -force   #Checking error content
        }   
    }
}