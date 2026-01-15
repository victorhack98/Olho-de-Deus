#!/usr/bin/env bash

clear

# ===============================
#  OLHO DE DEUS - TERMUX
#  Powered by SystemDown
# ===============================

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
      ⚡ Pѳwɛʀɛɗ ɓy รyรtɛɱɗѳwɳ
EOF
echo -e "${RESET}"
}

deps() {
pkg update -y
pkg install -y git python python-pip curl wget nmap nikto \
               ruby golang clang make openssl metasploit
pip install --upgrade pip
gem install whatweb wpscan
}

clone_if_not() {
[ -d "$1" ] || git clone "$2"
}

menu() {
echo -e "${CYAN}════════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}Escolha a ferramenta para instalar:${RESET}"
echo -e "${CYAN}════════════════════════════════════════════════════════${RESET}"

echo -e " 1) TheHarvester       → OSINT: coleta de domínios e e-mails"
echo -e " 2) PhoneInfoga        → Informações de telefones"
echo -e " 3) Locust             → Teste de carga / tráfego"
echo -e " 4) Hping3             → Geração de pacotes TCP/IP"
echo -e " 5) Slowloris          → DoS HTTP (educacional)"
echo -e " 6) SlowHTTPTest       → Simulação de ataques HTTP lentos"
echo -e " 7) Nmap               → Varredura de portas e serviços"
echo -e " 8) Nikto              → Scanner de falhas web"
echo -e " 9) SQLmap             → Detecção e exploração de SQL Injection"
echo -e "10) Metasploit         → Framework de exploração"
echo -e "11) WPScan             → Scanner vulnerabilidades WordPress"
echo -e "12) WhatWeb            → Identificação de tecnologias web"
echo -e "13) Wafw00f            → Detecção de WAFs"
echo -e "14) Dirsearch          → Brute force de diretórios web"
echo -e "15) Gobuster           → Enumeração de diretórios / DNS / vhosts"
echo -e "16) FFUF               → Fuzzing de URLs, parâmetros e diretórios"
echo -e "17) Amass              → Enumeração de subdomínios e ativos"
echo -e "18) Subfinder          → Descoberta passiva de subdomínios"
echo -e "19) Assetfinder        → Coleta de domínios e subdomínios relacionados"
echo -e "20) XSStrike           → Detecção e exploração de XSS"
echo -e "21) Dalfox             → Scanner automático de XSS"
echo -e "22) Katana             → Crawler para mapear rotas e endpoints web"
echo -e "23) Arjun              → Descoberta de parâmetros HTTP ocultos"
echo -e "24) Httpx              → Validação e análise de serviços HTTP/HTTPS"
echo -e "25) Nuclei             → Scanner baseado em templates"
echo -e " 0) Sair"
echo -e "${CYAN}════════════════════════════════════════════════════════${RESET}"
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
;;

2)
clone_if_not phoneinfoga https://github.com/sundowndev/phoneinfoga.git
cd phoneinfoga && go build && ./phoneinfoga -h
cd ..
;;

3)
pip install locust && locust -h
;;

4)
pkg install -y hping3
;;

5)
pip install slowloris
;;

6)
pkg install -y slowhttptest
;;

7)
nmap -h
;;

8)
nikto -h
;;

9)
pip install sqlmap && sqlmap -h
;;

10)
msfconsole
;;

11)
wpscan --help
;;

12)
whatweb --help
;;

13)
pip install wafw00f && wafw00f -h
;;

14)
clone_if_not dirsearch https://github.com/maurosoria/dirsearch.git
python dirsearch/dirsearch.py -h
;;

15)
go install github.com/OJ/gobuster/v3@latest
gobuster -h
;;

16)
go install github.com/ffuf/ffuf@latest
ffuf -h
;;

17)
go install github.com/owasp-amass/amass/v4/...@master
amass -h
;;

18)
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
subfinder -h
;;

19)
go install github.com/tomnomnom/assetfinder@latest
assetfinder
;;

20)
clone_if_not XSStrike https://github.com/s0md3v/XSStrike.git
python XSStrike/xsstrike.py -h
;;

21)
go install github.com/hahwul/dalfox/v2@latest
dalfox -h
;;

22)
go install github.com/projectdiscovery/katana/cmd/katana@latest
katana -h
;;

23)
pip install arjun && arjun -h
;;

24)
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
httpx -h
;;

25)
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
nuclei -h
;;

0)
echo -e "${RED}Saindo...${RESET}"
exit
;;

*)
echo -e "${RED}Opção inválida${RESET}"
;;

esac

read -p "Pressione ENTER para continuar..."
done
