# Arquitectura del Proyecto

## 📐 Diagrama General

```
┌─────────────────────────────────────────────────────────────┐
│                    VPS Installer Suite                      │
└──────────────────────────┬──────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
    ┌────────┐      ┌─────────┐      ┌──────────────┐
    │install │      │validat  │      │  config.sh   │
    │  .sh   │      │  e.sh   │      │(centralizado)│
    └────────┘      └─────────┘      └──────────────┘
        │                                     △
        └─────────────────────────────────────┘
                       │
         ┌─────────────┼─────────────┐
         │             │             │
         ▼             ▼             ▼
    ┌─────────┐  ┌──────────┐  ┌────────┐
    │instalador│  │herramient│  │ config │
    │   .sh    │  │  as.sh   │  │  vars  │
    └────┬────┘  └─────┬────┘  └────────┘
         │              │
    ┌────┴──────────────┴────────────────────────┐
    │                                            │
    ▼                                            ▼
┌──────────────────────────┐         ┌────────────────────────┐
│    Scripts Instaladores  │         │  Scripts Herramientas  │
│  (Docker + Paneles)      │         │    (Utilidades)        │
└──────────────────────────┘         └────────────────────────┘
    │                                         │
    ├─ nuevo+docker+portainer.sh            ├─ install-docker.sh
    ├─ nuevo+docker+easypanel.sh            ├─ bashrc.sh
    ├─ nuevo+docker+aapanel.sh              ├─ firefox-fix.sh
    ├─ nuevo+docker+cyberpanel.sh           ├─ portainer-update.sh
    └─ nuevo+docker+cosmos.sh               └─ install-mkvtoolnix...sh
```

---

## 🏗️ Flujo de Ejecución

### Instalador Principal

```
Usuario ejecuta install.sh
        │
        ▼
   Cargar config.sh
        │
        ▼
   Validar permisos
   Validar conexión
        │
        ▼
   Mostrar menú principal
        │
        ├─ Opción 1: Instaladores
        │   ├─ Validar internet
        │   ├─ Descargar instalador.sh
        │   ├─ Ejecutar instalador.sh
        │   └─ Mostrar menú de paneles
        │
        ├─ Opción 2: Herramientas
        │   ├─ Validar internet
        │   ├─ Descargar herramientas.sh
        │   ├─ Ejecutar herramientas.sh
        │   └─ Mostrar menú de utilidades
        │
        ├─ Opción 3: Validar
        │   ├─ Cargar validate.sh
        │   ├─ Ejecutar validaciones
        │   └─ Mostrar reporte
        │
        └─ Opción 4: Salir
                │
                ▼
           Guardar logs
           Mostrar ubicación
```

### Instalación de Panel

```
Usuario elige panel (ej: Portainer)
        │
        ▼
   Confirmar instalación
        │
        ▼
   Descargar script remoto
        │
        ▼
   Validar descarga
        │
        ▼
   Ejecutar script
        │
        ├─ Instalar Docker (si no existe)
        ├─ Configurar Docker
        ├─ Descargar imagen Portainer
        ├─ Crear contenedor
        ├─ Iniciar servicio
        │
        ▼
   Loguear resultado
        │
        ▼
   Mostrar acceso (URL y puerto)
```

---

## 📂 Estructura de Directorios

```
vps/
│
├─ Scripts Principales
│  ├─ install.sh              ← Punto de entrada principal
│  ├─ instalador.sh           ← Menú instaladores
│  ├─ herramientas.sh         ← Menú herramientas
│  ├─ validate.sh             ← Validador de sistema
│  └─ config.sh               ← Configuración centralizada
│
├─ Scripts de Instalación
│  └─ instaladores/
│     ├─ nuevo+docker+portainer.sh
│     ├─ nuevo+docker+easypanel.sh
│     ├─ nuevo+docker+aapanel.sh
│     ├─ nuevo+docker+cyberpanel.sh
│     └─ nuevo+docker+cosmos.sh
│
├─ Scripts de Herramientas
│  └─ herramientas/
│     ├─ install-docker.sh
│     ├─ bashrc.sh
│     ├─ firefox-fix.sh
│     ├─ portainer-update.sh
│     └─ install-mkvtoolnix...sh
│
├─ Documentación
│  ├─ README.md               ← Documentación principal
│  ├─ TROUBLESHOOTING.md      ← Solución de problemas
│  ├─ ARCHITECTURE.md         ← Este archivo
│  ├─ CONTRIBUTING.md         ← Guía de contribución
│  └─ LICENSE                 ← GPL-3.0
│
├─ Configuración
│  ├─ VERSION                 ← Control de versión
│  ├─ .gitignore              ← Patrones ignorados
│  └─ .github/workflows/      ← CI/CD (futuro)
│
└─ Logs (generados en tiempo de ejecución)
   └─ /var/log/vps-installer/
      ├─ install_20260103_120530.log
      ├─ install_20260103_120631.log
      └─ validation_20260103_120645.log
```

---

## 🔄 Flujo de Configuración

