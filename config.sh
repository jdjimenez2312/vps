#!/bin/bash
# ============================================================================
# Configuración centralizada para scripts de VPS
# ============================================================================

# Color codes para mensajes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración de repositorio
REPO_OWNER="kadma"
REPO_NAME="vps"
REPO_BRANCH="dev"
REPO_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/refs/heads/${REPO_BRANCH}"

# Directorio de logs
LOG_DIR="/var/log/vps-installer"
LOG_FILE="${LOG_DIR}/install_$(date +%Y%m%d_%H%M%S).log"

# ============================================================================
# FUNCIONES COMUNES
# ============================================================================

# Validar si se ejecuta como root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}❌ Este script debe ejecutarse con permisos de root${NC}"
        echo "Usa: sudo bash -c \"\$(wget -qLO - $REPO_URL/script.sh)\""
        exit 1
    fi
}

# Validar dependencias
check_dependency() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}❌ Dependencia faltante: $cmd${NC}"
        return 1
    fi
    return 0
}

# Validar conexión a internet
check_internet() {
    if ! wget --spider -q https://www.google.com 2>/dev/null; then
        echo -e "${RED}❌ No hay conexión a internet${NC}"
        return 1
    fi
}

# Crear directorio de logs
setup_logging() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_FILE"
    echo "=== Inicio de sesión: $(date) ===" >> "$LOG_FILE"
}

# Función para loguear mensajes
log_message() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [${level}] ${message}" >> "$LOG_FILE"
}

# Función para imprimir mensajes
print_info() {
    echo -e "${BLUE}ℹ️  $@${NC}"
    log_message "INFO" "$@"
}

print_success() {
    echo -e "${GREEN}✅ $@${NC}"
    log_message "SUCCESS" "$@"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $@${NC}"
    log_message "WARNING" "$@"
}

print_error() {
    echo -e "${RED}❌ $@${NC}"
    log_message "ERROR" "$@"
}

# Confirmación interactiva
confirm() {
    local prompt="$1"
    local response
    read -p "$(echo -e ${YELLOW}${prompt}${NC}) (s/n): " -n 1 response
    echo
    [[ "$response" =~ ^[Ss]$ ]]
}

# Ejecutar comando con manejo de errores
run_command() {
    local description=$1
    shift
    print_info "$description"
    if "$@" >> "$LOG_FILE" 2>&1; then
        print_success "$description completado"
        return 0
    else
        print_error "Error en: $description"
        return 1
    fi
}

# Descargar y ejecutar script remoto
download_and_run() {
    local script_path=$1
    local script_name=$(basename "$script_path")
    
    if ! check_internet; then
        print_error "No se puede descargar $script_name"
        return 1
    fi
    
    print_info "Descargando $script_name"
    local temp_script=$(mktemp)
    
    if wget -qO "$temp_script" "${REPO_URL}/${script_path}"; then
        print_success "Script descargado"
        bash "$temp_script" | tee -a "$LOG_FILE"
        local exit_code=$?
        rm -f "$temp_script"
        return $exit_code
    else
        print_error "Fallo al descargar $script_name"
        rm -f "$temp_script"
        return 1
    fi
}

# Mostrar información de sistema
show_system_info() {
    print_info "Información del sistema:"
    echo "Distribución: $(lsb_release -d 2>/dev/null | cut -f2 || echo 'Desconocida')"
    echo "Kernel: $(uname -r)"
    echo "Arquitectura: $(uname -m)"
    echo "Memoria RAM: $(free -h | awk 'NR==2 {print $2}')"
}

# Exportar funciones para uso en otros scripts
export -f check_root
export -f check_dependency
export -f check_internet
export -f setup_logging
export -f log_message
export -f print_info
export -f print_success
export -f print_warning
export -f print_error
export -f confirm
export -f run_command
export -f download_and_run
export -f show_system_info
