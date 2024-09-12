New-ModuleManifest -path ".\resourse.psd1" -Rootmodule ".\resourse.psm1"
Import-Module ".\resourse.psm1"
Get-Module Check-SystemResources
#Write-Host "Gracias por iniciar este programa el script se esta ejecutando... "

do {
    Write-Host "Escoja que funcion quiere iniciar: "
    Write-Host "1) Revision de archivos por medio de Virus Total"
    Write-Host "2) Listado de archivos ocultos"
    Write-Host "3) Revision de uso de recursos"
    Write-Host "4) [Tarea adicional]"
    Write-Host "5) Finalizar programa."

    $option = Read-Host 

    switch ($option) {
        1 {Write-Host "Funcion no habilitada"}
        2 {Write-Host "Funcion no habilitada"}
        3 {Check-SystemResources}
        4 {Write-Host "Funcion no habilitada"} 
        5 {
            Write-Host "Finalizando..."
            Exit}
        default {Write-Host "Opcion invalida. Intentalo de nuevo."}
    }
} while ($option -ne 5)