```
config.sh (centralizado)
    │
    ├─ Variables globales
    │  ├─ REPO_OWNER = "kadma"
    │  ├─ REPO_NAME = "vps"
    │  ├─ REPO_BRANCH = "main"
    │  └─ REPO_URL = "https://raw.githubusercontent.com/..."
    │
    ├─ Directorios
    │  ├─ LOG_DIR = "/var/log/vps-installer/"
    │  └─ LOG_FILE = "${LOG_DIR}/install_*.log"
    │
    ├─ Códigos de Color
    │  ├─ RED, GREEN, YELLOW, BLUE, NC
    │  └─ Usados en print_*
    │
    └─ Funciones Comunes
       ├─ check_root()
       ├─ check_dependency()
       ├─ check_internet()
       ├─ print_info/success/warning/error()
       ├─ confirm()
       ├─ run_command()
       ├─ download_and_run()
       └─ show_system_info()
```

---

## 🔐 Capa de Seguridad

```
┌─────────────────────────────────────────────┐
│         Validaciones de Seguridad           │
└─────────────────────────────────────────────┘
            │
    ┌───────┼───────┐
    │       │       │
    ▼       ▼       ▼
 Permisos Conexión Espacio
  (root)  (inet)   (disco)
    │       │       │
    ├───────┼───────┤
    │               │
    ▼               ▼
┌──────────┐   ┌──────────────┐
│Validar   │   │Confirmar     │
│Ejecución │   │Operaciones   │
└──────────┘   └──────────────┘
    │               │
    └───────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ Descargar    │
    │ Script Remoto│
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │ Ejecutar con │
    │ Manejo Error │
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │ Loguear      │
    │ Resultado    │
    └──────────────┘
```

---

## 📊 Matriz de Compatibilidad

| OS | Versión | Estado | Notas |
|---|---|---|---|
| Ubuntu | 18.04+ | ✅ Completo | Recomendado |
| Debian | 9+ | ✅ Completo | Funcional |
| CentOS | 7+ | ✅ Parcial | Algunos scripts pueden requerir ajustes |
| RHEL | 7+ | ✅ Parcial | Equivalente a CentOS |
| Alpine | 3.10+ | ⚠️ Limitado | Requiere paquetes adicionales |

---

## 🚀 Ciclo de Vida de una Instalación

```
1. INIT
   ├─ Cargar configuración
   ├─ Validar permisos
   ├─ Crear logs
   └─ Iniciar sesión

2. VALIDATE
   ├─ Verificar internet
   ├─ Verificar dependencias
   ├─ Verificar espacio
   └─ Confirmar con usuario

3. DOWNLOAD
   ├─ Descargar script remoto
   ├─ Verificar descarga
   └─ Almacenar temporalmente

4. EXECUTE
   ├─ Ejecutar script
   ├─ Capturar output
   ├─ Detectar errores
   └─ Manejar fallos

5. FINALIZE
   ├─ Loguear resultado
   ├─ Mostrar información
   ├─ Ofrecer soporte
   └─ Limpiar temporales

6. EXIT
   ├─ Mostrar resumen
   ├─ Ubicación de logs
   └─ Siguiente paso recomendado
```

---

## 🔌 Extensibilidad

Para agregar una nueva herramienta:

1. **Crear script** en `herramientas/nuevo-herramienta.sh`
2. **Agregar función** en `herramientas.sh`:
   ```bash
   nueva_herramienta() {
       print_info "Instalando nueva herramienta"
       if confirm "¿Deseas continuar?"; then
           download_and_run "herramientas/nueva-herramienta.sh"
       fi
   }
   ```
3. **Agregar opción** al menú
4. **Documentar** en README.md

---

## 🔄 Ciclo de Actualización

```
Cambios en GitHub
    │
    ▼
Pull Request
    │
    ▼
Code Review
    │
    ▼
Merge a main
    │
    ▼
Nueva versión en VERSION
    │
    ▼
Users automáticamente descargan
    nuevos scripts al ejecutar
```

---

## 📝 Logging y Monitoreo

```
Cada ejecución genera:

/var/log/vps-installer/
├─ install_20260103_120530.log
│  ├─ [2026-01-03 12:05:30] [INFO] Inicio de sesión
│  ├─ [2026-01-03 12:05:31] [INFO] Validando permisos
│  ├─ [2026-01-03 12:05:32] [SUCCESS] Permisos OK
│  └─ [2026-01-03 12:05:35] [ERROR] Fallo en descarga
│
└─ validation_20260103_120645.log
   ├─ [2026-01-03 12:06:45] [SUCCESS] Validación 1
   └─ [2026-01-03 12:06:46] [FAILURE] Validación 2
```

---

## 🎯 Mejoras Futuras

- [ ] Soporte para más paneles
- [ ] Sistema de rollback automático
- [ ] Dashboard web para monitoreo
- [ ] API para instalaciones remotas
- [ ] Encriptación de logs sensibles
- [ ] Tests automatizados
- [ ] Soporte multi-idioma
