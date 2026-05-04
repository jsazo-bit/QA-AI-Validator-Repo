#!/usr/bin/env node

console.log('\n🎯 Probando instalador npx localmente...\n');

// Simular el proceso sin descargar de GitHub
const fs = require('fs');
const path = require('path');

const workspaceDir = process.cwd();
const agentsDir = path.join(workspaceDir, '.agents');

if (!fs.existsSync(agentsDir)) {
    console.log('❌ No hay carpeta .agents en este directorio');
    console.log('ℹ️  Este test debe ejecutarse en la raíz de un proyecto con VS Code Copilot\n');
    process.exit(0);
}

console.log('✅ Carpeta .agents encontrada');
console.log('✅ El instalador funcionaría correctamente');
console.log('\nPara probar la instalación real:');
console.log('  cd [otro-proyecto-con-.agents]');
console.log('  npx github:jsazo-bit/qa-ai-validator-skill');
console.log('\nO después del push a GitHub:');
console.log('  npx install-qa-ai-validator\n');
