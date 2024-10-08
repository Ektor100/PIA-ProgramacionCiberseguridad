Set-StrictMode -Version 3.0
$fileOutput = Join-Path (Get-Location) "SecurePasswords.txt"

# Feature to generate strong passwords
function Add-SecurPassword {
    param (
        [int]$PasswordLength
    )

    $chars = "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?/"
    $random = New-Object System.Random
    $password = -join (1..$PasswordLength | ForEach-Object { $chars[$random.Next($chars.Length)] })
    return $password
}

# Feature to store passwords securely
Function Save-Password {
    param (
        [string]$Username,
        [string]$PSWD ,
        [string]$Site
    )

    if (-not (Test-Path $fileOutput)) {

        "Usuario:`nContrasena:`nSitio Web o Aplicacion:`n" | Out-File -FilePath $fileOutput -Encoding utf8
    }

    $passwordEntry = "Usuario: $Username`nContrasena: $PSWD`nSitio Web o Aplicacion: $Site`n`n"
    $passwordEntry | Out-File -FilePath $fileOutput -Append -Encoding utf8
}

# Main function of the script
Function Start-PasswordManagement {
    do {
  
        $validLength = $false
        while (-not $validLength) {
            $lengthInput = Read-Host "Ingrese la longitud de la contrasena (entre 8 y 16 caracteres)"
            $length = [int]$lengthInput

            if ($length -ge 8 -and $length -le 16) {
                $validLength = $true
            } else {
                Write-Output "Longitud no valida, debe ser entre 8 y 16 caracteres"
            }
        }

        $generatedPassword = Add-SecurPassword -PasswordLength $length
        Write-Output "Contrasena generada: $generatedPassword"

        $username = Read-Host "Ingrese el nombre de usuario"
        $site = Read-Host "Ingrese el nombre del sitio web o aplicacion"


        Save-Password -Username $username -Password $generatedPassword -Site $site
        Write-Output "Datos almacenados en $fileOutput"

        $generateAnother = Read-Host "¿Quieres generar otra contrasena? (S/N)"
        if ($generateAnother -ne "S" -and $generateAnother -ne "s") {
            $generateAnother = $false
        } else {
            $generateAnother = $true
        }
    } while ($generateAnother)

    Write-Output "El proceso de generar y almacenar contraseñas a finalizado"
}