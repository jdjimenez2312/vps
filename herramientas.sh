#!/bin/bash

set -euo pipefail

# Cargar configuración centralizada
CONFIG_URL="https://raw.githubusercontent.com/kadma/vps/refs/heads/dev/config.sh"
if ! source <(wget -qO - "$CONFIG_URL"); then
    echo "Error: No se pudo cargar la configuración centralizada"
    exit 1
fi

# Inicializar logging
setup_logging
check_root
check_internet

# Función para mostrar el menú
mostrar_menu() {
    clear
    echo -e "${BLUE}========================${NC}"
    echo -e "${BLUE}  MENU DE HERRAMIENTAS${NC}"
    echo -e "${BLUE}========================${NC}"
    echo "1. Docker"
    echo "2. Bashrc"
    echo "3. Firefox Fix"
    echo "4. Portainer Update"
    echo "5. MKVToolNix + QBitTorrent + FreeDownloadManager"
    echo "q. Salir"
    echo -e "${BLUE}========================${NC}"
    echo
}

# Zona de Funciones
solo_docker() {
    print_info "Instalando Docker"
    if confirm "¿Deseas continuar?"; then
        download_and_run "herramientas/install-docker.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

bashrc() {
    print_info "Agregando comandos a bashrc"
    if confirm "¿Deseas continuar?"; then
        download_and_run "herramientas/bashrc.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

firefox_fix() {
    print_info "Arreglando Firefox"
    if confirm "¿Deseas continuar?"; then
        download_and_run "herramientas/firefox-fix.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

portainer_update() {
    print_info "Actualizando Portainer"
    if confirm "¿Deseas continuar?"; then
        download_and_run "herramientas/portainer-update.sh"
    else
        print_warning "Actualización cancelada"
    fi
}

mkv_qbit_fdm() {
    print_info "Instalando MKVToolNix, QBitTorrent y FreeDownloadManager"
    if confirm "¿Deseas continuar? (esta instalación puede tomar varios minutos)"; then
        download_and_run "herramientas/install-mkvtoolnix-qbittorrent-freedownloadmanager.sh"
    else
        print_warning "Instalación cancelada"
    fi
}



# Ciclo principal
while true; do
    mostrar_menu
    read -p "Selecciona una opción (1-5) o q para salir: " opcion
    case $opcion in
        1)
            solo_docker
            ;;
        2)
            bashrc
            ;;
        3)
            firefox_fix
            ;;
        4)
            portainer_update
            ;;
        5)
            mkv_qbit_fdm
            ;;
        q)
            print_info "Saliendo..."
            print_success "Logs guardados en: $LOG_FILE"
            exit 0
            ;;
        *)
            print_error "Opción no válida. Inténtalo de nuevo."
            sleep 1
            ;;
    esac
done
