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
      ⚡ Powered by SystemDown
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
echo -e "${CYAN}════════════════════════════════════════════${RESET}"
echo " 1) TheHarvester"
echo " 2) PhoneInfoga"
echo " 3) Locust"
echo " 4) Hping3"
echo " 5) Slowloris"
echo " 6) SlowHTTPTest"
echo " 7) Nmap"
echo " 8) Nikto"
echo " 9) SQLmap"
echo "10) Metasploit"
echo "11) WPScan"
echo "12) WhatWeb"
echo "13) Wafw00f"
echo "14) Dirsearch"
echo "15) Gobuster"
echo "16) FFUF"
echo "17) Amass"
echo "18) Subfinder"
echo "19) Assetfinder"
echo "20) XSStrike"
echo "21) Dalfox"
echo "22) Katana"
echo "23) Arjun"
echo "24) Httpx"
echo "25) Nuclei"
echo " 0) Sair"
echo -e "${CYAN}════════════════════════════════════════════${RESET}"
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
