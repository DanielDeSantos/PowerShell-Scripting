param (
    [string]$programa
)

function Desinstalar-Programa {
    param (
        [string]$nombrePrograma
    )

    $programaADesinstalar = Get-Package -Name "$nombrePrograma"

    if ($programaADesinstalar) {
        
            Write-Host "Desinstalando '$nombrePrograma'..."
            Get-Package -Name "$nombrePrograma" | Uninstall-Package
            Write-Host "El programa '$nombrePrograma' ha sido desinstalado correctamente."
    } else {
        Write-Host "No se encontró ningún programa llamado '$nombrePrograma'."
    }

}

if ($programa) {
    Desinstalar-Programa -nombrePrograma $programa
} else {
    Write-Host "Por favor, proporciona el nombre de un programa para desinstalar."
}

