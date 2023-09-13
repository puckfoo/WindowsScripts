$AES128 = 0x8
$AES256 = 0X10



#get-adcomputer -properties msDS-SupportedEncryptionTypes -filter *
#get-adcomputer -properties msDS-SupportedEncryptionTypes -filter *
#Get-ADUser -properties msDS-SupportedEncryptionTypes -filter 'SamAccountName -like "rholland"'

$users = get-aduser -Filter * -SearchBase "ou=Users,ou=CompanyOU,dc=mummra,dc=net" -Properties "msDS-SupportedEncryptionTypes"

foreach($user in $users) {
    $encTypes = $User."msDS-SupportedEncryptionTypes"
    try{
    
        Set-Aduser $user -Replace @{"msDS-SupportedEncryptionTypes"=$encTypes -bor $AES128}

    }
    catch{ 

    
        $ErrorMessage = $_.Exception.Message
        Write-Host $ErrorMessage -ForegroundColor Yellow

    }

    Try
    {

        Set-Aduser $user -ADD @{"msDS-SupportedEncryptionTypes"=$encTypes -bor $AES256}

    }
    Catch {


        $ErrorMessage = $_.Exception.Message
        Write-Host $ErrorMessage -ForegroundColor Yellow

        
    }
}





