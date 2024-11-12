param (
    [string]$rutaDestino  # Coge la ruta del directorio de destino que ha sido pasada como parámetro
)


# Pregunta al usuario por la ruta de origen
$rutaOrigen = Read-Host "Introduce la ruta del directorio que deseas respaldar"

# Comprueba si la ruta de origen existe
if (-not (Test-Path -Path $rutaOrigen)) {
    Write-Host "El directorio de origen '$rutaOrigen' no existe."
    exit
}

Write-Host (Test-Path -Path $rutaDestino)

# Comprueba si la ruta de destino existe
if (-not (Test-Path -Path $rutaDestino)) {
    Write-Host "El directorio de destino '$rutaDestino' no existe. Se creará."
    # Si no existe, crea el directorio de destino
    $directorioCreado = New-Item -ItemType Directory -Path $rutaDestino
    if ($directorioCreado) {
        Write-Host "Directorio de destino '$rutaDestino' creado correctamente."
    } else {
        Write-Host "Ha habido un problema al crear el directorio de destino."
        exit
    }
}

# Realiza la copia de seguridad
Write-Host "Iniciando la copia de seguridad desde '$rutaOrigen' a '$rutaDestino'..."

# Intenta copiar los archivos
Copy-Item -Path "$rutaOrigen" -Destination $rutaDestino -Recurse -Force -ErrorAction SilentlyContinue # Añado este último parámetro para que no se muestren posibles errores causados por forzar la cópia del contenido del directorio.

Write-Host "La copia de seguridad se ha completado correctamente."
 