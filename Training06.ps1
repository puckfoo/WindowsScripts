<#

Common Commands

ConvertTo-Xml
ConvertFrom-Json
ConvertTo-Json

Loading XML

Simplest approach to use Select-XML command
    Uses XPath queries to search for text in XML strings and documents

Requires the PATH of the XML File and the XPATH within the XML document to search

#>

# Define Variables
$path = 'C:\Users\Richard Holland\OneDrive\Documents\Data\Countries-with-Attributes.xml'
$xpath = "/Countries/Country/Name"

# Load Xml
$xml = Select-Xml -Path $path -XPath $xpath



# Define Variables
$path = 'C:\Users\Richard Holland\OneDrive\Documents\Data\Countries-with-Attributes.xml'
$xpath = "/Countries/Country/Name"

# Load Xml 
$xml = Select-Xml -Path $path -Xpath $xpath

# Loop through Xml Property Vaules
$xml | ForEach-Object {$_.Node.Name}


# Create Xml variable and Load Data, then Retrieve Vaules
[xml]$xml = Get-Content -Path $path
$xml.Countries.Country.Name
$xml.Countries.Country.Population






