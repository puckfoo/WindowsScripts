<#
Arrays

What is an array - An array is a list or collection of values or objects.  Arrays only contain values not properties

1. Empty arrays can be created by using "@()"
2. Comma separated lists can also create Arrays
3. The "Write-Output" command can create string arrays

#>


#Create Empty Array
$variable01 = @()

#Create Array with Text Values
$variable02 = @('January','Feburary','March','April','May','June')

#Create Array with Text Values not using @()
$variable03 = 'January','Feburary','March','April','May','June'

#Create Array with Text Vaules not using "@90"
$variable04 = Write-Output January Feburary March April May June 

#Access Array Item using offset
$variable03[3]
$variable03[0,1,4]
$variable03[2..5]

$variable02 | ForEach-Object {"The month is: $PSItem"}

#What is a $PSItem - It's a standdard PowerShell property or $variable that's created by PowerShell for a foreach object loop

#Access Array Items using a foreach loop
foreach ($item in $variable02) {"The month is: $item"}

#Access Array Items using the foreach method
$variable02.ForEach({"The month is: $PSItem"})


#Access Array Items using for loop
for ($item = 0; $item -lt $variable02.count; $item++) {
    "The month is: {0}" -f $variable02[$item];
    Write-Host "Current Position: $item"
}








