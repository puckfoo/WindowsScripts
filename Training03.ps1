<#

Types of Variables:
1. Loosely Typed - When a value is assigned to an undefined type of variable.
2. Strongly Typed - Type is assigned to variable.


Variable Types:
1. User-Created Variables - These are variables created and maintained by the user.  The variables created within the PowerShell command-line exists only while the PowerShell window is open.
2. Automatic Variables - Variables that store the state of PowerShell.  PowerShell creates these variables and changes their vaules as required to maintain their accuracy.
3. Preference Variables - Preference variables store user preferences for PowerShell.  These variables are created by PowerShell and populated with default values.

#>



#Creating User Variables
#Create a basic variable
$variable1 = 1, 2, 3
$variable2 = "C:\Documents\"
$variable3 = "January 1, 2021"

#Create a typed variable
[int]$variable01 = 10
[datetime]$variable02 = "January 1, 2021"


<#
Common Variable Data Types:
Boolean
Date Time
PowerShell Object
Script Block
String
Array

Casting Data Vaules - Converting one object type to another.  Not all objects can be cast.
#>

#Variables
$variable010 = "1"
$variable020 = "01/01/2021"

#Converting String Variable to Integer
[int]$variable0101

#Converting String Variable to Data
[datetime]$variable0202


#Converting False Value to Integer
[int]$false


<#
Casting Using the -AS Operator

1. Use to test a conversion
2. Define the type after the variable
3. Can have unexpected results

#>

#Variables
$variable10 = "1"
$variable20 = "01/01/2021"

#Cast String Variable to Integer
$variable10 -as [int]

#Cast String Variable to Date
$variable20 -as [datetime]

#Cast False Value to Integer
$false -as [int]


<#
Using the -F Operator:
1. Used to format a string expression
2. Supports complex formatting

#>

#Variables
$variable101 = 123.4567890
$variable202 = 4503457892

#Display Only three Decimal Places
"{0:n3}" -f $variable101

#Add Spaces for Phone Number
"{0:###-###-####}" -f $variable202


#Display Year Only from Date
"0:yyyy}" -f (Get-Date)



$variable1000 = 1,2,3,4,5
$variable2000 = "C:\Documents"

[int]$variable3000 = 10

[int]$variable3000 = "Test Value"
Result fails - MetadataError: Cannot convert value "Test Value" to type "System.Int32". Error: "The input string 'Test Value' was not in a correct format."


$variable3 = 10 
$variable3.GetType().Name




