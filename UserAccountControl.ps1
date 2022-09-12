$Obj = [ADSI]"LDAP://cn=dc01,ou=domain controllers,dc=mummra,dc=net"

if ($Obj.UserAccountControl[0] -eq 532480){
    Write-Host "User Account Control 532480"
    }
Else{
   
   $Obj.UserAccountControl[0] -bor 532480

}
