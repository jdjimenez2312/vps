#!/bin/bash
# ============================================================================
# Script de validación para detectar problemas comunes
# ============================================================================

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/kadma/vps/refs/heads/dev/config.sh"

# Cargar config
if ! source <(wget -qO - "$REPO_URL"); then
    echo "Error: No se pudo cargar la configuración"
    exit 1
fi

# Inicializar
setup_logging
LOG_FILE="/var/log/vps-installer/validation_$(date +%Y%m%d_%H%M%S).log"

clear
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   VALIDADOR DEL SISTEMA - VPS INSTALLER    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo

print_info "Iniciando validación del sistema..."
echo

# Variables de resultado
PASS=0
FAIL=0

# Función para validación
validate() {
    local name=$1
    local cmd=$2
    
    if eval "$cmd" &>/dev/null; then
        print_success "$name"
        ((PASS++))
    else
        print_error "$name"
        ((FAIL++))
    fi
}

# ============================================================================
# VALIDACIONES
# ============================================================================

echo -e "${YELLOW}📋 Verificando requisitos del sistema...${NC}"
echo

validate "✓ Ejecución como root" "[[ $EUID -eq 0 ]]"
validate "✓ Wget instalado" "command -v wget"
validate "✓ Bash 4.0+" "bash --version | grep -oP '\\d+\\.\\d+' | head -1 | awk -F. '{if (\$1 >= 4) exit 0; exit 1}'"
validate "✓ Conexión a internet" "wget --spider -q https://www.google.com"

echo
echo -e "${YELLOW}🖥️  Información del sistema...${NC}"
echo

show_system_info
echo

validate "✓ Espacio disponible (>5GB)" "df / | awk 'NR==2 {if (\$4 > 5000000) exit 0; exit 1}'"
validate "✓ RAM disponible (>512MB)" "free -m | awk 'NR==2 {if (\$7 > 512) exit 0; exit 1}'"

echo
echo -e "${YELLOW}🔒 Verificando seguridad...${NC}"
echo

validate "✓ SSH disponible" "command -v ssh"
validate "✓ Firewall (UFW/FirewallD)" "command -v ufw || command -v firewall-cmd"

echo
echo -e "${YELLOW}📦 Verificando dependencias opcionales...${NC}"
echo

# Estas son opcionales
if command -v docker &>/dev/null; then
    print_success "✓ Docker ya instalado"
else
    print_warning "⚠️  Docker no instalado (se instalará durante la ejecución)"
fi

if command -v git &>/dev/null; then
    print_success "✓ Git instalado"
else
    print_warning "⚠️  Git no instalado (opcional)"
fi

echo
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            RESULTADO DE VALIDACIÓN          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo
echo -e "${GREEN}✓ Validaciones exitosas: $PASS${NC}"
echo -e "${RED}✗ Validaciones fallidas: $FAIL${NC}"
echo

if [ $FAIL -eq 0 ]; then
    print_success "¡Sistema listo para instalar!"
    print_info "Ahora puedes ejecutar el instalador: sudo bash -c \"\$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/dev/instalador.sh)\""
    echo
    echo "Logs guardados en: $LOG_FILE"
    exit 0
else
    print_error "Se encontraron problemas. Revisa el log para más detalles."
    echo "Logs guardados en: $LOG_FILE"
    exit 1
fi
