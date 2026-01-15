#!/usr/bin/env bash

clear

# Verificação de Termux
if [ -z "$PREFIX" ]; then
  echo "Execute este script no Termux!"
  exit 1
fi

GREEN="\033[1;32m"
CYAN="\033[1;36m"
RED="\033[1;31m"
RESET="\033[0m"

banner() {
echo -e "${GREEN}"
cat << "EOF"
        ⢀⣤⣶⣶⣶⣦⣤⡀
     ⣠⣶⣿⣿⣿⣿⣿⣿⣶⣄
   ⣴⣿⣿⡿⠿⠛⠛⠿⢿⣿⣿⣦
  ⣿⣿⡟          O          ⢻⣿⣿
   ⠻⢿⣷⣦⣄        ⣠⣴⣾⡿⠟
          OLHO DE DEUS
EOF
echo -e "${RESET}"
}

deps() {
pkg update -y
pkg install -y git python python-pip curl wget
pip install --upgrade pip
}

clone_if_not() {
[ -d "$1" ] || git clone "$2"
}

menu() {
echo -e "${CYAN}═══════════════════════════════${RESET}"
echo "[1] TheHarvester (OSINT dados)"
echo "[2] PhoneInfoga (dados telefone)"
echo "[3] Locust (teste de carga)"
echo "[0] Sair"
echo -e "${CYAN}═══════════════════════════════${RESET}"
read -p "➤ Escolha: " op
}

deps

while true; do
clear
banner
menu

case $op in
1)
clone_if_not theHarvester https://github.com/laramies/theHarvester.git
python theHarvester/theHarvester.py -h
read -p "Enter para voltar..."
;;

2)
clone_if_not phoneinfoga https://github.com/sundowndev/phoneinfoga.git
cd phoneinfoga || exit
pip install -r requirements.txt
python3 phoneinfoga.py -h
cd ..
read -p "Enter para voltar..."
;;

3)
echo "Instalando Locust..."
pip install locust
echo ""
echo "Locust instalado!"
echo "Use: locust -h"
locust -h
read -p "Enter para voltar..."
;;

0)
echo -e "${RED}Saindo...${RESET}"
exit
;;

*)
echo "Opção inválida"
sleep 1
;;
esac
done
