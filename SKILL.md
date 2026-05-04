---
name: qa-ai-validator
description: Valida código generado por IA verificando cumplimiento de SPEC, riesgos, edge cases y calidad. Comandos /qa, /qa-fast, /qa-final para validación incremental durante desarrollo asistido por IA.
trigger: explicit
---

# QA AI Validator

Skill de validación QA para desarrollo asistido por IA. Permite a los desarrolladores validar la calidad del código generado por IA en cualquier momento del ciclo de desarrollo, asegurando cumplimiento del SPEC, detectando riesgos y previniendo errores antes de QA.

> **Activación:** Esta skill se activa explícitamente con los comandos `/qa`, `/qa-fast` o `/qa-final`.

---

## Quick Start

**Validación estándar durante desarrollo:**
```
/qa
```

**Validación rápida (solo críticos):**
```
/qa-fast
```

**Validación completa antes de entregar:**
```
/qa-final
```

---

## ¿Por qué usar esta skill?

- ✅ **Previene errores** antes de que lleguen a QA
- ✅ **Detecta edge cases** no cubiertos por la IA
- ✅ **Valida cumplimiento** del SPEC sin fricción
- ✅ **Identifica riesgos** técnicos y funcionales
- ✅ **Da feedback inmediato** durante el desarrollo
- ✅ **Mejora calidad** del código generado por IA

---

## Contexto Necesario

La skill **SIEMPRE** debe buscar automáticamente en el proyecto:

### 1. SPEC del Feature (obligatorio)

Archivos con nombre que contenga `spec` o `feature`:
- `spec.md`
- `feature-spec.md`
- `[nombre-feature]-spec.md`
- Cualquier archivo que siga el template de SPEC

**Template SPEC esperado:**
```markdown
# Feature: <nombre-del-feature>

## 1. Contexto
## 2. Problema
## 3. Objetivo
## 4. Flujo de usuario
## 5. Criterios de aceptación
## 6. Diseño (opcional)
## 7. Consideraciones técnicas
## 8. Definición de terminado (DoD)
```

### 2. PLAN de Implementación (obligatorio)

Archivos con nombre que contenga `plan`:
- `plan.md`
- `implementation-plan.md`
- `[nombre-feature]-plan.md`
- Cualquier archivo que siga el template de PLAN

**Template PLAN esperado:**
```markdown
# Plan de implementación: <nombre-del-feature>

## 1. Resumen técnico
## 2. Estrategia de implementación
## 3. Tareas
## 4. Uso de IA
## 5. Notas técnicas
## 6. Riesgos / pendientes
```

### 3. Código Generado (obligatorio)

La skill debe analizar:
- **Archivos modificados recientemente** en la conversación
- **Código generado por IA** en los últimos mensajes
- **Cambios en componentes** mencionados en el PLAN

### 4. Contexto del Proyecto (opcional pero recomendado)

Si está disponible:
- Estructura de carpetas (`src/`, `components/`, `containers/`, etc.)
- Patrones del proyecto (ejemplo: Material UI, React Router)
- Convenciones de código existentes
- Dependencias (`package.json`)

---

## Comandos

### `/qa` - Validación Estándar

**Cuándo usar:** Durante el desarrollo, después de que la IA genere código.

**Qué entrega:**

#### 🧪 Cumplimiento de Criterios de Aceptación

Para **CADA** criterio de aceptación del SPEC:

| Estado | Criterio | Evidencia en Código | Observaciones |
|--------|----------|---------------------|---------------|
| ❌ | CA-01: ... | No encontrado | Falta implementar validación X |
| ⚠️ | CA-02: ... | Parcial en `Component.js:45` | Solo valida caso happy path |
| ✅ | CA-03: ... | Implementado en `Service.js:120` | Cumple completamente |

**Leyenda:**
- ❌ **NO cumplido**: El criterio no está implementado
- ⚠️ **Parcialmente cumplido**: El criterio está implementado pero incompleto o con problemas
- ✅ **Cumplido**: El criterio está completamente implementado

#### ⚠️ Riesgos Detectados

**Problemas Funcionales:**
- Lista de comportamientos incorrectos detectados
- Validaciones faltantes
- Flujos incompletos

**Errores Comunes:**
- Manejo de errores faltante
- Validaciones de inputs insuficientes
- Estados inconsistentes
- Problemas de sincronización

