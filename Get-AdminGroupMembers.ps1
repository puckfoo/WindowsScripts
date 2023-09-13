 
# This Defines the list of Domains to query
$DomainList = @('CORP','UMB'),
# This Defines the list of Groups to get the accounts from
#$GroupList = @('Domain Admins','DS Server Admins','InfoSec Server Admins','Desktop Admins')


$GroupList = Get-Content -Path "C:\Users\rxh031\OneDrive - UMB\Documents\JDClark.txt"
        
        


    #Loop through the groups by Domain first and then the group - Outputs to File based on the domain and name of group with date.

    ForEach($Domain in $DomainList){
    
        ForEach($Group in $GroupList){
        
            $UserFileName = "Users_" + $Domain + "_" + $Group + "_" + $(get-date -f MMddyyyy) + ".CSV"
            $GroupFileName = "Groups_" + $Domain + "_" + $Group + "_" + $(get-date -f MMddyyyy) + ".CSV"

            # Gets the Members of the Group

            $PrimaryList = Get-ADGroupMember $Group -Server $Domain
        
            # Sorts through the list of members and splits by User or Group
        
                ForEach($Member in $PrimaryList){

            # Determines if User or Group.  If Group then it gets the members on the sub group and adds them to the output file.

                    If($Member.objectClass -eq "user"){
                        $Member | Get-ADUser | Select GivenName, Surname, SamAccountName, Enabled, UserPrincipalname, DistinguishedName, @{Name="Group";Expression={$Group}}, @{Name="Group Domain";Expression={$Domain}} | Export-Csv c:\test\$UserFileName -Append -NoTypeInformation
                        Write-host $Member.name, "User"}

                    If($Member.objectClass -eq "group"){
                        $Member | Select Name, SamAccountName, DistinguishedName, objectClass, objectGUID | Export-Csv c:\test\$GroupFileName -Append -NoTypeInformation
                        Write-host $Member.name, "group"

                            $Subdomain = "Corp"
                        
                            If($Member.DistinguishedName -match "DC=UMB,DC=CORP"){
                                $Subdomain = "UMB"

                                $SubGroup = Get-ADGroupMember $($Member.SamAccountName) -Server $Subdomain

                                    ForEach($SubMember in $SubGroup){

                                        If($SubMember.objectClass -eq "user"){
                                            $SubMember | Get-ADUser | Select GivenName, Surname, SamAccountName, Enabled, UserPrincipalname, DistinguishedName, @{Name="Group";Expression={$Member.SamAccountName}}, @{Name="Group Domain";Expression={$SubDomain}} | Export-Csv c:\test\$UserFileName -Append -NoTypeInformation
                                            Write-host $SubMember.name, "Sub-User" }

                                        If($SubMember.objectClass -eq "group"){
                                        
                                            $Subdomain1 = "Corp"
                        
                                            If($SubMember.DistinguishedName -match "DC=UMB,DC=CORP"){
                                                $Subdomain1 = "UMB"

                                                $SubGroup1 = Get-ADGroupMember $($SubMember.SamAccountName) -Server $Subdomain1
                                            
                                                ForEach($SubMember1 in $SubGroup1){
                                            
                                                If($SubMember1.objectClass -eq "user"){
                                                    $SubMember1 | Get-ADUser | Select GivenName, Surname, SamAccountName, Enabled, UserPrincipalname, DistinguishedName, @{Name="Group";Expression={$SubMember.SamAccountName}}, @{Name="Group Domain";Expression={$SubDomain1}} | Export-Csv c:\test\$UserFileName -Append -NoTypeInformation
                                                    Write-host $SubMember1.name, "Sub-Sub-User"}
                                                
                                                 If($SubMember1.objectClass -eq "group"){
                                                    Write-host $Submember1.Name, "More Groups!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"}   

                                    }
                                    
 }}}}}}}}


