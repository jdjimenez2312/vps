#!/bin/bash
# ============================================================================
# Guía de Inicio Rápido - VPS Installer
# ============================================================================

# Ejecutar validación del sistema ANTES de instalar
echo "Validando sistema..."
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/dev/validate.sh)"

# Si la validación pasó, ejecutar el instalador
echo
echo "Iniciando instalador..."
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/kadma/vps/dev/install.sh)"
