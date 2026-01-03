# ðŸš€ VPS Installer & Tools

> [!IMPORTANT]
> Version: 1.0.0 | Ãšltima actualizaciÃ³n: Enero 2026

Scripts automatizados para instalar y configurar herramientas en VPS reciÃ©n creados. Elimina la necesidad de hacer instalaciones manuales repetitivas.

---

## ðŸ“‹ Requisitos Previos

- **SO**: Linux (Debian/Ubuntu o CentOS/RHEL)
- **Kernel**: 3.10+
- **RAM**: MÃ­nimo 512MB (recomendado 1GB+)
- **Espacio**: MÃ­nimo 5GB disponibles
- **Permisos**: Root o usuario con `sudo` sin contraseÃ±a
- **ConexiÃ³n**: Acceso a internet activo
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

## âš¡ Uso RÃ¡pido

### Instalador Principal
MenÃº interactivo para instalar Docker con paneles de control:

```bash
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

**Opciones disponibles:**
1. **Docker + Portainer** - Panel ligero y versÃ¡til
2. **Docker + EasyPanel** - Interfaz moderna
3. **Docker + AaPanel** - Panel completo con hosting
4. **Docker + CyberPanel** - Seguridad integrada
5. **Docker + Cosmos** - Dashboard moderno

### Herramientas Adicionales
MenÃº para instalar herramientas y utilidades individuales:

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

## ðŸ“ Estructura del Proyecto

```
vps/
â”œâ”€â”€ instalador.sh                           # MenÃº principal de instalaciÃ³n
â”œâ”€â”€ herramientas.sh                         # MenÃº de herramientas individuales
â”œâ”€â”€ config.sh                               # ConfiguraciÃ³n centralizada
â”œâ”€â”€ VERSION                                 # Control de versiÃ³n
â”œâ”€â”€ README.md                               # Esta documentaciÃ³n
â”œâ”€â”€ instaladores/                           # Scripts de instalaciÃ³n
â”‚   â”œâ”€â”€ nuevo+docker+portainer.sh
â”‚   â”œâ”€â”€ nuevo+docker+easypanel.sh
â”‚   â”œâ”€â”€ nuevo+docker+aapanel.sh
â”‚   â”œâ”€â”€ nuevo+docker+cyberpanel.sh
â”‚   â””â”€â”€ nuevo+docker+cosmos.sh
â””â”€â”€ herramientas/                           # Scripts de herramientas
    â”œâ”€â”€ install-docker.sh
    â”œâ”€â”€ bashrc.sh
    â”œâ”€â”€ firefox-fix.sh
    â”œâ”€â”€ portainer-update.sh
    â””â”€â”€ install-mkvtoolnix-qbittorrent-freedownloadmanager.sh
```

---

## ðŸ” CaracterÃ­sticas Principales

### âœ… Manejo Robusto de Errores
- ValidaciÃ³n de permisos y dependencias
- VerificaciÃ³n de conexiÃ³n a internet
- Manejo automÃ¡tico de fallos con rollback
- Mensajes de error descriptivos

### ðŸ“ Sistema de Logging
- Logs automÃ¡ticos en `/var/log/vps-installer/`
- Trazabilidad completa de cada instalaciÃ³n
- Timestamps y niveles de severidad
- Facilita troubleshooting y auditorÃ­a

### ðŸ” Seguridad Mejorada
- ValidaciÃ³n de permisos requeridos
- ConfirmaciÃ³n antes de operaciones crÃ­ticas
- Descargas verificadas
- EjecuciÃ³n en rama estable

### ðŸŽ¨ Interfaz Amigable
- Colores para mejor legibilidad
- MenÃºs interactivos y claros
- Mensajes de progreso en tiempo real
- Opciones de confirmaciÃ³n antes de cambios

---

## ðŸ“– GuÃ­a de Uso Detallada

### 1. InstalaciÃ³n Inicial

```bash
# Actualizar sistema (recomendado)
sudo apt update && sudo apt upgrade -y

# Ejecutar instalador
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

### 2. Seleccionar OpciÃ³n
- Elige el panel que desees instalar (1-5)
- Confirma cuando se solicite
- El script se descargarÃ¡ e instalarÃ¡ automÃ¡ticamente
- Los logs se guardarÃ¡n para referencia futura

### 3. Verificar InstalaciÃ³n
```bash
# Ver logs de la instalaciÃ³n
tail -f /var/log/vps-installer/install_*.log

# Verificar Docker
sudo docker --version

# Acceder a tu panel (puertos varÃ­an segÃºn elecciÃ³n)
# Portainer: http://tu-vps:9000
# EasyPanel: http://tu-vps:3000
```

---

## ðŸ› ï¸ SoluciÃ³n de Problemas

### Error: "No hay conexiÃ³n a internet"
```bash
# Verificar conexiÃ³n
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

### Ver logs de instalaciÃ³n
```bash
# Listar logs disponibles
ls -lh /var/log/vps-installer/

# Ver Ãºltimo log
tail -50 /var/log/vps-installer/install_*.log

# Ver log especÃ­fico
cat /var/log/vps-installer/install_20260103_120530.log
```

---

## ðŸ”§ ConfiguraciÃ³n Centralizada

El archivo `config.sh` contiene:
- URLs del repositorio
- Directorio de logs
- Funciones comunes reutilizables
- Colores y formatos de mensajes

**No edites directamente este archivo desde scripts.** Se carga automÃ¡ticamente.

---

## ðŸ“Š Paneles Disponibles

| Panel | CaracterÃ­sticas | Puertos | Casos de Uso |
|-------|-----------------|---------|------------|
| **Portainer** | Ligero, fÃ¡cil, visual | 9000 | Principiantes, mÃºltiples contenedores |
| **EasyPanel** | Moderno, intuitivo | 3000 | UI limpia, uso general |
| **AaPanel** | Completo, web hosting | 7800 | Hosting, mÃºltiples sitios |
| **CyberPanel** | Seguridad, SSL | 8090 | Seguridad, certificados |
| **Cosmos** | Moderno, minimalista | 80/443 | Dashboard agregado |

---

## ðŸ“œ Versionado

- **Actual**: 1.0.0
- **Rama estable**: main
- **Rama de desarrollo**: develop

Para ver cambios y versiones:
```bash
cat VERSION
```

---

## ðŸ¤ Contribuir

1. Fork el repositorio
2. Crea una rama (`git checkout -b feature/mejora`)
3. Commit cambios (`git commit -m 'Agrega mejora'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

---

## ðŸ“ Notas Importantes

- âš ï¸ **Haz backup** antes de instalar en servidores en producciÃ³n
- âš ï¸ **Lee los logs** despuÃ©s de cada instalaciÃ³n
- âš ï¸ **Verifica acceso** despuÃ©s de instalar (puertos, firewall)
- âœ… Los scripts son idempotentes (seguro ejecutar mÃºltiples veces)
- âœ… Las instalaciones se pueden ejecutar en cualquier orden

---

## ðŸ“ž Soporte

Para reportar problemas:
1. Revisa el log completo: `/var/log/vps-installer/`
2. Verifica los requisitos previos
3. Abre un issue en GitHub con el log adjunto

---

## ðŸ“„ Licencia

GPL-3.0 - Ver LICENSE para mÃ¡s detalles

---

**Ãšltima actualizaciÃ³n**: Enero 3, 2026 | **VersiÃ³n**: 1.0.0