**Ejemplos:**
```
❌ No valida que el campo "monto" sea mayor a 0
⚠️ Falta manejo de error si el servicio X falla
❌ No contempla el caso donde el usuario cancela
```

#### 🔍 Edge Cases Faltantes

Lista de casos borde NO cubiertos pero relevantes:

```
❌ ¿Qué pasa si el usuario envía datos vacíos?
❌ ¿Qué pasa si el backend devuelve 500?
❌ ¿Qué pasa con permisos insuficientes?
❌ ¿Qué pasa si la red se cae a mitad de proceso?
❌ ¿Qué pasa con valores extremos (muy grandes, negativos)?
```

#### 🔄 Impacto en Otros Módulos

**Posibles Regresiones:**
- Componentes que pueden verse afectados
- Servicios que comparten lógica
- Rutas o estados globales modificados

**Ejemplo:**
```
⚠️ El cambio en `authService.js` puede afectar:
   - Login flow
   - Token refresh
   - Logout behavior
```

#### 📊 Score de Calidad

**Número de 0 a 100:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Score: 72/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Criterios cumplidos:     60%
Riesgos detectados:      3 críticos, 5 menores
Edge cases cubiertos:    40%
Calidad de código:       70%
```

**Interpretación:**
- **≥ 85**: ✅ Listo para QA
- **70-85**: ⚠️ Necesita revisión (corregir antes de QA)
- **< 70**: ❌ No recomendado avanzar (problemas serios)

#### 🎯 Recomendaciones Accionables

Lista priorizada de qué hacer:

```
1. [CRÍTICO] Agregar validación de monto > 0 en línea X
2. [CRÍTICO] Implementar manejo de error en servicio Y
3. [IMPORTANTE] Cubrir caso de usuario sin permisos
4. [MENOR] Mejorar mensaje de error en Z
```

---

### `/qa-fast` - Validación Rápida

**Cuándo usar:** Iteraciones rápidas, cuando solo necesitas saber si hay problemas graves.

**Qué entrega:**

#### ❌ Problemas Críticos

Solo los problemas que **rompen funcionalidad**:

```
1. ❌ Falta validación de autenticación
2. ❌ No maneja error 500 del backend
3. ❌ Criterio CA-01 no implementado
```

#### ⚠️ Riesgos Principales

Top 3-5 riesgos más importantes:

```
1. ⚠️ Posible regresión en módulo de pagos
2. ⚠️ Falta validación de permisos
3. ⚠️ Edge case: datos vacíos no cubierto
```

#### 📊 Score Rápido

```
Score: 65/100 - ❌ No recomendado avanzar
```

**Sin explicaciones extensas. Solo lo esencial.**

---

### `/qa-final` - Validación Completa

**Cuándo usar:** Antes de entregar a QA, cuando el desarrollo está "terminado".

**Qué entrega:**

#### 🧪 Cumplimiento Total del SPEC

**Análisis detallado criterio por criterio:**

| # | Criterio | Estado | Implementación | Qué Falta para 100% |
|---|----------|--------|----------------|---------------------|
| 1 | CA-01: El usuario debe poder... | ✅ | `Component.js:45-78` | Nada |
| 2 | CA-02: El sistema debe validar... | ⚠️ | `Validator.js:12` | Falta validar caso Y |
| 3 | CA-03: Debe mostrar mensaje... | ❌ | No encontrado | Implementar mensaje de error |

**Resumen:**
- ✅ Cumplidos: 5/10 (50%)
- ⚠️ Parciales: 3/10 (30%)
- ❌ Faltantes: 2/10 (20%)

**Para cumplir 100%:**
```
1. Implementar CA-03 completo
2. Completar validación en CA-02
3. Agregar casos faltantes en CA-07
```

#### ⚠️ Riesgos Completos

**Técnicos:**
```
❌ No hay manejo de concurrencia
⚠️ Consulta SQL puede ser lenta con muchos datos
⚠️ No hay timeout en llamada HTTP
```

**Funcionales:**
```
❌ No contempla usuario con múltiples roles
⚠️ Flujo de cancelación incompleto
```

**UX:**
```
⚠️ Loading state no se muestra en X
❌ Mensaje de error no es claro para el usuario
⚠️ No hay feedback visual al guardar
```

#### 🔍 Edge Cases - Lista Completa

Análisis exhaustivo de casos borde:

**Inputs:**
```
❌ Valores nulos
❌ Strings vacíos
⚠️ Números negativos (parcialmente validado)
❌ Valores extremadamente grandes
✅ Caracteres especiales
```

**Estados:**
```
❌ Usuario sin permisos
⚠️ Sesión expirada
❌ Datos inconsistentes
```

**Red/Backend:**
```
❌ Timeout de red
❌ Error 500/503
⚠️ Respuesta con formato incorrecto
```

**Concurrencia:**
```
❌ Múltiples usuarios editando mismo registro
❌ Doble clic en botón submit
```

#### 🔄 Análisis de Impacto

**Módulos Afectados:**

| Módulo | Tipo de Impacto | Riesgo | Requiere Prueba |
|--------|-----------------|--------|-----------------|
| `AuthService` | Modificado | Alto | ✅ Sí |
| `UserPermissions` | Indirecto | Medio | ✅ Sí |
| `Dashboard` | Consumidor | Bajo | ⚠️ Smoke test |

**Posibles Regresiones:**
```
1. ⚠️ Cambio en authService puede afectar login
2. ❌ Nueva validación puede romper flujo de registro
3. ⚠️ Modificación de estado global puede afectar navbar
```

#### 🧼 Calidad de Código

**Legibilidad:**
```
✅ Nombres de variables claros
⚠️ Función X es muy larga (120 líneas)
❌ Falta documentación en método crítico Y
```

**Mantenibilidad:**
```
⚠️ Lógica de negocio mezclada con UI
❌ Código duplicado en 3 lugares
✅ Componentes bien separados
```

**Buenas Prácticas:**
```
❌ No hay manejo de cleanup en useEffect
⚠️ Falta PropTypes o TypeScript types
✅ Manejo de estados con hooks correcto
```

**Problemas Estructurales:**
```
❌ Componente muy acoplado a servicio X
⚠️ Falta separación de concerns
```

#### 📊 Score Final

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  SCORE FINAL: 78/100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Desglose:
├─ Cumplimiento SPEC:        70/100  ⚠️
├─ Edge Cases:               65/100  ⚠️
├─ Manejo de Errores:        60/100  ⚠️
├─ Calidad de Código:        85/100  ✅
├─ Riesgos Mitigados:        75/100  ⚠️
└─ Impacto Controlado:       90/100  ✅
```

