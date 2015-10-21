#!/bin/bash

# setup vpn interface
sudo pptpsetup --create myvpn --server 100.43.131.82 --username dycforever --password dyc19871114 --encrypt --start

# modify route
sudo ip route del default 
sudo ip route add default dev ppp0

# stop vpn
sudo poff myvpn

# restore route
sudo ip route add default via 192.168.1.1

sudo cat > /etc/ppp/ip-up.d/route-traffic << EOF
#!/bin/bash
/sbin/ip route del default
/sbin/ip route add default dev ppp0
EOF

sudo cat > /etc/ppp/ip-down.d/disableroute << EOF
#!/bin/bash
/sbin/ip route add default via 192.168.1.1
EOF

# vpn on
sudo pon myvpn

