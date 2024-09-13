# Revision de uso de recursos del sistema

function Get-UsoMemoria {
    Get-CimInstance Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory
}

function Get-UsoDisco {
    Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
}

function Get-UsoProcesador {
    $totalCPU = (Get-Process | Measure-Object -Property CPU -Sum).Sum
    [PSCustomObject]@{
        'TotalCPUTime (s)' = [math]::round($totalCPU, 2)
    }
}

function Get-UsoRed {
    Get-NetAdapterStatistics | Select-Object Name, ReceivedBytes, SentBytes
}

Export-ModuleMember -Function Obtener-UsoMemoria, Obtener-UsoDisco, Obtener-UsoProcesador, Obtener-UsoRed