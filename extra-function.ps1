Set-StrictMode -Version 2
function Get-ExecutionPolicyStatus {
    $currentPolicy = Get-ExecutionPolicy -List
    $currentPolicy
}
function Set-ExecutionPolicy {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Restricted", "AllSigned", "RemoteSigned", "Unrestricted")]
        [String]$Policy
    )
    if ($PSCmdlet.ShouldProcess("Execution Policy", "Set to $Policy")) {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy $Policy
    }
}
function Set-ExecutionPolicyToUnrestricted {
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Current
}
function Test-ScriptExecution {
    param (
        [Parameter(Mandatory=$true)]
        [String]$Script,
        [Parameter(Mandatory=$true)]
        [String]$Command
    )
    $policy = Get-ExecutionPolicy
    if ($policy -eq "Restricted") {
        Write-Output $false
    } elseif ($policy -eq "AllSigned" -and (Get-AuthenticodeSignature -FilePath $Script).Status -ne "Valid") {
        Write-Output $false
    } elseif ($policy -eq "RemoteSigned" -and (Get-AuthenticodeSignature -FilePath $Script).Status -ne "Valid" -and $Script -notlike "C:\*") {
        Write-Output $false
    } else {
        Write-Output $true
    }
}
Export-ModuleMember -Function Get-ExecutionPolicyStatus, Set-ExecutionPolicy, Test-ScriptExecution
trap {
    Write-Error "Ocurrió un error: $_"
}
Get-Command -Module ExecutionPolicyManager | ForEach-Object {
    $help = @{
        Synopsis = $_.Name
        Description = "Descripción para $($_.Name)"
        Examples = @(
            @{Text = "$($_.Name) -Ejemplo"}
        )
    }
    New-Alias -Name "Get-Help$($_.Name)" -Value {Get-Help $_.Name -Detailed} -Description "Muestra ayuda para $($_.Name)"
}