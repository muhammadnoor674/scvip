!/bin/bash
grey='\x1b[90m'
red='\x1b[91m'
green='\x1b[92m'
yellow='\x1b[93m'
blue='\x1b[94m'
purple='\x1b[95m'
cyan='\x1b[96m'
white='\x1b[37m'
bold='\033[1m'
off='\x1b[m'
flag='\x1b[47;41m'

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )

MYIP=$(wget -qO- ipinfo.io/ip);
IZIN=$( curl https://muhammadnoor.github.io/izin | grep $MYIP )
echo "Memeriksa Hak Akses VPS..."
if [ $MYIP = $IZIN ]; then
clear
echo -e "${green}Akses Diizinkan...${off}"
sleep 1
else
clear
echo -e "${red}Akses Diblokir!${off}"
echo "Hanya Untuk Pengguna Berbayar!"
echo "Silahkan Hubungi Admin"
exit 0
fi
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif


source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Terima Kasih Telah Menggunakan Layanan Kami"
echo -e "Berikut Detail Akun SSH Dan OpenVPN"
echo -e "==============================="
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "Domain         : $domain"
echo -e "==============================="
echo -e "Host           : $MYIP"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "Stunnel        :$ssl"
echo -e "WebSocket      : 8880"
echo -e "Port Squid     :$sqd"
echo -e "OpenVPN        : TCP $ovpn http://$MYIP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN        : UDP $ovpn2 http://$MYIP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN        : SSL 442 http://$MYIP:81/client-tcp-ssl.ovpn"
echo -e "badvpn         : 7100-7300"
echo -e "==============================="
echo -e "Payload Websocket :"
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" |
echo -e "Setting SSH Websocket :"
echo -e "bimbel.ruangguru.com:2082@$Login:$Pass"
echo -e "==============================="
echo -e "Aktif Selama   : $masaaktif Hari"
echo -e "Berakhir Pada  : $exp"
echo -e "Mod By NYARIGRATISAN - STORE"
