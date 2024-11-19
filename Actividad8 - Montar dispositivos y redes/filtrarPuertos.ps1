$tipoPuerto = Read-Host "¿Qué tipo de puertos deseas ver? (TCP, UDP, TODOS)"

switch ($tipoPuerto.ToUpper()) {
    "TCP" {
        Write-Host "Listando los puertos TCP abiertos:"
        Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" } | Format-Table LocalAddress, LocalPort, State
    }
    "UDP" {
        Write-Host "Listando los puertos UDP abiertos:"
        Get-NetUDPEndpoint | Format-Table LocalAddress, LocalPort
    }
    "TODOS" {
        Write-Host "Listando los puertos TCP y UDP abiertos:"
        Write-Host "Puertos TCP:"
        Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" } | Format-Table LocalAddress, LocalPort, State
        Write-Host "Puertos UDP:"
        Get-NetUDPEndpoint | Format-Table LocalAddress, LocalPort
    }
    Default {
        Write-Host "Opción no válida. Introduce TCP, UDP o TODOS."
    }
}