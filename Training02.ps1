$variableOne = "1"
$variableTwo = "3"
$textVariable = $true

($variableOne -eq $variableTwo) ? $true : $false
($variableOne -eq $variableTwo) ?
        ("$variableOne > $variableTwo ") : ("$variableOne < $variableTwo ")


($textVariable) ? "Vaule is true" : "Value is false"


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
Do { $number; $number++} While($number -le 10)

<#
The Do-While loop is almost the same as a regular Loop
    it executes the block of statements while the condition returns true
    Do-while executes first; then, the condition test is at the end of the loop
#>

#Base Syntax
$number = 1
Do { $number; $number++} While ($number -le 20)

<#

While Loop
a. Entry Controlled Loop
b. Tests the condition before the exection of the first interation
c. Loop doesn't execute when the conition evaluates too false.
d. It does not require any other syntax


Do-While Loop
a. Exit Controlled loop
b. Tests the condition after the exectuion of the first iteration
c. Loop executes at least once even if the condition evaluates too false
d. Use the DO keyword at the starting of the loop, and the while keyword with the condition at the end of the loop


Do-Unil Loop
a. Do-until loops use similar syntax to Do-While loops
b. The loop repeats until the condition returns true
c. They are the opposite of Do-While loops

#>

#Base Syntax
$number = 1
Do { $number; $number++ } Until ($number -le 10) 

<#
Do-While and Do-Unil Loop Differences

Do-While Loop
a. Exit Controlled Loop
b. Uses the While keyword for the condition
c. Executes while the condition returns true

Do-Until Loop
a. Exit Controlled Loop
b. Uses the Until keyword for the condition
c. Continues execution until the condition returns true

#>

$number = 1
Do { $number; $number++} While ($number -le 10)


Do { $number; $number++} Until($number -gt 10)


Do { $number; $number++} Until($number -le 10) # endless loop