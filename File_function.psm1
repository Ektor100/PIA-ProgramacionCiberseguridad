Set-StrictMode -Version 3.0
function File_Show {	Write-Host " please output the option you would like to chose the dir to view files:" 
			Write-Host "1) view files in dir"
			Write-Host "2) view hidden files in dir "
			Write-Host "3) view hidden files and files in dir"
			$option = Read-Host 
			switch($option){
			1{Dir}						
			2{Dir -Hidden }
			3{Dir -Force}
			}
}