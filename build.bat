@echo off
chcp 65001 >nul
cls

echo ========================================================
echo        正在配置 GitHub 云端构建 (GitHub Actions)
echo ========================================================

:: 1. 创建必要的文件夹结构
if not exist ".github" md ".github"
if not exist ".github\workflows" md ".github\workflows"

echo [V] 目录 .github\workflows 已就绪

:: 2. 写入 build.yml 文件
:: 注意：下面的写入过程严格保留了 YAML 的缩进格式

(
echo name: Build UI Vision ^(Gemini Mod^)
echo.
echo on:
echo   push:
echo     branches: [ main, master ]
echo   workflow_dispatch:
echo.
echo jobs:
echo   build:
echo     runs-on: ubuntu-latest
echo.
echo     steps:
echo     - name: Checkout Code
echo       uses: actions/checkout@v3
echo.
echo     - name: Setup Node.js
echo       uses: actions/setup-node@v3
echo       with:
echo         node-version: '18'
echo.
echo     - name: Install Dependencies ^(Force^)
echo       run: npm install --force
echo.
echo     - name: Build Project
echo       run: npm run build
echo.
echo     - name: Zip Dist Folder
echo       run: ^|
echo         cd dist
echo         zip -r ../ui-vision-gemini.zip ./*
echo.
echo     - name: Upload Artifact
echo       uses: actions/upload-artifact@v3
echo       with:
echo         name: ui-vision-gemini-build
echo         path: ui-vision-gemini.zip
) > ".github\workflows\build.yml"

echo [V] 配置文件 .github\workflows\build.yml 已生成
echo.
echo ========================================================
echo [!] 配置已完成！接下来请执行以下步骤：
echo ========================================================
echo.
echo 1. 在 GitHub 上新建一个仓库 (建议选 Private 私有)。
echo.
echo 2. 在当前目录打开终端 (CMD 或 Git Bash)，执行推送到云端：
echo    git add .
echo    git commit -m "Add GitHub Actions"
echo    git branch -M main
echo    git remote add origin ^<你的仓库地址^>
echo    git push -u origin main
echo.
echo 3. 推送成功后，去 GitHub 仓库的 "Actions" 标签页下载成品。
echo.
pause