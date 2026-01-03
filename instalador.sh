#!/bin/bash

set -euo pipefail

# Cargar configuración centralizada
CONFIG_URL="https://raw.githubusercontent.com/kadma/vps/refs/heads/main/config.sh"
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
    echo -e "${BLUE}   MENU DE INSTALACION${NC}"
    echo -e "${BLUE}========================${NC}"
    echo "1. docker + portainer"
    echo "2. docker + easypanel"
    echo "3. docker + aapanel"
    echo "4. docker + cyberpanel"
    echo "5. docker + cosmos"
    echo "q. Salir"
    echo -e "${BLUE}========================${NC}"
    echo
}

# Zona de Funciones
docker_portainer() {
    print_info "Instalando Docker y Portainer"
    if confirm "¿Deseas continuar con la instalación?"; then
        download_and_run "instaladores/nuevo+docker+portainer.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

docker_easypanel() {
    print_info "Instalando Docker y Easy Panel"
    if confirm "¿Deseas continuar con la instalación?"; then
        download_and_run "instaladores/nuevo+docker+easypanel.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

docker_aapanel() {
    print_info "Instalando Docker y Aapanel"
    if confirm "¿Deseas continuar con la instalación?"; then
        download_and_run "instaladores/nuevo+docker+aapanel.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

docker_cyberpanel() {
    print_info "Instalando Docker y Cyber Panel"
    if confirm "¿Deseas continuar con la instalación?"; then
        download_and_run "instaladores/nuevo+docker+cyberpanel.sh"
    else
        print_warning "Instalación cancelada"
    fi
}

docker_cosmos() {
    print_info "Instalando Docker y Cosmos"
    if confirm "¿Deseas continuar con la instalación?"; then
        download_and_run "instaladores/nuevo+docker+cosmos.sh"
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
            docker_portainer
            if confirm "¿Deseas instalar otro panel?"; then
                continue
            else
                print_success "Instalación completada. Logs guardados en: $LOG_FILE"
                exit 0
            fi
            ;;
        2)
            docker_easypanel
            if confirm "¿Deseas instalar otro panel?"; then
                continue
            else
                print_success "Instalación completada. Logs guardados en: $LOG_FILE"
                exit 0
            fi
            ;;
        3)
            docker_aapanel
            if confirm "¿Deseas instalar otro panel?"; then
                continue
            else
                print_success "Instalación completada. Logs guardados en: $LOG_FILE"
                exit 0
            fi
            ;;
        4)
            docker_cyberpanel
            if confirm "¿Deseas instalar otro panel?"; then
                continue
            else
                print_success "Instalación completada. Logs guardados en: $LOG_FILE"
                exit 0
            fi
            ;;
        5)
            docker_cosmos
            if confirm "¿Deseas instalar otro panel?"; then
                continue
            else
                print_success "Instalación completada. Logs guardados en: $LOG_FILE"
                exit 0
            fi
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