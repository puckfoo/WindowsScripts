function Get-Uptime {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    New-TimeSpan -Start $os.LastBootUpTime -End (Get-Date)
}

