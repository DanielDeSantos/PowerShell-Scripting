function Calcular {
    param (
        [double]$valor1,
        [double]$valor2,
        [string]$operacion
    )

    Write-Host $valor1 $valor2 $operacion

    switch ($operacion) {
        "+" { 
            return $valor1 + $valor2
        }
        "-" { 
            return $valor1 - $valor2
        }
        "*" { 
            return $valor1 * $valor2
        }
        "/" { 
            if ($valor2 -eq 0) {
                Write-Host "No se puede dividir entre zero."
                return $null
            }
            return $valor1 / $valor2
        }
        default {
            Write-Host "Operación no válida. Ha de ser +, -, * o /."
            return $null
        }
    }
}

# Antes de llamar a la función, he de establecer una función los parámetros 
$valor1 = [double]$args[0] # Como un número puede ser decimal, he hecho que esta función sea de tipo Double
$valor2 = [double]$args[1]
$operacion = $args[2]

Write-Host $valor1 $valor2 $operacion

# Llamo a la función pasándole como argumento los parámetros que se han pasado al llamar al script
$resultado = Calcular -valor1 $valor1 -valor2 $valor2 -operacion $operacion

if ($resultado -ne $null) {
    Write-Host "El resultado de $valor1 $operacion $valor2 es: $resultado"
}