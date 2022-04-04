$path1 = "C:\Dev\love-windows" #Output folder
$path2 = "C:\Program Files\LOVE" #Löve2d installtion path
$path3 = "D:\Nono\*" #Path of your game project
if (Test-Path "$path1\game.exe") {
    Remove-Item "$path1\game.exe" 
}
try {
    Compress-Archive -Path $path3 -DestinationPath "$path1\game.zip"
    Get-Content -raw "$path2\love.exe","$path1\game.zip" -Encoding Byte | Set-Content -Encoding Byte -NoNewline "$path1\game.exe"
    Remove-Item "$path1\game.zip"
    Copy-Item -Path $path2\* -Include "*.dll" -Destination $path1
}
catch {
    throw $_.Exception.Message
}