#!/bin/bash

# Configuración de URL base para cargar los submenús y scripts
# Si configuras GitHub Pages, la URL será más corta.
BASE_URL="https://jdjimenez2312.github.io/vps"
# BASE_URL="https://raw.githubusercontent.com/jdjimenez2312/vps/refs/heads/main" # Alternativa sin GitHub Pages

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
    echo -e "${GREEN}${BOLD}          MENÚ PRINCIPAL VPS          ${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo -e "${YELLOW}1.${NC} Menú de Instalación (Docker, Paneles)"
    echo -e "${YELLOW}2.${NC} Menú de Herramientas (Config, Fixes)"
    echo -e "${CYAN}----------------------------------------${NC}"
    echo -e "${RED}q.${NC} Salir"
    echo -e "${CYAN}========================================${NC}"
}

export BASE_URL # Exportar para que los sub-scripts puedan usarla si es necesario

while true; do
    mostrar_menu
    echo ""
    read -r -p "Selecciona una opción (1-2) o q para salir: " opcion
    case $opcion in
        1)
            echo -e "${GREEN}Cargando Menú de Instalación...${NC}"
            # Ejecutamos el submenú de instalación
            bash <(curl -s "$BASE_URL/instaladores/instalador.sh")
            ;;
        2)
            echo -e "${GREEN}Cargando Menú de Herramientas...${NC}"
            # Ejecutamos el submenú de herramientas
            bash <(curl -s "$BASE_URL/herramientas/herramientas.sh")
            ;;
        q)
            clear
            echo -e "${GREEN}Saliendo... ¡Hasta luego!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opción no válida. Inténtalo de nuevo.${NC}"
            sleep 2
            ;;
    esac
done
