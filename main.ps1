<#
.SYNOPSIS
menu de opciones para revicion de ciberseguridad.#>
<#
.DESCRIPTION
con este scrip podras elegir entre diversas opciones para monitoreo de ciberseguridad#>
<#
.NOTES
este menu requiere de diferentes modulos para correr correctamente y solo se podra elegir de la opcion 1 a 5#>
<#
.EXAMPLE
PS C:\> get-help.\main.ps1 -full#>
New-ModuleManifest -path ".\resourse.psd1" -Rootmodule ".\resourse.psm1" 
Import-Module ".\resourse.psm1" 
New-ModuleManifest -path ".\savePassword.psd1" -Rootmodule ".\savePassword.psm1" 
Import-Module ".\savePassword.psm1"  
New-ModuleManifest -path ".\API_function.psd1" -RootModule "API_function.psm1" -Author "Grupo6" -Description "Este modulo va a usar verificacion de documentos locales creacion de un cvs para la facilitacion de lectura con la api de virus total, ademas de esto vamos a usar listado de documentos de dir y sus archivos escondidos"
Import-Module ".\API_function.psm1"
New-ModuleManifest -path ".\File_function.psd1" -RootModule "File_function.psm1" -Author "Grupo6" -Description "Este modulo va a usar verificacion de documentos locales creacion de un cvs para la facilitacion de lectura con la api de virus total, ademas de esto vamos a usar listado de documentos de dir y sus archivos escondidos"
Import-Module ".\File_function.psm1" 
Get-Module Get-SystemResources, Start-PasswordManagement, Api_HashVer, File_Show
Write-Host "===================================="
Write-Host "Gracias por iniciar este programa el script se esta ejecutando... "

do {
    Write-Host "Escoja que funcion quiere iniciar: "
    Write-Host "1) Revision de archivos por medio de Virus Total"
    Write-Host "2) Listado de archivos ocultos"
    Write-Host "3) Revision de uso de recursos"
    Write-Host "4) Crear y gestionar contrasenas"
    Write-Host "5) Finalizar programa."
    Write-Host "===================================="
    $option = Read-Host 
    Write-Host "===================================="
    switch ($option) {
        1 {Api_HashVer}
        2 {File_Show}
        3 {Get-SystemResources}
        4 {Start-PasswordManagement} 
        5 {
            Write-Host "Finalizando..."
            Exit
        }
        default {Write-Host "Opcion invalida. Intentalo de nuevo."}
    }
    Write-Host "===================================="
} while ($option -ne 5)
