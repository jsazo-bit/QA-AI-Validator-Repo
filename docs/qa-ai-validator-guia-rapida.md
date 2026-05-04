# 🚀 Guía Rápida: QA AI Validator

## ¿Qué es esto?

Una skill que te ayuda a **validar código generado por IA** para que QA no te devuelva cosas básicas.

**No es un proceso. No es obligatorio. Es una ayuda.**

---

## Comandos (3 segundos cada uno)

### Durante desarrollo
```
/qa
```
→ Te dice qué está mal con el código que acaba de generar la IA

### Iteraciones rápidas
```
/qa-fast
```
→ Solo te dice lo crítico (sin detalles)

### Antes de entregar
```
/qa-final
```
→ Validación completa antes de que QA lo vea

---

## Qué necesitas ANTES de usar la skill

1. **Archivo SPEC** (plantilla en `docs/templates/spec.template.md`)
   - Copia la plantilla
   - Llena los criterios de aceptación
   - Guárdalo como `[feature]-spec.md`

2. **Archivo PLAN** (plantilla en `docs/templates/plan.template.md`)
   - Copia la plantilla
   - Define las tareas
   - Guárdalo como `[feature]-plan.md`

3. **Código generado por IA**
   - Ya lo tienes en tu conversación con Copilot

---

## Ejemplo Real

### Paso 1: Tienes tu SPEC
```markdown
# Feature: Nuevo tipo de rendición

## 5. Criterios de aceptación

* [ ] CA-01: El usuario debe poder seleccionar "Sin depósito"
* [ ] CA-02: El sistema debe validar que el monto sea > 0
* [ ] CA-03: Debe guardar correctamente en BD
```

### Paso 2: Le pides código a la IA
```
"Genera el componente para crear rendiciones con el nuevo tipo"
```

### Paso 3: La IA te da código

### Paso 4: Validar con la skill
```
/qa
```

### Paso 5: La skill te responde
```
❌ CA-01: No implementado - falta opción "Sin depósito" en el select
⚠️ CA-02: Parcialmente - valida > 0 pero no valida que sea número
✅ CA-03: OK - implementado en línea 45

⚠️ Riesgos:
- No valida que el usuario tenga permisos
- Falta manejo de error si el backend falla

📊 Score: 45/100 - ❌ No recomendado avanzar

🎯 Haz esto:
1. Agregar opción "Sin depósito" al select
2. Mejorar validación de monto
3. Agregar manejo de error
```

### Paso 6: Le pides a la IA que corrija
```
"Corrige los problemas que detectó /qa"
```

### Paso 7: Validar de nuevo
```
/qa-fast
```

### Paso 8: Repetir hasta score > 70

### Paso 9: Antes de entregar
```
/qa-final
```

---

## ¿Qué obtienes?

**Antes (sin la skill):**
- QA te devuelve 10 bugs básicos
- 3 días perdidos en ir y venir

**Después (con la skill):**
- Detectas esos 10 bugs ANTES
- QA encuentra cosas más complejas
- Menos rebotes

---

## Tips para adopción

### ✅ Hacer
- Usa `/qa-fast` cuando tengas prisa → solo ves lo crítico
- Usa `/qa` durante desarrollo → feedback continuo
- Usa `/qa-final` antes de entregar → checklist completo

### ❌ Evitar
- No uses la skill sin tener el SPEC con criterios claros
- No ignores los problemas críticos (❌)
- No entregues con score < 70

---

## FAQ

**¿Es obligatorio?**
No. Pero te va a ahorrar tiempo.

**¿Funciona con código que no hice con IA?**
Sí. Valida cualquier código contra el SPEC.

**¿La skill puede modificar mi código?**
No. Solo analiza y te dice qué está mal. Tú decides qué corregir.

**¿Qué pasa si no tengo SPEC?**
La skill no puede validar criterios que no existen. Primero crea el SPEC.

**¿El score es muy estricto?**
Sí, a propósito. Un 70/100 significa que hay problemas importantes.

**¿Puedo configurarlo para mi feature?**
Sí. Solo dile a la skill dónde está tu SPEC y PLAN.

---

## Flujo Recomendado

```
1. Crear SPEC + PLAN
   ↓
2. Pedir código a IA
   ↓
3. /qa
   ↓
4. Corregir problemas
   ↓
5. Repetir 2-4 hasta score > 70
   ↓
6. /qa-final
   ↓
7. Resolver críticos
   ↓
8. Entregar a QA
```

---

## Primer Uso (Ahora)

1. Copia `docs/templates/spec.template.md`
2. Llena los criterios de aceptación de tu feature actual
3. Genera código con IA
4. Escribe `/qa`
5. Mira qué problemas detecta
6. Decide si es útil

**Si detecta algo que te habría encontrado QA → ya valió la pena.**

---

## Soporte

Si la skill no funciona:
1. ¿Existe el archivo SPEC con criterios de aceptación?
2. ¿Existe el archivo PLAN?
3. ¿El código a validar está en la conversación?

Si aún así no funciona, reporta el problema con ejemplos.

---

## Métricas de Éxito

**Esto está funcionando si:**
- Reduces rebotes de QA en un 30%+
- Detectas edge cases que antes no veías
- El equipo lo usa sin que se lo recuerdes

**No esperes:**
- Que todos lo usen desde el día 1
- Que reemplace a QA
- Que sea perfecto

---

## ¿Por qué esto sí va a funcionar?

✅ No agrega fricción  
✅ No cambia herramientas  
✅ No es obligatorio  
✅ Da valor inmediato  
✅ Es rápido  

**Ese combo es el que genera adopción.**
