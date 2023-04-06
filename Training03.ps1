$path = Get-ChildItem -path "C:\Windows" -Directory 

foreach ($file in $path){
    Write-Host $file
}
