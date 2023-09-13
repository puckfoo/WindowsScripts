function Get-Memory {
    [CmdletBinding()]
    param (
        [string[]]$Computername
    )
    
    $PhysicalMemory = Get-WmiObject -class "win32_physicalmemory" -namespace "root\CIMV2" -ComputerName $Computername 
 
    Write-Host "Memore Modules:" -ForegroundColor Green 
    $PhysicalMemory | Format-Table Tag,BankLabel,@{n="Capacity(GB)";e={$_.Capacity/1GB}},Manufacturer,PartNumber,Speed -AutoSize 
    

}


