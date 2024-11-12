$ruta = ""
while ([string]::IsNullOrWhiteSpace($ruta)) {  # Para obligar al usuario a introducir una ruta (y así prevenir errores), he creado un bucle que obligue a mientras detecte que no se ha introducido ningún valor.
    $ruta = Read-Host "Introduce una ruta"
}


$nombreBuscado = ""
while ([string]::IsNullOrWhiteSpace($nombreBuscado)) { # Para obligar al usuario a introducir un nombre (y así prevenir errores), he creado un bucle que obligue a mientras detecte que no se ha introducido ningún valor.
    $nombreBuscado = Read-Host "Introduce el nombre del fichero. También puedes introcucir un patrón como *.txt"
}


if (Test-Path -Path $ruta) { # Comprueba si la ruta existe y, si no existe, da un mensaje diciendo que la ruta no existe y se acaba el código
    $resultados = Get-ChildItem -Path $ruta -Filter $nombreBuscado  # Busca archivos o directorios que coincidan con el nombre o patrón indicado dentro de la ruta especificada
    # Una vez se ha buscado el fichero o directorio en la ruta buscada, da una respuesta en función de los resultados obtenidos
    if ($resultados) {
        Write-Host "Se han encontrado los siguientes archivos o directorios:"
        $resultados | ForEach-Object { Write-Host $_.FullName }
    } else {
        Write-Host "No se ha encontrado ningún archivo o directorio llamado '$nombreBuscado' en la ruta '$ruta'."
    }
} else {
    Write-Host "La ruta especificada '$ruta' no existe."
}