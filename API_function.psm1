Set-StrictMode -Version 3.0
function Api_HashVer { 	Write-Host "vamos a hacer un listado de hashes para el record de su Sistema de archivos locales"
						Write-Host "favore de mencionar de donde desea hacer el escaneo de hashes sha256 para su analisis con virus total"  
						(Get-FileHash -path ".\*" -Algorithm SHA256) | Select-Object -Property Hash|Export-Csv -Path .\hashes.csv 
						$Hash_Scan = Import-Csv  ".\hashes.csv" | Select-Object -ExpandProperty Hash
						$row = Import-Csv .\hashes.csv
						$apikey = Read-Host "Favor de ingresar su API-Key: "
							foreach  ($row in $Hash_Scan){		
							$headers=@{}
							$headers.Add("accept", "application/json")
							$headers.Add("x-apikey", "$apikey")
							Try {
								$response = Invoke-RestMethod -Uri https://www.virustotal.com/api/v3/files/$row -Method GET -Headers $headers -ErrorAction SilentlyContinue
								if ($response) {
									
									$name = $response.data.attributes.meaningful_name
									$malicious = $response.data.attributes.last_analysis_stats.malicious
									$suspicious = $response.data.attributes.last_analysis_stats.suspicious
									
									Write-Host "Name: $name" "Malicious: $malicious" "Suspicious: $suspicious"
									Start-Sleep -Seconds 15
								}
							}
							Catch {
								if($_.ErrorDetails.Message) {
								} else {
									Write-Host $_
								}
							}
					}
			}