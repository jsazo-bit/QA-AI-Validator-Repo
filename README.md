# QA AI Validator Skill

Skill de validación de código generado por IA para VS Code Copilot.

## 🚀 Instalación en Un Comando

### Windows (PowerShell)
```powershell
powershell -c "irm https://raw.githubusercontent.com/jsazo-bit/qa-ai-validator-skill/main/install.bat -OutFile install.bat; .\install.bat"
```

### Linux/Mac
```bash
curl -fsSL https://raw.githubusercontent.com/jsazo-bit/qa-ai-validator-skill/main/install.sh | bash
```

## 📋 Comandos Disponibles

- `/qa` - Validación estándar durante desarrollo (10s)
- `/qa-fast` - Validación rápida, solo críticos (3s)
- `/qa-final` - Validación completa antes de QA (15s)

## 📊 Sistema de Scoring

- **≥85%**: ✅ Listo para QA
- **70-84%**: ⚠️ Requiere revisión
- **<70%**: ❌ No avanzar

## 📖 Documentación

Ver [Guía Rápida](docs/qa-ai-validator-guia-rapida.md) para uso detallado.

## ⚙️ Requisitos

- VS Code con GitHub Copilot
- Archivos SPEC con criterios de aceptación
- (Opcional) Archivo PLAN para contexto adicional

## 🔄 Flujo de Trabajo

1. IA implementa feature
2. Ejecutar `/qa-fast` (3s - chequeo rápido)
3. Corregir issues críticos
4. Ejecutar `/qa` (10s - validación completa)
5. Antes de enviar a QA: `/qa-final` (15s - análisis profundo)

## 🤝 Contribuir

Issues y PRs bienvenidos en este repositorio.

## 📄 Licencia

MIT
