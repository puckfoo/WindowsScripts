<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
#>
Function Search-Files {
    [CmdletBinding()]
    param(
        [string]$Path
    )
    $data = Set-Location -Path $Path
    Get-ChildItem -Path $data -Force
   
}

Search-Files -Path "C:\Users\richa\onedrive\documents" 


Function Get-File {
    [CmdletBinding()]
    param(
        [string]$file
    )
    Set-Location "C:\Users\richa\OneDrive\Documents"
    Get-ChildItem -Name $file -File 
   
}

Get-File -file "*rich*"

