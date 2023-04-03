$variableOne = "1"
$variableTwo = "3"
$textVariable = $true

($variableOne -eq $variableTwo) ? $true : $false
($variableOne -eq $variableTwo) ?
        ("$variableOne > $variableTwo ") : ("$variableOne < $variableTwo ")


($textVariable) ? "Vaule is true" : "Value is false"

