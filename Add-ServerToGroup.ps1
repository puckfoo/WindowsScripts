$before = Get-ADGroupMember -Identity $group | Select -ExpandProperty SamAccountName
$output = @()
$computers = Get-ADComputer -Filter "OperatingSystem -like 'Windows Server*'" -Properties *  
$group = "servercert"


#Creating custom object

try{

    foreach ($computer in $computers){
        $obj = [PSCustomObject]@{
            SamAccountName = $computer.SamAccountName
            OperatingSystem = $computer.OperatingSystem
        }

        $output += $obj
     }

    $results = $output | Select -ExpandProperty SamAccountName
 
 }
 catch{

    $ErrorMessage = $_Exception.Message
    Write-Host $ErrorMessage -ForegroundColor Yellow

 }



 #Add computer to group using the computers SamAccountName

 foreach ($result in $results) {
    
     
    Add-ADGroupMember -Identity $group -Members $result
    Write-Host "Adding $result to $group"
}


#Compare the number of servers before and after
 
$after = Get-ADGroupMember -Identity $group | Select -ExpandProperty SamAccountName


try{

$diff = compare -ReferenceObject $before -DifferenceObject $after -ErrorAction stop
$diff

}

catch{

    $ErrorMessage = $_Exception.Message
    Write-Host $ErrorMessage -ForegroundColor Yellow

}





