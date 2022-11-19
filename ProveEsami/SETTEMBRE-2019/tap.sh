

tunctl -g devnet tap0
ifconfig tap0 10.0.4.137
ifconfig tap0 netmask 255.255.255.252
ifconfig tap0 broadcast 10.0.4.139
ifconfig tap0 up
iptables -t nat -A POSTROUTING 
