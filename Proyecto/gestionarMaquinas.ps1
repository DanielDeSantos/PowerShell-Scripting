function VerificarMaquina {
    param (
        [string]$nombreMaquina
    )

    $maquinas = VBoxManage list vms | ForEach-Object { ($_ -split '"')[1] }

    if ($maquinas -contains $nombreMaquina) {
        return $true
    }
    return $false
}

function EstadoMaquina {
    param (
        [string]$nombreMaquina
    )

    $maquinasEncendidas = VBoxManage list runningvms | ForEach-Object { ($_ -split '"')[1] }

    if ($maquinasEncendidas -contains $nombreMaquina) {
        return "encendida"
    }
    return "apagada"
}

do {
    Write-Host "¿Qué deseas hacer?"
    Write-Host "1. Encender una máquina virtual"
    Write-Host "2. Guardar el estado de una máquina virtual"
    Write-Host "3. Apagar una máquina virtual"
    Write-Host "4. Listar máquinas virtuales"
    Write-Host "5. Salir"

    $opcion = Read-Host "Selecciona una opción (1-5)"

    switch ($opcion) {
        1 {
            $nombreMaquina = Read-Host "Escribe el nombre de la máquina virtual que deseas encender"

            if (VerificarMaquina -nombreMaquina $nombreMaquina) {
                $estado = EstadoMaquina -nombreMaquina $nombreMaquina

                if ($estado -eq "encendida") {
                    Write-Host "Error: La máquina '$nombreMaquina' ya está encendida."
                    
                } else {
                    VBoxManage startvm "$nombreMaquina"
                    Write-Host "La máquina virtual '$nombreMaquina' se ha encendido correctamente."
                    
                }
            } else {
                Write-Host "La máquina virtual '$nombreMaquina' no existe."
                
            }
        }
        2 {
            $nombreMaquina = Read-Host "Escribe el nombre de la máquina virtual cuyo estado deseas guardar"

            if (VerificarMaquina -nombreMaquina $nombreMaquina) {
                $estado = EstadoMaquina -nombreMaquina $nombreMaquina

                if ($estado -eq "apagada") {
                    Write-Host "Error: La máquina '$nombreMaquina' está apagada, no se puede guardar su estado."
                    
                } else {
                    VBoxManage controlvm $nombreMaquina savestate *> $null
                    Write-Host "Se ha guardado el estado de la máquina '$nombreMaquina'."
                    
                }
            } else {
                Write-Host "La máquina virtual '$nombreMaquina' no existe."
                
            }
        }
        3 {
            $nombreMaquina = Read-Host "Escribe el nombre de la máquina virtual que deseas apagar"

            if (VerificarMaquina -nombreMaquina $nombreMaquina) {
                $estado = EstadoMaquina -nombreMaquina $nombreMaquina

                if ($estado -eq "apagada") {
                    Write-Host "Error: La máquina '$nombreMaquina' ya está apagada."
                } else {
                    VBoxManage controlvm $nombreMaquina poweroff *> $null
                    Write-Host "Se ha apagado la máquina '$nombreMaquina'."
                }
            } else {
                Write-Host "La máquina virtual '$nombreMaquina' no existe."
            }
        }
        4 {
            Write-Host ""
            Write-Host "Las máquinas disponibles actualmente son las siguientes:"
            VBoxManage list vms | ForEach-Object {
                Write-Host ($_ -split '"')[1]
            }
        }
        5 {
            Write-Host "Saliendo del programa..."
        }
        default {
            Write-Host "Opción no válida. Por favor, selecciona una opción entre 1 y 5."
        }
    }
    Write-Host ""
} while ($opcion -ne "5")