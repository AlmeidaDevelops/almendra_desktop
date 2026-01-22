#!/bin/bash

# Script simple para sincronizar dotfiles
# Uso: ./sync.sh "Mensaje del commit"

MESSAGE=${1:-"Update dotfiles: $(date +'%Y-%m-%d %H:%M:%S')"}

echo "--- Agregando cambios ---"
git add .

echo "--- Haciendo commit: '$MESSAGE' ---"
git commit -m "$MESSAGE"

# Intentar push si existe un remoto configurado
if git remote | grep -q 'origin'; then
    echo "--- Subiendo a GitHub ---"
    git push origin $(git rev-parse --abbrev-ref HEAD)
else
    echo "--- [NOTA] No hay remoto 'origin' configurado. Los cambios son locales. ---"
    echo "Para configurar uno: git remote add origin <URL>"
fi

echo "--- ¡Hecho! ---"
