function Api_HashVer { 	Write-Host "vamos a hacer un listado de hashes para el record de su Sistema de archivos locales"
						Write-Host "favore de mencionar de donde desea hacer el escaneo de hashes sha256 para su analisis con virus total"  
						$cycle=0
						Get-FileHash -path ".\*" -Algorithm SHA256 | Select-Object -Property Hash|Export-Csv -Path .\hashes.csv 
						$Hash_Scan = Import-Csv  ".\hashes.csv" | Select-Object -ExpandProperty Hash
						

						$row = Import-Csv .\hashes.csv
							foreach  ($row in $Hash_Scan){		
							$headers=@{}
							$headers.Add("accept", "application/json")
							$headers.Add("x-apikey", "ddb821087e5b9e0de5403e8f7d904fa7b5847b79d4369d50b30b882df0024c62")
							$response = Invoke-RestMethod -Uri https://www.virustotal.com/api/v3/files/$row -Method GET -Headers $headers 
							
							if ($response) {
								
								$name = $response.data.attributes.meaningful_name
								$malicious = $response.data.attributes.last_analysis_stats.malicious
								$suspicious = $response.data.attributes.last_analysis_stats.suspicious
								
								Write-Host "Name: $name" "Malicious: $malicious" "Suspicious: $suspicious"
								Start-Sleep -Seconds 15
							}
					}
			}
		

				
	
#function File_Show{	Write-Host " please output the option you would like to chose the dir to view files:" 
#			$direct = Read-Host 
#			Write-Host "1) view files in dir"
#			Write-Host "2) view hidden files in dir "
#			Write-Host "3) view hidden files and files in dir"
#			$option = Read-Host 
#			switch($option){
#			1{Dir}						
#			2{Dir -Hidden }
#			3{Dir -Force}
#			}
#}


#function Api_HashVer {
#    Write-Host "Vamos a hacer un listado de hashes para el record de su Sistema de archivos locales"
#    Write-Host "Favor de mencionar de donde desea hacer el escaneo de hashes SHA256 para su análisis con VirusTotal"
#
#    Get-FileHash -Path .\* -Algorithm SHA256 | Export-Csv -Path .\hashes.csv

    
#    $Hash_Scan = Import-Csv ".\hashes.csv"
#
#    foreach ($row in $Hash_Scan) {
#        $fileHash = $row.Hash

#       
#        $headers = @{
#           "accept" = "application/json"
#            "x-apikey" = "ddb821087e5b9e0de5403e8f7d904fa7b5847b79d4369d50b30b882df0024c62"
#        }

       
#        $response = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$fileHash" -Method GET -Headers $headers

        
#        Add-Content -Path .\hashes.csv 
#    }
#			

$headers=@{}
$headers.Add("accept", "application/json")
$headers.Add("x-apikey", "ddb821087e5b9e0de5403e8f7d904fa7b5847b79d4369d50b30b882df0024c62")
$response = Invoke-RestMethod -Uri 'https://www.virustotal.com/api/v3/files/657B1352D6513BCD840205DA8A98E8ACA70E0954C87CC59EB1317923B705AE2A' -Method GET -Headers $headers
