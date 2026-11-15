@echo off
rem NBD Video: Claude Code hooks (hooks\hooks.json). Plain text. Runs bootstrap.py "hook" with the plugin's Python when it is
rem installed, and does nothing otherwise (never downloads anything here). Read-only: it looks at the Brief form of this
rem computer and tells the AI to keep listening to it (bootstrap.py, def hook).
setlocal EnableExtensions
set "D=%CLAUDE_PLUGIN_DATA%"
if not defined D set "D=%PLUGIN_DATA%"
if not defined D if exist "%LOCALAPPDATA%\ClickVideo\data\runtime\python.exe" set "D=%LOCALAPPDATA%\ClickVideo\data"
if not defined D set "D=%LOCALAPPDATA%\ClickVideo"
if not exist "%D%\runtime\python.exe" exit /b 0
"%D%\runtime\python.exe" -I -X utf8 "%~dp0bootstrap.py" hook %1
exit /b 0
