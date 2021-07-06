$path1 = "C:\Dev\love-windows"
$path2 = "C:\Program Files\LOVE"
$path3 = "D:\Documents\Programming\Lua\Games\Numbergame\*"
$file1 = "C:\Dev\love-windows\game.zip"
$file2 = "C:\Dev\love-windows\game.exe"
if (Test-Path $file2) {
    Remove-Item $file2 
}
try {
    Compress-Archive -Path $path3 -DestinationPath "$path1\game.zip"
    Get-Content -raw "$path2\love.exe","$path1\game.zip" -Encoding Byte | Set-Content -Encoding Byte -NoNewline $file2
    Remove-Item $file1
}
catch {
    throw $_.Exception.Message
}