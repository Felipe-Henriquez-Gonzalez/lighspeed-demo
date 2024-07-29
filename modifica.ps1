# Ruta al archivo CSV
$csvPath = "C:\ruta\al\archivo\usuarios.csv"

# Importar el archivo CSV
$usuarios = Import-Csv -Path $csvPath

# Definir los datos de los usuarios a modificar o agregar
$usuariosAActualizar = @(
    [PSCustomObject]@{Nombre="Maria"; Email="maria.nuevo@ejemplo.com"; Telefono="111111111"},
    [PSCustomObject]@{Nombre="Luis"; Email="luis@ejemplo.com"; Telefono="222222222"}
)

foreach ($usuarioAActualizar in $usuariosAActualizar) {
    $nombre = $usuarioAActualizar.Nombre
    $nuevoEmail = $usuarioAActualizar.Email
    $nuevoTelefono = $usuarioAActualizar.Telefono

    # Buscar el usuario en la lista
    $usuarioExistente = $usuarios | Where-Object { $_.Nombre -eq $nombre }

    if ($usuarioExistente) {
        # Modificar los datos del usuario existente
        $usuarioExistente.Email = $nuevoEmail
        $usuarioExistente.Telefono = $nuevoTelefono
    } else {
        # Agregar un nuevo usuario
        $nuevoUsuario = [PSCustomObject]@{
            Nombre   = $nombre
            Email    = $nuevoEmail
            Telefono = $nuevoTelefono
        }
        $usuarios += $nuevoUsuario
    }
}

# Exportar los cambios a un archivo CSV
$usuarios | Export-Csv -Path $csvPath -NoTypeInformation
