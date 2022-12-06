#! /bin/sh

iptables -F
iptables -X

iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth1 -s IPGREEN/Mask -j greenAll
iptables -A FORWARD -o eth1 -d IPGREEN/Mask -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j  ACCEPT


iptables -N GreenRed
iptables -N RedGreen
iptables -A FORWARD -i eth1 -o eth0 -s IPGREEN/Mask -d IPRed/Mask -j GreenRed
iptables -A FORWARD -i eth0 -o eth1 -s IPRed/Mask -d IPGREEN/Mask -j RedGreen
iptables -A GreenRed -p icmp --icmp_typ == 8 -j ACCEPT
iptables -A RedGreen -p icmp --icmp_typ == 0 -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT