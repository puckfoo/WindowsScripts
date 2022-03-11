
# https://github.com/PowerShell/Plaster/tree/master/docs/en-US

$Path = "C:\Users\richa\OneDrive\scripts\Modules\"

Clear-Host; Push-Location -Path $Path

$destinationPath = New-Item -Path $Path -ItemType Directory -Name NewModule
$destinationPath

Get-PlasterTemplate
#Check the installed templates so we can select one. 
Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains'Module'}

$defaultTemplate = Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains'Module'}
$defaultTemplate.TemplatePath

#Invoke Plaster
Invoke-Plaster -TemplatePath $defaultTemplate.TemplatePath -DestinationPath $destinationPath

# Take a look at the output.  We can also start adding functions now.
code "$Path\NewModule\"    #Add a function if you like

#You can modify the module and import with the update
Import-Module -Name .\NewModule\MyModule.psd1
Get-Module -Name MyModule
Get-Command -Module MyModule

