#!/bin/bash
# ============================================================================
# Script de instalación segura con todo integrado
# Este es el script recomendado para ejecutar
# ============================================================================

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/kadma/vps/refs/heads/dev"
VERSION="1.0.0"

clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║              🚀 VPS INSTALLER & TOOLS - v1.0.0                   ║
║                                                                   ║
║         Scripts para instalación automática en VPS                ║
║                                                                   ║
╚═══════════════════════════════════════════════════════════════════╝
EOF

echo
echo "⏳ Cargando configuración..."

# Cargar configuración centralizada
if ! CONFIG=$(mktemp); then
    echo "❌ Error: No se pudo crear archivo temporal"
    exit 1
fi

if ! wget -qO "$CONFIG" "${REPO_URL}/config.sh"; then
    echo "❌ Error: No se pudo descargar la configuración"
    rm -f "$CONFIG"
    exit 1
fi

# Source config
if ! source "$CONFIG"; then
    echo "❌ Error: No se pudo cargar la configuración"
    rm -f "$CONFIG"
    exit 1
fi

rm -f "$CONFIG"

# Inicializar
setup_logging
check_root
check_internet

print_success "Configuración cargada"
echo

# Menú principal
while true; do
    clear
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════════╗
║                    MENU PRINCIPAL - VPS TOOLS                     ║
╚═══════════════════════════════════════════════════════════════════╝

¿Qué deseas hacer?

1. 📦 Instaladores (Docker + Paneles)
2. 🛠️  Herramientas (Utilidades individuales)
3. ✅ Validar sistema
4. 📖 Ver documentación
5. 🚪 Salir

EOF
    
    read -p "Selecciona una opción (1-5): " option
    
    case $option in
        1)
            echo "✅ Iniciando instaladores..."
            sleep 1
            download_and_run "instalador.sh"
            ;;
        2)
            echo "✅ Iniciando herramientas..."
            sleep 1
            download_and_run "herramientas.sh"
            ;;
        3)
            echo "✅ Validando sistema..."
            sleep 1
            download_and_run "validate.sh"
            ;;
        4)
            print_info "Abriendo documentación..."
            echo "👉 https://github.com/kadma/vps#readme"
            ;;
        5)
            print_info "Saliendo..."
            print_success "Logs guardados en: $LOG_FILE"
            exit 0
            ;;
        *)
            print_error "Opción no válida"
            sleep 2
            ;;
    esac
done
