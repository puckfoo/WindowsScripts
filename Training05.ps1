<#
Arrays

What is an array - An array is a list or collection of values or objects.  Arrays only contain values not properties

1. Empty arrays can be created by using "@()"
2. Comma separated lists can also create Arrays
3. The "Write-Output" command can create string arrays

#>


#Create Empty Array
$variable = @()

#Create Array with Text Values
$variable = @('January','Feburary','March','April','May','June')

#Create Array with Text Values not using @()
$variable = 'January','Feburary','March','April','May','June')