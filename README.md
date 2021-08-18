# Love2dExeGenerator

This Powershell program will generate a game.exe of your love game.

# To run
Right click the file and chose run with Powershell

# What it does when run
- It will check if there is a executable named game.exe in your output path ($path1) and removes it if that's the case.
- It will compress your game in a zipfile.
- It will merge your zip file with some magic to create an executable.
- It will remove the zip.
- It will copy over the DLL files.

# What you need to configure/change
1) Make sure this folder exists: "C:\Dev\love-windows" or chose a different location but then you'l have to update $path1 = "C:\Dev\love-windows" to that
2) Check if your $path2 = "C:\Program Files\LOVE" is pointing to where Löve is installed.
3) $path3 = "D:\Documents\Programming\Lua\Games\Numbergame\*" <-- change this to where your game (main.lua) is located.

I'm not a Powerhsell expert so feel free to add to this.
