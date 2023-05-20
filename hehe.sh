#!/bin/bash
# SSH Over Websocket OpenSSH Method

wget -q -O /usr/local/bin/ws-vpn "https://raw.githubusercontent.com/muhammadnoor674/scvip/ipuk/hihi.py"
chmod +x /usr/local/bin/edu-vpn

cat > /etc/systemd/system/ws-vpn.service << END
[Unit]
Description=Python Proxy 
Documentation=https://dhans-project.xyz
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-vpn 443
Restart=on-failure
[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-vpn
systemctl restart ws-vpn
echo -e "Done Install Websocket SSL"
rm -f hehe.sh
