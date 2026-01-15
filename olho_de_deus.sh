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
YELLOW="\033[1;33m"
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
     Powered by SystemDown
EOF
echo -e "${RESET}"
}

deps() {
pkg update -y
pkg install -y git python python-pip curl wget nmap
pip install --upgrade pip
}

clone_if_not() {
[ -d "$1" ] || git clone "$2"
}

menu() {
echo -e "${CYAN}════════════════════════════════════${RESET}"
echo "[1] OSINT & ENUMERATION"
echo "[2] WEB SCANNERS"
echo "[3] VULNERABILITY SCANNERS"
echo "[4] STRESS / DoS TOOLS (INFO ONLY)"
echo "[0] Sair"
echo -e "${CYAN}════════════════════════════════════${RESET}"
read -p "➤ Escolha: " op
}

deps

while true; do
clear
banner
menu

case $op in

1)
echo -e "${YELLOW}OSINT & ENUMERATION${RESET}"
echo "- theHarvester: coleta de e-mails, domínios e hosts"
echo "- Amass: enumeração de subdomínios"
echo "- Subfinder: descoberta passiva de subdomínios"
echo "- Assetfinder: domínios relacionados"
echo ""
clone_if_not theHarvester https://github.com/laramies/theHarvester.git
python theHarvester/theHarvester.py -h
read -p "Enter para voltar..."
;;

2)
echo -e "${YELLOW}WEB SCANNERS${RESET}"
echo "- Nikto: falhas em servidores web"
echo "- WhatWeb: tecnologias de sites"
echo "- Dirsearch: brute force de diretórios"
echo ""
clone_if_not dirsearch https://github.com/maurosoria/dirsearch.git
python dirsearch/dirsearch.py -h
read -p "Enter para voltar..."
;;

3)
echo -e "${YELLOW}VULNERABILITY SCANNERS${RESET}"
echo "- SQLmap: SQL Injection"
echo "- Nuclei: scanner baseado em templates"
echo "- XSStrike: detecção de XSS"
echo ""
pip install sqlmap nuclei xsstrike dalfox
sqlmap -h
read -p "Enter para voltar..."
;;

4)
echo -e "${RED}STRESS / DoS (INFORMATIVO)${RESET}"
echo ""
echo "Ferramentas listadas para estudo e ambientes autorizados:"
echo ""
echo "- Hping3       → geração de pacotes TCP/IP"
echo "- Slowloris    → DoS HTTP por conexões lentas"
echo "- GoldenEye    → stress HTTP"
echo "- Xerxes       → flood HTTP"
echo "- Torshammer   → DoS HTTP lento"
echo "- HULK         → flood HTTP com headers aleatórios"
echo "- SlowHTTPTest → simulação de ataques lentos"
echo "- PyFlooder    → geração de tráfego"
echo "- HTTP/UDP/TCP Flood"
echo "- HOIC         → stress camada aplicação"
echo ""
echo "⚠️ Essas ferramentas NÃO são executadas automaticamente."
echo "Uso somente educacional e autorizado."
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
