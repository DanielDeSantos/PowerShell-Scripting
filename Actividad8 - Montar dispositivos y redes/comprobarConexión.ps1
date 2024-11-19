$direccionPrueba = "www.google.com"
$puertoPrueba = 80

try {
    $conexion = Test-NetConnection -ComputerName $direccionPrueba -Port $puertoPrueba
    if ($conexion.TcpTestSucceeded) {
        [System.Windows.MessageBox]::Show("La conexión TCP funciona correctamente.", "Conexión OK")
    } else {
        [System.Windows.MessageBox]::Show("No hay conexión TCP.", "Error de Conexión")
    }
} catch {
    [System.Windows.MessageBox]::Show("Se produjo un error durante la comprobación.", "Error")
}