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

1. for - for state and is interated through a specified number of times
2. while - repeats a commands or group of commands where the given condition is true. 
3. do-while - the body of the do while is executed first, then the condition is tested at the end
4. do-until - the condition is evaluated first then the body of the code is run.
5. foreach-object - command-line loop, iteriates through each object in a collection, and performs operations.
6. foreach "statement" - iteriates through each object in a collection
7. foreach() which is a method - Loop through a collection (or a set of properties) and perform an operation against each.
8. Entry Loop - Test condition is checked before entering the loop
9. Exit Loop - Test condition is checked after executing the loop

#>

***********************************************************************************************************************

#Entry and Exit Loops

#Variable
$number = 1

#Entry Loop - "While Loop"
While ($number -le 10) {$number; $number++}

#Exit Loop - "Do-While Loop"
Do {$number; $number++} While($number -le 10)