#### 🏁 Veredicto Final

```
⚠️ LISTO CON OBSERVACIONES

El feature puede pasar a QA pero requiere atención en:

[CRÍTICO - Resolver antes de QA]
1. Implementar CA-03 faltante
2. Agregar manejo de error en servicio X

[IMPORTANTE - Resolver pronto]
3. Completar edge cases de validación
4. Documentar método crítico Y

[OPCIONAL - Mejora continua]
5. Refactorizar función larga en Z
6. Separar lógica de negocio de UI
```

**Opciones:**
- ✅ **Listo para QA**: Sin problemas críticos ni importantes
- ⚠️ **Listo con observaciones**: Puede ir a QA pero hay items que resolver
- ❌ **No listo**: Problemas críticos que deben resolverse antes de QA

---

## Reglas de Ejecución

### Comportamiento Obligatorio

1. **No asumir que el código está correcto**
   - Buscar activamente problemas
   - Cuestionar implementaciones
   - Validar contra el SPEC estrictamente

2. **No felicitar ni suavizar críticas**
   - Ser directo y técnico
   - Reportar problemas sin eufemismos
   - Priorizar la detección sobre la diplomacia

3. **Ser crítico y estricto**
   - Aplicar estándares altos
   - No aprobar código mediocre
   - Pensar como QA, no como desarrollador

4. **Priorizar detección de problemas**
   - Objetivo: prevenir errores antes de QA
   - Encontrar edge cases no cubiertos
   - Identificar riesgos ocultos

5. **Ser claro, estructurado y accionable**
   - Usar tablas y listas
   - Dar ejemplos concretos
   - Indicar líneas de código específicas cuando sea posible

### Proceso de Análisis

