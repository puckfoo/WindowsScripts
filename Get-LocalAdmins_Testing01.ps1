$date = Get-Date
$csv = Import-Csv "C:\temp\File.csv"
$output = "c:\temp\Output.csv"
$gc = "dc01.mummra.net:3268" 



foreach ($item in $csv) {
    $server = $item.servername
    $element = $item.accounts
    $linesplit = $element.split("\")
    $domain = $linesplit[0]
    $account = $linesplit[1]

    if ($domain -eq 'mummra'){
        $dc = 'mummra'
    }
    elseif($domain -eq 'trek'){
        $dc = 'trek'
    }


        
        $input = Get-ADGroup -Identity $account -server $dc

        if ($input.objectclass -eq 'group'){
              
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
                $ErrorMessage = $_.Exception.Message
                Write-Host $ErrorMessage -ForegroundColor Yellow
                #$error[0] | fl -Property * -force   #Checking error content
                }
            }
        Elseif($input.objectclass -eq 'user'){
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
                $ErrorMessage = $_.Exception.Message
                Write-Host $ErrorMessage -ForegroundColor Yellow
                #$error[0] | fl -Property * -force   #Checking error content
                }   
            }
    
        Elseif($input.objectclass -ne 'group' -or $input.objectclass -ne 'user'){  
    
            try{
                $localelement = Get-LocalUser -Name $element -ErrorAction Stop
                $localname = ($localelement).Name
                $localsource = ($localelement).PrincipalSource

                if ($localsource -eq "Local"){
                    $localaccount = Get-LocalUser -Name $localname -ErrorAction Stop
                    $localaccount | Select GivenName, Surname, Name, SamAccountName, UserPrincipalname, DistinguishedName, Enabled, @{Name="Group";Expression={$Null}}, @{Name="ServerName";Expression={$Server}}, @{Name="Date";Expression={$date}} #| Export-Csv $output -Append -NoTypeInformation
                    Write-Host "Working $localaccount" 
                }
            }
            catch [System.Management.Automation.RuntimeException]{
                $ErrorMessage = $_.Exception.Message
                Write-Host $ErrorMessage -ForegroundColor Yellow
                #$error[0] | fl -Property * -force   #Checking error content
            }  
        }
        Else{
            Write-Host "Account $account can't be found"
        }
}  

