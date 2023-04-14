<#
String Data Mulnipulation 

Common String Manipulation
1. Replacing String Values 
2. Splitting String Values
3. Padding String Values

#>


$variable1 = "The class instructor asked for a volunteer for a demon stration"

$variable1 -replace "instructor","teacher"

$replacevariable = $variable1 -replace "instructor","teacher"

$replacevariable

####################################################################################################

$variable2 = "Jones Tom"

$variable2 -replace "([a-z]+)\s([a-z]+)",'$2,$1'

$variable2 -replace "([a-z]+)\s([a-z]+)",'$2 $1'

$variable2 -replace '[^a-z]'

