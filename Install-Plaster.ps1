Clear-Host; Push-Location -Path $Path

#Install Plaster
Find-Module -Name Plaster | Install-Module -Scope CurrentUser

#Plaster function
Get-Command -Module Plaster

#Take a look at what templates come packaged in the box
Get-PlasterTemplate

#Alternativley if you have a directory which houses some templates you already crated you can specify the path parameter set.
Get-PlasterTemplate -Path 'C:\Users\richa\OneDrive\scripts\PlasterTemplate' -Recurse

#uninstall plaster
#C:\Users\richa\.vscode\extensions\ms-vscode.powershell-2019.12.0\modules\Plaster


