#!/usr/bin/env bash

clear

# ===============================
#  OLHO DE DEUS - TERMUX
#  Powered by SystemDown
# ===============================

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
      ⚡ Powered by SystemDown
EOF
echo -e "${RESET}"
}

deps() {
echo -e "${CYAN}[*] Verificando dependências...${RESET}"
pkg update -y
pkg install -y git python python-pip curl wget
pip install --upgrade pip
}

clone_if_not() {
if [ ! -d "$1" ]; then
  git clone "$2"
else
  echo -e "${GREEN}[✔] $1 já existe${RESET}"
fi
}

menu() {
echo -e "${CYAN}═══════════════════════════════${RESET}"
echo "[1] TheHarvester  → OSINT / Domínios / Emails"
echo "[2] PhoneInfoga   → Dados de telefone"
echo "[3] Locust        → Teste de carga / tráfego"
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
read -p "Pressione ENTER para voltar..."
;;

2)
clone_if_not phoneinfoga https://github.com/sundowndev/phoneinfoga.git
cd phoneinfoga || exit
pip install -r requirements.txt
python3 phoneinfoga.py -h
cd ..
read -p "Pressione ENTER para voltar..."
;;

3)
echo -e "${CYAN}[*] Instalando Locust...${RESET}"
pip install locust
echo -e "${GREEN}[✔] Locust instalado com sucesso${RESET}"
echo ""
locust -h
read -p "Pressione ENTER para voltar..."
;;

0)
echo -e "${RED}Saindo...${RESET}"
exit
;;

*)
echo -e "${RED}Opção inválida!${RESET}"
sleep 1
;;
esac
done
