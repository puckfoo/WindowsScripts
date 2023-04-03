<#
Switch Statements

Alternate syntax for doing multiple comparisons with a value

Results of an expression get compared with several different values

Switch Statement Rules:

1. The default statement is optional

2. The test expression can be a logical or an integer expression 

3. Break statements will terminate the current code execution 

Switch Statement Components

1. The inital test expression
2. Conditions to match

#Base Syntax
Switch (<expression>) {
    <condition1> { <code> }
    <condition2> { <code> }
    <condition3> { <code> }
}

#>


#Variable
$number = 3

#Example Syntax
Switch ($number) {
    5 {Write-Host "Number equals 5"}
    10 {Write-Host "Number equals 10"}
    20 {Write-Host "Number equals 20"}
    Default {Write-Host "Number is not equal to 5, 10, or 20"}




}