```
1. LEER CONTEXTO
   ├─ Buscar SPEC del feature
   ├─ Buscar PLAN de implementación
   ├─ Identificar código generado
   └─ Entender estructura del proyecto

2. VALIDAR CUMPLIMIENTO
   ├─ Criterio por criterio del SPEC
   ├─ Buscar evidencia en código
   └─ Marcar estado (✅/⚠️/❌)

3. BUSCAR PROBLEMAS
   ├─ Edge cases no cubiertos
   ├─ Validaciones faltantes
   ├─ Manejo de errores incompleto
   └─ Posibles regresiones

4. EVALUAR CALIDAD
   ├─ Legibilidad
   ├─ Mantenibilidad
   ├─ Buenas prácticas
   └─ Problemas estructurales

5. CALCULAR SCORE
   ├─ Ponderación por categoría
   └─ Interpretación del resultado

6. DAR VEREDICTO
   ├─ Listo / Listo con observaciones / No listo
   └─ Recomendaciones priorizadas
```

### Cálculo del Score

**Ponderación:**
- Cumplimiento de SPEC: 35%
- Edge cases cubiertos: 25%
- Manejo de errores: 20%
- Calidad de código: 10%
- Riesgos mitigados: 10%

**Fórmula:**
```
Score = (criterios_cumplidos * 0.35) +
        (edge_cases_cubiertos * 0.25) +
        (errores_manejados * 0.20) +
        (calidad_codigo * 0.10) +
        (riesgos_mitigados * 0.10)
```

---

## Ejemplos de Uso

### Ejemplo 1: /qa durante desarrollo

**Contexto:** 
- Desarrollador acaba de recibir código de IA para nuevo tipo de rendición
- SPEC tiene 5 criterios de aceptación

**Comando:**
```
/qa
```

**Resultado:**
```
🧪 CUMPLIMIENTO DE CRITERIOS

❌ CA-01: El sistema debe permitir seleccionar "Rendición sin depósito"
   → No encontrado en el código generado
   
⚠️ CA-02: Debe validar que el monto sea mayor a 0
   → Parcialmente implementado en FormValidator.js:45
   → Solo valida > 0, falta validar que sea número
   
✅ CA-03: Debe guardar con el nuevo tipo en BD
   → Implementado en RendicionService.js:120
   
❌ CA-04: Debe mostrar mensaje de éxito
   → No encontrado

⚠️ Riesgos Detectados:
- No valida que el usuario tenga permisos
- Falta manejo de error si el backend falla
- No contempla timeout de red

🔍 Edge Cases Faltantes:
- ¿Qué pasa si el usuario envía formulario vacío?
- ¿Qué pasa si hay error al guardar?

📊 Score: 45/100 - ❌ No recomendado avanzar

🎯 Acciones:
1. [CRÍTICO] Implementar CA-01 y CA-04
2. [CRÍTICO] Completar validación en CA-02
3. [IMPORTANTE] Agregar manejo de errores
```

### Ejemplo 2: /qa-fast en iteración rápida

**Comando:**
```
/qa-fast
```

**Resultado:**
```
❌ Problemas Críticos:
1. CA-01 no implementado (tipo de rendición)
2. No maneja error de backend
3. Falta validación de permisos

⚠️ Riesgos Principales:
1. Posible regresión en lista de facturas
2. Edge case: formulario vacío no cubierto

📊 Score: 45/100 - ❌ No recomendado avanzar
```

### Ejemplo 3: /qa-final antes de QA

**Comando:**
```
/qa-final
```

**Resultado:**
```
🧪 CUMPLIMIENTO TOTAL DEL SPEC

| # | Criterio | Estado | Archivo:Línea |
|---|----------|--------|---------------|
| 1 | CA-01... | ✅ | FormComponent.js:45 |
| 2 | CA-02... | ⚠️ | Validator.js:12 |
| 3 | CA-03... | ✅ | Service.js:120 |
| 4 | CA-04... | ✅ | FormComponent.js:89 |
| 5 | CA-05... | ❌ | No encontrado |

Para cumplir 100%:
- Implementar CA-05 (notificación por email)
- Completar validación numérica en CA-02

⚠️ Riesgos:
[Técnicos]
- No hay manejo de concurrencia
- Falta timeout en API call

[Funcionales]
- No contempla usuario con rol limitado

[UX]
- Loading state no se muestra

🔍 Edge Cases - Lista Completa:
[...análisis exhaustivo...]

🔄 Impacto:
- RendicionService: modificado (requiere prueba completa)
- ListaRendiciones: consumidor (requiere smoke test)

🧼 Calidad de Código:
✅ Nombres claros
⚠️ FormComponent muy largo (150 líneas)
❌ Falta documentación en handleSubmit

📊 Score Final: 82/100

🏁 Veredicto: ⚠️ LISTO CON OBSERVACIONES

[CRÍTICO]
1. Implementar CA-05

[IMPORTANTE]  
2. Completar validación en CA-02
3. Agregar manejo de errores

[OPCIONAL]
4. Refactorizar FormComponent
5. Documentar métodos críticos
```

