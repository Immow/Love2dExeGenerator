$path1 = "C:\Dev\love-windows" # Output folder
$path2 = "C:\Program Files\LOVE" # Löve2d installation path
$path3 = "D:\Documents\Programming\Lua\Test\FFI" # Path of your game project

# Check if game.exe exists in the output folder and remove it if it does
if (Test-Path "$path1\game.exe") {
	Remove-Item "$path1\game.exe"
}

# Remove all files in the bin folder of the output folder
if (Test-Path "$path1\bin") {
	Remove-Item "$path1\bin\*.*"
}

try {
	# Compress the entire game project folder into a zip file
	Compress-Archive -Path $path3\* -DestinationPath "$path1\game.zip" -Force

	# Concatenate love.exe and the game.zip into game.exe
	Get-Content -raw "$path2\love.exe", "$path1\game.zip" -Encoding Byte |
	Set-Content -Encoding Byte -NoNewline "$path1\game.exe"

	# Remove the temporary game.zip
	Remove-Item "$path1\game.zip"

	# Copy necessary DLLs from Löve2d installation folder to the output folder
	Copy-Item -Path "$path2\*" -Include "*.dll" -Destination $path1 -Force

	# Copy necessary DLLs from the game project's bin folder to the output folder's bin folder
	Copy-Item -Path "$path3\bin\*" -Include "*.dll" -Destination "$path1\bin" -Force
}
catch {
	Write-Error "Error occurred: $_"
}
