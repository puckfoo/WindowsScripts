$array = 1..10
$compare = 6

if(($compare -in $array) -or ($compare -gt 8)) {Write-Host "Yes"} else {Write-Host "No"}