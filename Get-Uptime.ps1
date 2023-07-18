function Get-ComputerUptime {
    Param($ComputerName = $env:computername)
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName
        $up = New-TimeSpan -Start $os.LastBootUpTime -End (Get-Date)
        
        [PSCustomObject]@{
            ComputerName = $os.CSName
            LastBoot     = $os.LastBootUpTime
            Uptime       = $up
        }
}

Get-ComputerUptime