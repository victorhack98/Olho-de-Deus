#!/data/data/com.termux/files/usr/bin/bash

clear
echo "👁️ OLHO DE DEUS - INSTALLER"
echo "==========================="

pkg update -y
pkg install git -y

chmod +x olho_de_deus.sh

echo ""
echo "✔ Instalação concluída!"
echo "✔ Execute com: ./olho_de_deus.sh"
