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




<#
Hashtables

What are Hashtables?

A Hashtable is a data structure like an Array, except you store every value (object) using a key.  Hashtables only contian values not properties.  They are basic key/value stores.

1. Also known as a dictionary or associative array
2. Data structure that stores one or more key/value pairs
3. Keys and values in hash tables are define as .net objects
4. Efficient way for finding and retrieving data


Creating Hashtables
1. Start the hash table with an at-sign (@)
2. Wrap the hash table in braces ({})
3. Use an equal sign (=) to separate each key from its value
4. Use a semicolon (;) or a line break to searate the key/value pairs

#>

#Create an Empty Hashtable
$variable = @{}

#Create a Hashtable with Keys and Values
$variable = @{ Month = 5; Name = "May"; Season = "Spring" }

#Create an Ordered Hashtable with Keys and Values
$variable = [ordered]@{ Month =5; Name = "May"; Season = "Spring" }


$variable = @{
    China = 1439323776;
    India = 1380004385;
    America = 331002651;
    Spain = 46754778
}

$variable

$variable.Keys

foreach ($key in $variable.Keys) {
    $output = '{0} has a population of {1}' -f $_,$variable[$_];
    Write-Host $output
}


# $_ can't be returned in a foreach statement. In a foreach statement, we have to use the named object


# This is the proper way
foreach ($key in $variable.Keys) {
    $output = '{0} has a population of {1}' -f $key,$variable[$key];  # $key is the named $object
    Write-Host $output
}

#Samething but this time foreach-object
$variable.Keys | ForEach-Object {
$output = '{0} has a population of {1}' -f $_,$variable[$_] 
Write-Host $output}



$variable = [PSCustomObject]@{
    China = 1439323776;
    India = 1380004385;
    America = 331002651;
    Spain = 46754778
}



















