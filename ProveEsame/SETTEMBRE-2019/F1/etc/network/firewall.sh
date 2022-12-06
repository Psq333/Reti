#!/usr/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenAll
iptables -N allGreen
iptables -N TAPDMZ
iptables -N DMZTAP
iptables -N TAPRed
iptables -N redTAP

iptables -A FORWARD -i eth1 -s 10.0.4.0/24 -j greenAll
iptables -A FORWARD -o eth1 -d 10.0.4.0/24 -j allGreen

iptables -A FORWARD -i eth0 -o eth1 -d 10.0.0.0/22 -j TAPDMZ
iptables -A FORWARD -o eth0 -i eth1 -s 10.0.0.0/22 -j DMZTAP

iptables -A FORWARD -i eth2 -o eth0 -s 10.0.5.0/25 -j redTAP
iptables -A FORWARD -i eth0 -o eth2 -d 10.0.5.0/25 -j TAPRed

iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESATBLISHED,RELATED -j ACCEPT
iptables -A TAPDMZ  -j ACCEPT
iptables -A DMZTAP -m state --state ESATBLISHED,RELATED -j ACCEPT
iptables -A redTAP  -j ACCEPT
iptables -A TAPRed -m state --state ESATBLISHED,RELATED -j ACCEPT

iptables -t nat -A PREROUTING -p tcp --dport 443 -j DNAT --to-destination SNatted1:443
iptables -t nat -A PREROUTING -p tcp --dport 21 -j DNAT --to-destination SNatted2:21
