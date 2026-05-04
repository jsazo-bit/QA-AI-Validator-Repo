#!/usr/bin/env node

const https = require('https');
const fs = require('fs');
const path = require('path');

console.log('\n================================================');
console.log('  QA AI Validator Skill - Instalador');
console.log('================================================\n');

// Detectar directorio del workspace
const workspaceDir = process.cwd();
const agentsDir = path.join(workspaceDir, '.agents');
const skillsDir = path.join(agentsDir, 'skills', 'qa-ai-validator');
const skillsLockPath = path.join(workspaceDir, 'skills-lock.json');

// Verificar si existe .agents
if (!fs.existsSync(agentsDir)) {
    console.error('[ERROR] No se encontró la carpeta .agents en el directorio actual\n');
    console.log('Asegúrate de estar en la raíz de tu proyecto y que:');
    console.log('  - Tengas VS Code abierto en este proyecto');
    console.log('  - Hayas usado skills de GitHub Copilot antes\n');
    process.exit(1);
}

console.log('[1/3] Creando estructura de directorios...');
if (!fs.existsSync(skillsDir)) {
    fs.mkdirSync(skillsDir, { recursive: true });
}

console.log('[2/3] Descargando skill desde GitHub...');

const skillUrl = 'https://raw.githubusercontent.com/jsazo-bit/QA-AI-Validator-Repo/main/SKILL.md';
const skillPath = path.join(skillsDir, 'SKILL.md');

https.get(skillUrl, (res) => {
    if (res.statusCode !== 200) {
        console.error(`[ERROR] No se pudo descargar SKILL.md (Status: ${res.statusCode})`);
        process.exit(1);
    }

    const fileStream = fs.createWriteStream(skillPath);
    res.pipe(fileStream);

    fileStream.on('finish', () => {
        fileStream.close();
        console.log('[3/3] Actualizando skills-lock.json...');

        // Actualizar skills-lock.json
        if (fs.existsSync(skillsLockPath)) {
            try {
                const skillsLock = JSON.parse(fs.readFileSync(skillsLockPath, 'utf8'));
                
                // Verificar si la skill ya existe
                const skillExists = skillsLock.skills && 
                    skillsLock.skills.some(s => s.name === 'qa-ai-validator');

                if (!skillExists) {
                    if (!skillsLock.skills) {
                        skillsLock.skills = [];
                    }
                    
                    skillsLock.skills.push({
                        name: 'qa-ai-validator',
                        version: '1.0.0',
                        source: 'github'
                    });

                    fs.writeFileSync(skillsLockPath, JSON.stringify(skillsLock, null, 2));
                    console.log('✅ skills-lock.json actualizado');
                } else {
                    console.log('ℹ️  Skill ya estaba registrada en skills-lock.json');
                }
            } catch (error) {
                console.warn('[AVISO] Error al actualizar skills-lock.json:', error.message);
            }
        } else {
            console.warn('[AVISO] No se encontró skills-lock.json');
        }

        console.log('\n================================================');
        console.log('  ✅ INSTALACIÓN COMPLETADA');
        console.log('================================================\n');
        console.log('La skill QA AI Validator ha sido instalada exitosamente!\n');
        console.log('Comandos disponibles:');
        console.log('  /qa       - Validación estándar (10s)');
        console.log('  /qa-fast  - Validación rápida (3s)');
        console.log('  /qa-final - Validación completa (15s)\n');
        console.log('⚠️  IMPORTANTE: Recarga VS Code para que la skill se active');
        console.log('  - Presiona Ctrl+Shift+P (Cmd+Shift+P en Mac)');
        console.log('  - Escribe "Reload Window"');
        console.log('  - Presiona Enter\n');
    });

}).on('error', (err) => {
    console.error('[ERROR] No se pudo descargar SKILL.md:', err.message);
    process.exit(1);
});
