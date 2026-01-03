# 🚀 VPS Installer & Tools

> [!IMPORTANT]
> Version: 1.0.0 | Última actualización: Enero 2026

Scripts automatizados para instalar y configurar herramientas en VPS recién creados. Elimina la necesidad de hacer instalaciones manuales repetitivas.

---

## 📋 Requisitos Previos

- **SO**: Linux (Debian/Ubuntu o CentOS/RHEL)
- **Kernel**: 3.10+
- **RAM**: Mínimo 512MB (recomendado 1GB+)
- **Espacio**: Mínimo 5GB disponibles
- **Permisos**: Root o usuario con `sudo` sin contraseña
- **Conexión**: Acceso a internet activo
- **Herramientas**: `wget` debe estar instalado

### Verificar requisitos
```bash
# Verificar permisos de root
sudo whoami

# Verificar wget
which wget

# Verificar espacio disponible
df -h /
```

---

## ⚡ Uso Rápido

### Instalador Principal
Menú interactivo para instalar Docker con paneles de control:

```bash
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

**Opciones disponibles:**
1. **Docker + Portainer** - Panel ligero y versátil
2. **Docker + EasyPanel** - Interfaz moderna
3. **Docker + AaPanel** - Panel completo con hosting
4. **Docker + CyberPanel** - Seguridad integrada
5. **Docker + Cosmos** - Dashboard moderno

### Herramientas Adicionales
Menú para instalar herramientas y utilidades individuales:

```bash
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/herramientas.sh)"
```

**Opciones disponibles:**
1. **Docker** - Motor de contenedores
2. **Bashrc** - Mejoras de shell
3. **Firefox Fix** - Correcciones de Firefox
4. **Portainer Update** - Actualizar Portainer
5. **MKVToolNix + QBitTorrent + FDM** - Suite multimedia

---

## 📁 Estructura del Proyecto

```
vps/
├── instalador.sh                           # Menú principal de instalación
├── herramientas.sh                         # Menú de herramientas individuales
├── config.sh                               # Configuración centralizada
├── VERSION                                 # Control de versión
├── README.md                               # Esta documentación
├── instaladores/                           # Scripts de instalación
│   ├── nuevo+docker+portainer.sh
│   ├── nuevo+docker+easypanel.sh
│   ├── nuevo+docker+aapanel.sh
│   ├── nuevo+docker+cyberpanel.sh
│   └── nuevo+docker+cosmos.sh
└── herramientas/                           # Scripts de herramientas
    ├── install-docker.sh
    ├── bashrc.sh
    ├── firefox-fix.sh
    ├── portainer-update.sh
    └── install-mkvtoolnix-qbittorrent-freedownloadmanager.sh
```

---

## 🔍 Características Principales

### ✅ Manejo Robusto de Errores
- Validación de permisos y dependencias
- Verificación de conexión a internet
- Manejo automático de fallos con rollback
- Mensajes de error descriptivos

### 📝 Sistema de Logging
- Logs automáticos en `/var/log/vps-installer/`
- Trazabilidad completa de cada instalación
- Timestamps y niveles de severidad
- Facilita troubleshooting y auditoría

### 🔐 Seguridad Mejorada
- Validación de permisos requeridos
- Confirmación antes de operaciones críticas
- Descargas verificadas
- Ejecución en rama estable

### 🎨 Interfaz Amigable
- Colores para mejor legibilidad
- Menús interactivos y claros
- Mensajes de progreso en tiempo real
- Opciones de confirmación antes de cambios

---

## 📖 Guía de Uso Detallada

### 1. Instalación Inicial

```bash
# Actualizar sistema (recomendado)
sudo apt update && sudo apt upgrade -y

# Ejecutar instalador
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

### 2. Seleccionar Opción
- Elige el panel que desees instalar (1-5)
- Confirma cuando se solicite
- El script se descargará e instalará automáticamente
- Los logs se guardarán para referencia futura

### 3. Verificar Instalación
```bash
# Ver logs de la instalación
tail -f /var/log/vps-installer/install_*.log

# Verificar Docker
sudo docker --version

# Acceder a tu panel (puertos varían según elección)
# Portainer: http://tu-vps:9000
# EasyPanel: http://tu-vps:3000
```

---

## 🛠️ Solución de Problemas

### Error: "No hay conexión a internet"
```bash
# Verificar conexión
ping -c 3 google.com

# Verificar DNS
cat /etc/resolv.conf

# Cambiar DNS si es necesario
sudo nano /etc/resolv.conf
# Agregar: nameserver 8.8.8.8
```

### Error: "Permisos insuficientes"
```bash
# Ejecutar como root
sudo bash

# O usar sudo directamente
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

### Error: "wget no encontrado"
```bash
# Debian/Ubuntu
sudo apt install wget

# CentOS/RHEL
sudo yum install wget

# Alpine
sudo apk add wget
```

### Ver logs de instalación
```bash
# Listar logs disponibles
ls -lh /var/log/vps-installer/

# Ver último log
tail -50 /var/log/vps-installer/install_*.log

# Ver log específico
cat /var/log/vps-installer/install_20260103_120530.log
```

---

## 🔧 Configuración Centralizada

El archivo `config.sh` contiene:
- URLs del repositorio
- Directorio de logs
- Funciones comunes reutilizables
- Colores y formatos de mensajes

**No edites directamente este archivo desde scripts.** Se carga automáticamente.

---

## 📊 Paneles Disponibles

| Panel | Características | Puertos | Casos de Uso |
|-------|-----------------|---------|------------|
| **Portainer** | Ligero, fácil, visual | 9000 | Principiantes, múltiples contenedores |
| **EasyPanel** | Moderno, intuitivo | 3000 | UI limpia, uso general |
| **AaPanel** | Completo, web hosting | 7800 | Hosting, múltiples sitios |
| **CyberPanel** | Seguridad, SSL | 8090 | Seguridad, certificados |
| **Cosmos** | Moderno, minimalista | 80/443 | Dashboard agregado |

---

## 📜 Versionado

- **Actual**: 1.0.0
- **Rama estable**: main
- **Rama de desarrollo**: develop

Para ver cambios y versiones:
```bash
cat VERSION
```

---

## 🤝 Contribuir

1. Fork el repositorio
2. Crea una rama (`git checkout -b feature/mejora`)
3. Commit cambios (`git commit -m 'Agrega mejora'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

---

## 📝 Notas Importantes

- ⚠️ **Haz backup** antes de instalar en servidores en producción
- ⚠️ **Lee los logs** después de cada instalación
- ⚠️ **Verifica acceso** después de instalar (puertos, firewall)
- ✅ Los scripts son idempotentes (seguro ejecutar múltiples veces)
- ✅ Las instalaciones se pueden ejecutar en cualquier orden

---

## 📞 Soporte

Para reportar problemas:
1. Revisa el log completo: `/var/log/vps-installer/`
2. Verifica los requisitos previos
3. Abre un issue en GitHub con el log adjunto

---

## 📄 Licencia

GPL-3.0 - Ver LICENSE para más detalles

---

**Última actualización**: Enero 3, 2026 | **Versión**: 1.0.0