---

## Preguntas Frecuentes

### ¿Cuándo debo usar cada comando?

- **Durante desarrollo iterativo**: `/qa` después de cada generación de código
- **Validación rápida**: `/qa-fast` cuando solo quieres saber si hay bloqueantes
- **Antes de entregar**: `/qa-final` cuando crees que está listo para QA

### ¿Qué pasa si no encuentra el SPEC o PLAN?

La skill DEBE solicitarlo:
```
⚠️ No encontré el SPEC del feature.
   
Por favor, proporciona:
1. Ruta al archivo SPEC (ej: docs/feature-spec.md)
   O
2. Criterios de aceptación que debo validar
```

### ¿Funciona si el código no fue generado por IA?

Sí. La skill valida cualquier código contra el SPEC. Es especialmente útil para código de IA porque tiende a omitir edge cases y validaciones.

### ¿Qué tan estricto es el score?

Muy estricto. Un 70/100 significa que hay problemas importantes. La idea es prevenir, no aprobar código mediocre.

### ¿Puede la skill modificar código?

No. La skill solo analiza y reporta. El desarrollador decide qué corregir.

---

## Integración con el Flujo de Trabajo

### Workflow Recomendado

```
1. Crear SPEC + PLAN
   ↓
2. Desarrollo asistido por IA
   ↓
3. /qa (validación incremental)
   ↓
4. Corregir problemas detectados
   ↓
5. Repetir 2-4 hasta score > 70
   ↓
6. /qa-final
   ↓
7. Resolver críticos e importantes
   ↓
8. Entregar a QA
```

### Buenas Prácticas

✅ **Hacer:**
- Usar `/qa` frecuentemente durante desarrollo
- Corregir problemas críticos inmediatamente
- Documentar decisiones en PLAN
- Usar `/qa-final` antes de cada entrega

❌ **Evitar:**
- Ignorar warnings del `/qa`
- Entregar con score < 70
- Asumir que la IA lo hizo todo bien
- Saltarse validación de edge cases

---

## Limitaciones

1. **La skill NO reemplaza QA humano**
   - Solo detecta problemas obvios y verificables
   - No valida UX/UI visual
   - No ejecuta el código

2. **Requiere SPEC bien definido**
   - Sin criterios claros, la validación es limitada

3. **Depende del contexto disponible**
   - Si no tiene acceso al código completo, puede omitir problemas

4. **No detecta bugs de runtime**
   - Solo analiza código estático

---

## Personalización por Proyecto

La skill puede adaptarse a convenciones específicas:

### Ubicación de Archivos

Si tu proyecto usa estructura diferente, puedes indicar:
```
Los SPEC están en: docs/features/
Los PLAN están en: docs/implementation/
```

### Criterios de Score

Si necesitas ser más/menos estricto:
```
En este proyecto, score mínimo para QA es 80 (no 85)
```

### Tecnologías Específicas

Si usas tecnologías específicas:
```
Este proyecto usa:
- React + Material-UI
- Redux para estado global
- Axios para HTTP
```

---

## Soporte

Esta skill está diseñada para todo el equipo de desarrollo.

**Si la skill no funciona:**
1. Verifica que exista archivo SPEC con criterios de aceptación
2. Verifica que exista archivo PLAN
3. Asegúrate de que el código a validar esté en el contexto

**Para reportar problemas:**
- Indica qué comando usaste (`/qa`, `/qa-fast`, `/qa-final`)
- Comparte el SPEC y PLAN del feature
- Indica qué esperabas vs. qué obtuviste

---

## Changelog

### v1.0.0
- ✅ Comandos `/qa`, `/qa-fast`, `/qa-final`
- ✅ Validación de criterios de aceptación
- ✅ Detección de edge cases
- ✅ Análisis de riesgos
- ✅ Cálculo de score de calidad
- ✅ Veredicto con recomendaciones accionables
