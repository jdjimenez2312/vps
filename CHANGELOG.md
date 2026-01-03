# Changelog

Todas las notas de cambio importantes de este proyecto se documentan aquí.

## [1.0.0] - 2026-01-03

### ✨ Agregado
- Sistema de configuración centralizado (`config.sh`)
  - Funciones comunes reutilizables
  - Gestión de colores y mensajes
  - Sistema de logging automático
  
- Script de validación del sistema (`validate.sh`)
  - Verifica requisitos del sistema
  - Detecta problemas antes de instalar
  - Genera reporte detallado

- Script principal mejorado (`install.sh`)
  - Menú principal unificado
  - Flujo de instalación simplificado
  - Mejor manejo de errores

- Sistema de logging avanzado
  - Logs en `/var/log/vps-installer/`
  - Timestamps y niveles de severidad
  - Trazabilidad completa

- Mejoras en seguridad
  - Validación de permisos (root)
  - Verificación de conexión internet
  - Confirmación antes de operaciones críticas
  - Manejo robusto de errores

### 🎨 Mejorado
- Interfaz de usuario con colores y emojis
- Mensajes de error más descriptivos
- Menús interactivos claros
- Documentación expandida

### 📖 Documentación
- README.md completamente revisado
- TROUBLESHOOTING.md - Solución de problemas
- ARCHITECTURE.md - Documentación técnica
- CONTRIBUTING.md - Guía de contribución
- LICENSE - Licencia GPL-3.0

### 🔧 Configuración
- Archivo VERSION para control de versiones
- .gitignore actualizado
- Estructura de proyecto organizada

### 📝 Cambios técnicos
- `set -euo pipefail` en todos los scripts
- Funciones de logging centralizadas
- Variables de repositorio parametrizadas
- Mejoras en manejo de descargas
- Sistema de confirmación interactivo

---

## Guía de Versioning

Este proyecto sigue [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH** (ejemplo: 1.0.0)
- **MAJOR**: Cambios incompatibles
- **MINOR**: Nuevas funcionalidades compatibles
- **PATCH**: Correcciones de bugs

---

## Historial de Versiones

### v0.1.0 (Pre-Release)
- Versión inicial básica
- Menús simples sin validaciones
- Sin sistema de logging
- Documentación mínima

### v1.0.0 (Release Estable)
- Todas las mejoras documentadas arriba
- Sistema robusto y production-ready
- Documentación completa
- Tests de validación incluidos

---

## Planificación de Futuras Versiones

### v1.1.0 (Próxima)
- [ ] Soporte para más paneles
- [ ] Herramientas adicionales
- [ ] Mejoras de rendimiento

### v2.0.0
- [ ] Dashboard web
- [ ] API REST
- [ ] Soporte multi-idioma
- [ ] Sistema de rollback

---

## Notas de Migración

No hay cambios rompedores en v1.0.0. La actualización desde v0.x es directa.

```bash
# Actualizar repo
cd vps
git pull origin main

# Usar nueva versión
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/install.sh)"
```

---

## Contribuciones

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para enviar cambios.

---

Última actualización: Enero 3, 2026
