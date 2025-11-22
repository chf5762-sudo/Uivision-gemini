@echo off
chcp 65001 >nul
cls

echo ========================================================
echo        UI Vision Builder (Force Mode)
echo ========================================================

:: 1. 检查 node_modules 是否存在
if exist "node_modules" goto :start_build

echo [!] First run detected. Installing dependencies...
echo [!] Using --force to resolve dependency conflicts...
:: 🔴 关键修改：加了 --force 参数
call npm install --force
if %errorlevel% neq 0 goto :install_fail

:start_build
echo.
echo [!] Starting Build Process...
call npm run build

if %errorlevel% equ 0 goto :success

:: 如果构建失败，尝试重新安装一次
echo.
echo [!] Build failed. Retrying installation with Force...
call npm install --force
call npm run build

if %errorlevel% equ 0 goto :success

:fail
color 0C
echo.
echo [X] FATAL ERROR: Build failed again.
echo Please check the error message above.
pause
exit /b

:install_fail
color 0C
echo [X] npm install failed. 
echo This might be a network issue, or you need a VPN.
pause
exit /b

:success
color 0A
echo.
echo ========================================================
echo [V] SUCCESS! Build Complete.
echo Go to Chrome extensions page and click Refresh.
echo ========================================================
echo.
pause