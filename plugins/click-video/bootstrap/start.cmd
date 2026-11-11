@echo off
rem CLICK Video: starts the plugin with the official Python from python.org. Plain text, nothing compiled: read it.
rem First run: download Python's embeddable package, check its SHA-256 (published by python.org), unpack it.
rem Every run: start bootstrap.py (also plain text), which speaks MCP to Claude Code and fetches the engine for a valid key.
rem Nothing may be printed on stdout: it is the channel to Claude Code. Messages go to stderr.
rem Downloads work inside the data folder with short relative names, so a user folder with spaces or Vietnamese letters
rem (C:\Users\Nguyen Van A, or a name with Vietnamese letters) never reaches curl, certutil or tar as a full path.
setlocal EnableExtensions
set "D=%CLAUDE_PLUGIN_DATA%"
if not defined D set "D=%PLUGIN_DATA%"
if not defined D set "D=%LOCALAPPDATA%\ClickVideo"
set "PY=%D%\runtime\python.exe"
rem The customer moved the heavy data to another drive (tool chon_thu_muc_du_lieu): Python was copied there and linked as
rem runtime.next while it was running. Swap it in now; if another window still runs the old one, the rename fails and we
rem keep using the old one until the next start. bootstrap.py deletes runtime.old.
if not exist "%D%\runtime.next\python.exe" goto swapped
if exist "%PY%" ren "%D%\runtime" runtime.old 1>nul 2>nul
if not exist "%PY%" ren "%D%\runtime.next" runtime 1>nul 2>nul
:swapped
if exist "%PY%" goto run

set "URL=https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip"
set "SHA=4acbed6dd1c744b0376e3b1cf57ce906f9dc9e95e68824584c8099a63025a3c3"
if not exist "%D%\cache" mkdir "%D%\cache"
if not exist "%D%\runtime" mkdir "%D%\runtime"
pushd "%D%\cache" || (echo CLICK: khong mo duoc thu muc du lieu 1>&2 & exit /b 1)
curl.exe -sSfL --retry 3 -o python-embed.zip "%URL%" 1>nul 2>nul
if errorlevel 1 (popd & echo CLICK: khong tai duoc Python tu python.org 1>&2 & exit /b 1)
set "GOT="
for /f "skip=1 delims=" %%h in ('certutil -hashfile python-embed.zip SHA256') do if not defined GOT set "GOT=%%h"
set "GOT=%GOT: =%"
if /i not "%GOT%"=="%SHA%" (del python-embed.zip & popd & echo CLICK: ma kiem tra cua Python khong khop, da xoa tep tai ve 1>&2 & exit /b 1)
tar.exe -xf python-embed.zip -C ..\runtime 1>nul 2>nul
if errorlevel 1 (popd & echo CLICK: khong giai nen duoc Python 1>&2 & exit /b 1)
popd
rem site-packages on: the engine's libraries go there (Lib, DLLs: tkinter, added later by the installer)
(echo.& echo Lib& echo DLLs& echo import site)>>"%D%\runtime\python312._pth"
if not exist "%D%\runtime\Lib\site-packages" mkdir "%D%\runtime\Lib\site-packages"

:run
"%PY%" -I -X utf8 "%~dp0bootstrap.py" %*
