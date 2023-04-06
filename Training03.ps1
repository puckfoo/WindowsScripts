$path = Get-ChildItem -path "C:\Windows" -File

foreach ($file in $path){
    Write-Host $file
}
