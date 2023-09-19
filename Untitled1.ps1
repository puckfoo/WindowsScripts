
$date = Get-Date
$output = "c:\temp\fileoutput.csv"
$servers = Get-Content -path "C:\Temp\file.txt"
$gc = "dc01.mummra.net:3268" 
# winrm enumerate winrm/config/listener


foreach ($server in $servers) {
    
    $accounts = Invoke-Command -ComputerName $server -UseSSL -ScriptBlock {Get-LocalGroup 'Administrators' | Get-LocalGroupMember}

  
    foreach ($item in $accounts) {
        $objname = $item.name
        $linesplit = $objname.split("\")
        $domain = $linesplit[0]
        $account = $linesplit[1]

        if ($domain -eq 'mummra'){
            $dc = 'mummra'
        }
        elseif($domain -eq 'trek'){
            $dc = 'trek'
        }


           
        try{
        
            $GetSecGroup = Get-ADObject -filter {(ObjectClass -eq 'group') -and (Name -eq $account)} -Properties SamAccountName, DistinguishedName -Server $dc -ErrorAction Stop
            $SecGroup = ($GetSecGroup).SamAccountName
            $GroupMemberShip = (Get-ADGroupMember -Identity $SecGroup -Recursive -Server $dc).DistinguishedName 
           
            foreach ($obj in $GroupMemberShip){
                Get-ADUser -Identity $obj -Properties * -Server $gc | Select GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$SecGroup}}, @{Name="ServerName";Expression={$Server}}, @{Name="Date";Expression={$date}} #| Export-Csv $output -Append -NoTypeInformation   
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
            
            if (Get-ADObject -filter {(ObjectClass -eq 'user') -and (Name -eq $account)} -Server $gc){
                $userobj = Get-ADUser -Identity $account -Server $gc
                $userdn = $userobj.DistinguishedName
        
                foreach ($userobj in $userdn){
                    Get-ADUser -Identity $userobj -Properties * -Server $gc | Select GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$Null}}, @{Name="ServerName";Expression={$Server}}, @{Name="Date";Expression={$date}} #| Export-Csv $output -Append -NoTypeInformation
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

        
          
        try{
            $localacct = Invoke-Command -ComputerName "$server" -UseSSL -ScriptBlock {Get-LocalUser -Name $Using:account -ErrorAction Stop} 
            $localname = ($localacct).Name
            $localsource = ($localacct).PrincipalSource

            if ($localsource -eq "Local"){
                $localaccount = Invoke-Command -ComputerName $server -UseSSL -ScriptBlock {Get-LocalUser -Name $Using:localname -ErrorAction Stop}
                $localaccount | Select GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$Null}}, @{Name="ServerName";Expression={$Server}}, @{Name="Date";Expression={$date}} #| Export-Csv $output -Append -NoTypeInformation
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
}
