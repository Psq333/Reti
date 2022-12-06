#! /bin/sh

iptables -F
iptables -X

iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N redTAP
iptables -N TAPRed
iptables -A FORWARD -i eth1 -o eth0 -s IPRED/Mask -j redTAP
iptables -A FORWARD -o eth1 -i eth0 -d IPRED/Mask-j TAPRed
iptables -A redTAP -j ACCEPT
iptables -A TAPRed -m state --state ESTABLISHED,RELATED -j  ACCEPT

iptables -N redDMZ
iptables -N DMZRed
iptables -A FORWARD -i eth1 -o eth2 -s IPRED/Mask -d IPDMZ/Mask -j redDMZ
iptables -A FORWARD -o eth1 -i eth2 -d IPRED/Mask -s IPDMZ/Mask -j DMZRed
iptables -A redDMZ -j ACCEPT
iptables -A DMZRed -m state --state ESTABLISHED,RELATED -j  ACCEPT

iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth2 -s IPGREEN/Mask -j greenAll
iptables -A FORWARD -o eth2 -d IPGREEN/Mask -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j  ACCEPT

iptables -N GreenRed
iptables -N RedGreen
iptables -A FORWARD -i eth2 -o eth1 -s IPGREEN/Mask -d IPRed/Mask -j GreenRed
iptables -A FORWARD -i eth1 -o eth2 -s IPRed/Mask -d IPGREEN/Mask -j RedGreen
iptables -A GreenRed -p icmp --icmp_typ == 8 -j ACCEPT
iptables -A RedGreen -p icmp --icmp_typ == 0 -j ACCEPT

iptables -A FORWARD -d IPF2 -p tcp --dport 443 -j ACCEPT
iptables -A FORWARD -s IPF2 -p tcp --sport 443 -j ACCEPT

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 1234 --to-destination S1:2222
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8052 --to-destination S3:22

iptables -t nat POSTROUTING -o tap0 -j MASQUERADE