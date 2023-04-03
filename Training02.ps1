$array = 1..10
$compare = 6

if(($compare -in $array) -or ($compare -gt 8)) {Write-Host "Yes"} else {Write-Host "No"}

*******************************************************************************************************

$variable3 = 1
$variable6 = 5

if(($variable3 + $variable6) -gt 4) {Write-Host "Yes"}


*******************************************************************************************************

$variable1 = 1
$variable2 = 3
($variable1 -eq $variable2) ? $true : $false