# Commits Convencionales

Este proyecto sigue el estándar de [Commits Convencionales](https://www.conventionalcommits.org/es/).

## Formato

```
<tipo>[scope]: <descripción>

[cuerpo]

[footer]
```

## Tipos de Commit

- **feat**: Nueva funcionalidad
- **fix**: Corrección de bug
- **docs**: Cambios en documentación
- **style**: Cambios de formato/estilo
- **refactor**: Refactorización sin cambios funcionales
- **perf**: Mejoras de rendimiento
- **test**: Adición o cambios en tests
- **chore**: Cambios en configuración o dependencias
- **ci**: Cambios en CI/CD

## Ejemplos

```bash
feat(instalador): agregar soporte para Cosmos panel
fix(herramientas): corregir descarga de Firefox fix
docs(README): actualizar instrucciones de instalación
refactor(config): mejorar sistema de logging
```

## Scope (Opcional)

- `instalador` - Scripts principales
- `herramientas` - Scripts de herramientas
- `config` - Configuración centralizada
- `docs` - Documentación
- `ci` - Pipeline de CI/CD

## Ejemplo Completo

```
feat(instalador): agregar validación de conexión internet

- Verificar conexión antes de descargar scripts
- Agregar reintentos automáticos en caso de fallos
- Mejorar mensajes de error

Closes #123
```
