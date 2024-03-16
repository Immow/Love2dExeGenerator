$path1 = "C:\Dev\love-windows" # Output folder
$path2 = "C:\Program Files\LOVE" # Löve2d installation path
$path3 = "D:\Documents\Programming\Lua\Test\FFI" # Path of your game project

# Remove game.zip, game.exe, and the bin folder if they exist
Remove-Item "$path1\game.zip", "$path1\game.exe", "$path1\bin" -ErrorAction SilentlyContinue -Recurse

# Check if the bin folder exists, if not, create it
if (-not (Test-Path "$path1\bin")) {
	New-Item -Path "$path1\bin" -ItemType Directory -Force
}

try {
	# Compress the entire game project folder into a zip file
	Compress-Archive -Path $path3\* -DestinationPath "$path1\game.zip" -Force

	# Concatenate love.exe and the game.zip into game.exe
	Get-Content -raw "$path2\love.exe", "$path1\game.zip" -Encoding Byte |
	Set-Content -Encoding Byte -NoNewline "$path1\game.exe"

	# Copy necessary DLLs from Löve2d installation folder to the output folder
	Copy-Item -Path "$path2\*" -Include "*.dll" -Destination $path1 -Force

	# Copy necessary DLLs from the game project's bin folder to the output folder's bin folder
	Copy-Item -Path "$path3\bin\*" -Include "*.dll" -Destination "$path1\bin" -Force
}
catch {
	Write-Error "Error occurred: $_"
}
