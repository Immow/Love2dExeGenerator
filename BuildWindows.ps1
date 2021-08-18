$path1 = "C:\Dev\love-windows"
$path2 = "C:\Program Files\LOVE"
$path3 = "D:\Documents\Programming\Lua\Games\Numbergame\*"
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