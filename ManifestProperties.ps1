$manifestProperties = @{
    Path            =   'C:\Users\richa\OneDrive\scripts\PlasterTemplate\plasterManifest.xml'
    TemplateName    =   'PlasterModuleTemplate'
    TemplateType    =   'Project'
    Title           =   'New PowerShell Module Plaster Template'
    Author          =   'Richard Holland'
    Description     =   'Scaffolds the files required for a PowerShell script module'
    Tags            =   'PowerShell, Module, ModuleManifest'
}

$Folder = Split-Path -Path $manifestProperties.path -Parent
if (!(Test-path -Path $Folder -PathType Container)) {
    New-Item -Path $Folder -ItemType Directory | Out-Null

}

New-PlasterManifest @manifestProperties






