$rutaISO = Read-Host "Introduce la ruta absoluta del archivo ISO (ejemplo: C:\ruta\archivo.iso)"

if (-Not (Test-Path -Path $rutaISO)) {
    Write-Host "El archivo ISO no existe en la ruta especificada: $rutaISO. Saliendo del programa."
    exit
}

try {
    Mount-DiskImage -ImagePath $rutaISO
    Write-Host "El archivo ISO se ha montado correctamente."
} catch {
    Write-Host "Error al montar el archivo ISO. Saliendo del programa."
    exit
}

$letraUnidad = (Get-DiskImage -ImagePath $rutaISO | Get-Volume).DriveLetter + ":"

Write-Host "Contenido del archivo ISO:"
Get-ChildItem -Path $letraUnidad

$rutaDestino = Read-Host "Introduce la ruta absoluta de destino para copiar el archivo (ejemplo: C:\destino)"

if (-Not ([System.IO.Path]::IsPathRooted($rutaDestino))) {
    Write-Host "La ruta de destino no es válida o no es absoluta. Saliendo del programa."
    Dismount-DiskImage -ImagePath $rutaISO
    exit
}

$archivoACopiar = Read-Host "Introduce el nombre del archivo que deseas copiar (con extensión)"
$origenArchivo = Join-Path $letraUnidad $archivoACopiar

if (-Not (Test-Path -Path $origenArchivo)) {
    Write-Host "El archivo $archivoACopiar no existe en el ISO. Saliendo del programa."
    Dismount-DiskImage -ImagePath $rutaISO
    exit
}

try {
    Copy-Item -Path $origenArchivo -Destination $rutaDestino -Force
    Write-Host "El archivo se ha copiado correctamente a $rutaDestino."
} catch {
    Write-Host "Error al copiar el archivo a la ruta de destino. Saliendo del programa."
}

Dismount-DiskImage -ImagePath $rutaISO
Write-Host "El archivo ISO se ha desmontado."