#!/bin/bash

# Aseguramos que BASE_URL esté definida
BASE_URL=${BASE_URL:-"https://jdjimenez2312.github.io/vps"}

# Colores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

mostrar_menu() {
    clear
    echo -e "${CYAN}========================================${NC}"
    echo -e "${GREEN}${BOLD}        MENÚ DE HERRAMIENTAS          ${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo -e "${YELLOW}1.${NC} Instalar Docker"
    echo -e "${YELLOW}2.${NC} Configurar bashrc"
    echo -e "${YELLOW}3.${NC} Fix para Firefox"
    echo -e "${YELLOW}4.${NC} Actualizar Portainer"
    echo -e "${YELLOW}5.${NC} Instalar mkvtoolnix + qbittorrent + freedownloadmanager"
    echo -e "${CYAN}----------------------------------------${NC}"
    echo -e "${RED}q.${NC} Regresar al Menú Principal"
    echo -e "${CYAN}========================================${NC}"
}

ejecutar_script() {
    local script_name=$1
    echo -e "\n${GREEN}Ejecutando: ${script_name}...${NC}"
    sudo bash -c "$(curl -sL $BASE_URL/herramientas/$script_name)"
    echo -e "\n${CYAN}Proceso finalizado.${NC}"
    read -p "Presiona Enter para continuar..."
}

while true; do
    mostrar_menu
    echo ""
    read -p "Selecciona una opción (1-5) o q para regresar: " opcion
    case $opcion in
        1) ejecutar_script "install-docker.sh" ;;
        2) ejecutar_script "bashrc.sh" ;;
        3) ejecutar_script "firefox%20fix.sh" ;;
        4) ejecutar_script "portainer%20update.sh" ;;
        5) ejecutar_script "nuevo%2Bmkvtoolnix%2Bqbittorrent%2Bfreedownloadmanager.sh" ;;
        q)
            # Regresa al menú principal, o termina si se ejecutó solo
            break
            ;;
        *)
            echo -e "${RED}Opción no válida. Inténtalo de nuevo.${NC}"
            sleep 2
            ;;
    esac
done
