Set-StrictMode -Version 3.0

# Function to get CPU usage
function Get-CPUUsage {
    $cpu = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average
    $cpuAvg = $cpu.Average
    Write-Host "Uso de CPU: $cpuAvg%"
    
}

# Function to obtain RAM memory usage
function Get-RAMUsage {
    $os = Get-WmiObject Win32_OperatingSystem
    $totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $freeRam = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $usedRam = [math]::Round($totalRam - $freeRam, 2)
    $ramUsagePercentage = [math]::Round(($usedRam / $totalRam) * 100, 2)
    Write-Host "Uso de RAM: $usedRam GB / $totalRam GB ($ramUsagePercentage%)"
   
}

# Function to get disk usage
function Get-DiskUsage {
    $disks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
    foreach ($disk in $disks) {
        $size = [math]::Round($disk.Size / 1GB, 2)
        $free = [math]::Round($disk.FreeSpace / 1GB, 2)
        $used = [math]::Round($size - $free, 2)
        $diskUsagePercentage = [math]::Round(($used / $size) * 100, 2)
        Write-Host "Disco $($disk.DeviceID): $used GB / $size GB ($diskUsagePercentage%)"
    }
}

# Function to get network usage
function Get-NetworkUsage {
    $adapters = Get-WmiObject Win32_PerfFormattedData_Tcpip_NetworkInterface
    foreach ($adapter in $adapters) {
        $bytesSent = [math]::Round($adapter.BytesSentPersec / 1MB, 2)
        $bytesReceived = [math]::Round($adapter.BytesReceivedPersec / 1MB, 2)
        Write-Host "Adaptador: $($adapter.Name)"
        Write-Host "Enviado: $bytesSent MB/s, Recibido: $bytesReceived MB/s"}
}

# Main function to review system resource usage
function Get-SystemResources {
    Write-Host "Revisando uso de recursos del sistema..."
    Get-CPUUsage
    Get-RAMUsage
    Get-DiskUsage
    Get-NetworkUsage
} 
