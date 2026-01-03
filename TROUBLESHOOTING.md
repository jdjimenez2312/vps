# Troubleshooting y Solución de Problemas

## Errores Comunes y Soluciones

### 1. "Permission denied: instalador.sh"

**Causa**: El archivo no tiene permisos de ejecución

**Solución**:
```bash
sudo chmod +x instalador.sh
sudo bash instalador.sh
```

---

### 2. "wget: command not found"

**Causa**: wget no está instalado

**Solución**:
```bash
# Para Debian/Ubuntu
sudo apt-get update
sudo apt-get install wget

# Para CentOS/RHEL
sudo yum install wget

# Para Alpine
sudo apk add wget
```

---

### 3. "This script must be run as root"

**Causa**: El script requiere permisos de administrador

**Solución**:
```bash
# Opción 1: Ejecutar con sudo
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"

# Opción 2: Convertirse en root
sudo su -
bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

---

### 4. "No space left on device"

**Causa**: No hay espacio suficiente en disco

**Solución**:
```bash
# Ver uso de disco
df -h

# Liberar espacio
sudo apt-get clean
sudo apt-get autoclean

# Identificar archivos grandes
du -sh * | sort -rh | head -10
```

---

### 5. "Failed to download script"

**Causa**: Problema de conexión o URL incorrecta

**Solución**:
```bash
# Verificar conexión
ping -c 3 google.com

# Verificar DNS
cat /etc/resolv.conf

# Cambiar DNS manualmente si es necesario
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf

# Reintentar descarga
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/main/instalador.sh)"
```

---

### 6. Docker no inicia después de instalar

**Causa**: Problemas de configuración o permisos

**Solución**:
```bash
# Verificar estado
sudo systemctl status docker

# Iniciar servicio
sudo systemctl start docker

# Habilitar al arranque
sudo systemctl enable docker

# Revisar logs
sudo journalctl -u docker -n 20

# Agregar usuario al grupo docker (opcional)
sudo usermod -aG docker $USER
```

---

### 7. Panel web no accesible (puerto no abre)

**Causa**: Firewall bloqueando el puerto

**Solución**:
```bash
# Ver puertos en escucha
sudo netstat -tlnp | grep LISTEN

# Con ss (herramienta moderna)
sudo ss -tlnp | grep LISTEN

# Firewall UFW (Debian/Ubuntu)
sudo ufw allow 9000/tcp    # Para Portainer
sudo ufw allow 3000/tcp    # Para EasyPanel
sudo ufw reload

# Firewall FirewallD (CentOS/RHEL)
sudo firewall-cmd --add-port=9000/tcp --permanent
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload
```

---

### 8. "curl: command not found"

**Causa**: curl no está instalado (algunos scripts pueden requerirlo)

**Solución**:
```bash
# Debian/Ubuntu
sudo apt-get install curl

# CentOS/RHEL
sudo yum install curl
```

---

### 9. Errores en los logs de instalación

**Ubicación de logs**:
```bash
# Ver todos los logs
ls -lh /var/log/vps-installer/

# Ver último log
tail -f /var/log/vps-installer/install_*.log

# Ver log específico
cat /var/log/vps-installer/install_20260103_120530.log

# Buscar errores
grep -i error /var/log/vps-installer/install_*.log
```

---

### 10. Sistema lento después de instalación

**Causa**: Recursos insuficientes

**Solución**:
```bash
# Ver uso de CPU y memoria
top

# Ver procesos Docker
sudo docker ps

# Ver uso de disco por contenedores
sudo docker system df

# Limpiar Docker
sudo docker system prune -a  # ⚠️ Cuidado: elimina datos

# Limitar recursos de contenedores
sudo docker update --memory="512m" container_name
```

---

## Herramientas de Diagnóstico

### Información del Sistema
```bash
# OS y versión
uname -a
lsb_release -d

# CPU
lscpu

# Memoria
free -h

# Disco
df -h

# Network
ip addr
ip route
```

### Servicios
```bash
# Estado de servicios
sudo systemctl status docker
sudo systemctl status ssh

# Logs del sistema
sudo journalctl -n 50
sudo tail -f /var/log/syslog
```

### Network
```bash
# Puertos escuchando
sudo netstat -tlnp

# Prueba de conectividad
ping 8.8.8.8
traceroute google.com

# DNS
nslookup github.com
dig github.com
```

---

## Solución Avanzada

### Restaurar de Logs
Si una instalación falló, puedes revisar qué pasó exactamente:

```bash
# Listar todas las instalaciones realizadas
grep SUCCESS /var/log/vps-installer/*.log

# Ver cronología de eventos
grep "START\|SUCCESS\|ERROR" /var/log/vps-installer/install_20260103_120530.log
```

### Desinstalar Panel
```bash
# Ver contenedores activos
sudo docker ps -a

# Detener contenedor
sudo docker stop container_id

# Eliminar contenedor
sudo docker rm container_id

# Ver imágenes
sudo docker images

# Eliminar imagen
sudo docker rmi image_id
```

---

## Soporte Adicional

Si los pasos anteriores no resuelven tu problema:

1. **Recopila información**:
   - Output completo de logs: `cat /var/log/vps-installer/install_*.log`
   - Información del sistema: `uname -a && free -h && df -h`
   - Output de error específico

2. **Abre un issue en GitHub**:
   - Incluye los logs completos
   - Describe qué instalaste y qué pasó
   - Especifica tu SO y versión

3. **Contacta al mantenedor**:
   - Repositorio: https://github.com/kadma/vps
   - Envía detalles del problema y logs
