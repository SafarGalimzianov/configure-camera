# Make uses CMD execution, so "" are required for commands in move
b:
	pyinstaller --onefile ping_camera.py
	if exist del ping_camera.exe
	move ".\dist\ping_camera.exe" ".\"
	rmdir /s /q build dist
	del *.spec

# .PHONY: b clean

# & "C:\Program Files (x86)\GnuWin32\bin\make.exe" b

# 1850 INFO: Build complete! The results are available in: D:\Prgrms\configure-camera\dist
# del ping_camera.exe
# mv .\dist\ping_camera.exe .
# process_begin: CreateProcess(NULL, mv .\dist\ping_camera.exe ., ...) failed.
# make (e=2): Не удается найти указанный файл.
# make: *** [b] Ошибка 2

# $env:PATH += ";C:\Program Files (x86)\GnuWin32\bin"
# [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files (x86)\GnuWin32\bin", "Machine" or "User")
# $env:PATH -split ";" | Where-Object { $_ -like "*GnuWin32*" }