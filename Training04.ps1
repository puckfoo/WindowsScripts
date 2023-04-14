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


########################################################################################################

#Split:

-split "Jan Feb Mar Apr May Jun"

"Jan,Feb,Mar,Apr,May,Jun" -split ","

$months = "Jan,Feb,Mar,Apr,May,Jun" -split ","

$months = "Jan,Feb,Mar,Apr,May,Jun" -split ",",3

$variablesplit = "Jan,Feb,Mar,Apr,May,Jun"

$variablesplit.Split(',')

$variablesplit = "Jan,Feb,Mar,Apr;May;Jun"

$variablesplit.Split(',').Split(';')


################################################################################################################

#Padding:

$pat1 = "Demonstration"
$pat2 = "Demonstration"

$pad1.PadLeft(14,'Added') 

#This errors because you can't add a word 'Added', but you can add a characer 'A'. Example below.

$pad1.PadLeft(14,'A') 





