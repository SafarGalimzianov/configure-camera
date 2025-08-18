# ── Quick reference ──────────────────────────────────────────────────────────
# - Variables:
#     :=  immediate (simple) expansion; right side is evaluated now
#      =  lazy (recursive) expansion; right side is evaluated when used
#    $(VAR) references a variable; $ is for Make’s expansion, not the shell
#    $$   prints a literal $ inside a recipe line
# - Automatic vars (not used below but useful): $@ (target), $< (first dep), $^ (all deps)
# - Recipes:
#   Each command line under a target must start with a TAB character.
#   By default, each line runs in a fresh cmd.exe on Windows.
# - @ prefix on a recipe line hides the echoed command (quieter output).
# - .PHONY marks names as “not files”, so rules always run.
# ─────────────────────────────────────────────────────────────────────────────

# Base name used for both .py and .exe artifacts
# ':=' = expand immediately
MAIN := configure_camera
# Path to main .py file
MAIN_PATH := src

# Concatenate by placing text next to a variable reference
MAIN_PY := $(MAIN_PATH)\$(MAIN).py
MAIN_EXE := $(MAIN).exe


# PyInstaller output directory
DISTDIR := dist

# Force GNU Make to use cmd.exe and route PyInstaller via Python
SHELL := cmd.exe
.SHELLFLAGS := /C
PYTHON := uv
PYI := pyinstaller

# These targets are actions, not files
.PHONY: b clean

# IMPORTANT: recipe lines must start with a real TAB, not spaces
# 'b' = build the executable with PyInstaller and tidy up

# run PyInstaller (writes to .\dist by default)
# CMD 'if exist' to remove old exe (quotes handle spaces)
# move the new exe to project root
# remove build and dist dirs (/s recursive, /q quiet)
# delete PyInstaller .spec (ignore error if not present)

b:
	$(PYI) --onefile "$(MAIN_PY)"
	if exist "$(MAIN_EXE)" del "$(MAIN_EXE)"
	move "$(DISTDIR)\$(MAIN_EXE)" .
	rmdir /s /q build "$(DISTDIR)"
	del /q *.spec 2>nul

# 'clean' = remove build artifacts. '@' suppresses echoing each command.
clean:
	@if exist build rmdir /s /q build
	@if exist "$(DISTDIR)" rmdir /s /q "$(DISTDIR)"
	@del /q *.spec 2>nul
	@if exist "$(MAIN_EXE)" del "$(MAIN_EXE)"


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