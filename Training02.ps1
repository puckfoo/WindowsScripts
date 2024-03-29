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


<#
Switch Statement Syntax
1. Test expression can combine operators
2. Provide support for multiple expression tests
3. Output can be from multiple comparison code paths

Base Syntax:

Switch (<expression1>, <expression2>) {
    <condition1> { <code> }
    <condition2> { <code> }
    <condition3> { <code> }
}

#>


#Variable
$number1 = 5
$number2 = 11
$number3 = 30

#Example Syntax
Switch ($number1, $number2, $number3) {
    5   { Write-Host "5" }
    10  { Write-Host "10" }
    20  { Write-Host "20" }
    30  { Write-Host "30"}
    Default { Write-Host "Default" }
}

<# This is the output of above script
5
Default
30
#>


#First a comparison, does $number1 equal 5, "yes", does $number2 equal 5, "no" so the first matches but not the second one.
#Next line, next comparison.  Does $number1 equal 10, "no", does $number2 equal 10, "no", drops down to default
#Next line, next comparison.  Does $number1 equal 20, "no", does $number2 equal 20, "no", drops down to default
#Next line, next comparison.  Skipping the first three and moving on to "30". Does "30" match, "yes"
 