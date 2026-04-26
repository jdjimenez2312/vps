#!/bin/bash
# Verificar si el alias ya existe y agregarlo si no está presente
if ! grep -q "alias aptup=" ~/.bashrc; then
    echo -e "\n# Alias personalizados\nalias aptup='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'" >> ~/.bashrc
else
    echo "El alias 'aptup' ya existe en ~/.bashrc"
fi