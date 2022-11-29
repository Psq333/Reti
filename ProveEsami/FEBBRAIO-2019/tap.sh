tunctl -g netdev -t tap0

ifconfig tap0 IPTAP
ifconfig tap0 netmask MASK_SOTTORETE_TAP
ifconfig tap0 broadcast BROADCAST_SOTTORETE_TAP
ifconfig tap0 up

iptables -t nat -A POSTROUTING -o INTERFACCIA_VERSO_INTERNET -j MASQUERADE
iptables -A FORWARD -i tap0 -j ACCEPT

sysctl -w net.ipv4.ip_forward = 1

route add -net SOTTORETE/8 gw F1[eth0] dev tap0
