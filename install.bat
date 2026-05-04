@echo off
setlocal enabledelayedexpansion

echo ================================================
echo   Instalador QA AI Validator Skill
echo ================================================
echo.

REM Detectar directorio del workspace
set "WORKSPACE_DIR=%CD%"

REM Verificar si existe .agents
if not exist "%WORKSPACE_DIR%\.agents" (
    echo [ERROR] No se encontro la carpeta .agents en el directorio actual
    echo.
    echo Asegurate de estar en la raiz de tu proyecto y que:
    echo   - Tengas VS Code abierto en este proyecto
    echo   - Hayas usado skills de GitHub Copilot antes
    echo.
    pause
    exit /b 1
)

echo [1/3] Creando estructura de directorios...
if not exist "%WORKSPACE_DIR%\.agents\skills\qa-ai-validator" (
    mkdir "%WORKSPACE_DIR%\.agents\skills\qa-ai-validator"
)

echo [2/3] Descargando skill desde GitHub...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/jsazo-bit/qa-ai-validator-skill/main/SKILL.md' -OutFile '%WORKSPACE_DIR%\.agents\skills\qa-ai-validator\SKILL.md'"

if not exist "%WORKSPACE_DIR%\.agents\skills\qa-ai-validator\SKILL.md" (
    echo [ERROR] No se pudo descargar SKILL.md
    pause
    exit /b 1
)

echo [3/3] Actualizando skills-lock.json...

REM Leer skills-lock.json actual
set "SKILLS_LOCK=%WORKSPACE_DIR%\skills-lock.json"

if exist "%SKILLS_LOCK%" (
    REM Agregar entrada usando PowerShell
    powershell -Command ^
    "$json = Get-Content '%SKILLS_LOCK%' | ConvertFrom-Json; ^
    if (-not ($json.skills | Where-Object { $_.name -eq 'qa-ai-validator' })) { ^
        $newSkill = @{ name = 'qa-ai-validator'; version = '1.0.0'; source = 'github' }; ^
        $json.skills += $newSkill; ^
        $json | ConvertTo-Json -Depth 10 | Set-Content '%SKILLS_LOCK%' ^
    }"
) else (
    echo [AVISO] No se encontro skills-lock.json
    echo La skill fue instalada, pero necesitas agregarla manualmente al archivo skills-lock.json
    echo.
)

echo.
echo ================================================
echo   INSTALACION COMPLETADA
echo ================================================
echo.
echo La skill QA AI Validator ha sido instalada exitosamente!
echo.
echo Comandos disponibles:
echo   /qa       - Validacion estandar (10s)
echo   /qa-fast  - Validacion rapida (3s)
echo   /qa-final - Validacion completa (15s)
echo.
echo IMPORTANTE: Recarga VS Code para que la skill se active
echo   - Presiona Ctrl+Shift+P
echo   - Escribe "Reload Window"
echo   - Presiona Enter
echo.
pause
