#!/bin/bash

echo "================================================"
echo "  Instalador QA AI Validator Skill"
echo "================================================"
echo ""

# Detectar directorio del workspace
WORKSPACE_DIR=$(pwd)

# Verificar si existe .agents
if [ ! -d "$WORKSPACE_DIR/.agents" ]; then
    echo "[ERROR] No se encontró la carpeta .agents en el directorio actual"
    echo ""
    echo "Asegúrate de estar en la raíz de tu proyecto y que:"
    echo "  - Tengas VS Code abierto en este proyecto"
    echo "  - Hayas usado skills de GitHub Copilot antes"
    echo ""
    exit 1
fi

echo "[1/3] Creando estructura de directorios..."
mkdir -p "$WORKSPACE_DIR/.agents/skills/qa-ai-validator"

echo "[2/3] Descargando skill desde GitHub..."
curl -fsSL "https://raw.githubusercontent.com/jsazo-bit/QA-AI-Validator-Repo/main/SKILL.md" \
    -o "$WORKSPACE_DIR/.agents/skills/qa-ai-validator/SKILL.md"

if [ ! -f "$WORKSPACE_DIR/.agents/skills/qa-ai-validator/SKILL.md" ]; then
    echo "[ERROR] No se pudo descargar SKILL.md"
    exit 1
fi

echo "[3/3] Actualizando skills-lock.json..."

SKILLS_LOCK="$WORKSPACE_DIR/skills-lock.json"

if [ -f "$SKILLS_LOCK" ]; then
    # Verificar si Python está disponible
    if command -v python3 &> /dev/null; then
        python3 << EOF
import json
with open('$SKILLS_LOCK', 'r') as f:
    data = json.load(f)
if not any(s.get('name') == 'qa-ai-validator' for s in data.get('skills', [])):
    data.setdefault('skills', []).append({
        'name': 'qa-ai-validator',
        'version': '1.0.0',
        'source': 'github'
    })
    with open('$SKILLS_LOCK', 'w') as f:
        json.dump(data, f, indent=2)
EOF
    elif command -v node &> /dev/null; then
        node << EOF
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('$SKILLS_LOCK', 'utf8'));
if (!data.skills.some(s => s.name === 'qa-ai-validator')) {
    data.skills.push({ name: 'qa-ai-validator', version: '1.0.0', source: 'github' });
    fs.writeFileSync('$SKILLS_LOCK', JSON.stringify(data, null, 2));
}
EOF
    else
        echo "[AVISO] No se pudo actualizar skills-lock.json automáticamente"
        echo "Agrega manualmente esta entrada:"
        echo '{"name": "qa-ai-validator", "version": "1.0.0", "source": "github"}'
    fi
else
    echo "[AVISO] No se encontró skills-lock.json"
fi

echo ""
echo "================================================"
echo "  INSTALACIÓN COMPLETADA"
echo "================================================"
echo ""
echo "La skill QA AI Validator ha sido instalada exitosamente!"
echo ""
echo "Comandos disponibles:"
echo "  /qa       - Validación estándar (10s)"
echo "  /qa-fast  - Validación rápida (3s)"
echo "  /qa-final - Validación completa (15s)"
echo ""
echo "IMPORTANTE: Recarga VS Code para que la skill se active"
echo "  - Presiona Cmd+Shift+P (Mac) o Ctrl+Shift+P (Linux)"
echo "  - Escribe 'Reload Window'"
echo "  - Presiona Enter"
echo ""
