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


*******************************************************************************************************
<#
Loops:

for - for state and is interated through a specified number of times
while - repeats a commands or group of commands where the given condition is true. 
do-while - the body of the do while is executed first, then the condition is tested at the end
do-until - the condition is evaluated first then the body of the code is run.
foreach-object - 
foreach 

)



#>
