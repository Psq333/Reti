#!/usr/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N redTAP
iptables -N TAPRed
iptables -N allGreen
iptables -N greenAll

iptables -A FORWARD -s 10.0.5.0/25 ! -d 10.0.0.0/22 -j redTAP
iptables -A FORWARD -d 10.0.5.0/25 ! -s 10.0.0.0/22-j TAPRed

iptables -A FORWARD -i eth1 -s 10.0.4.0/24 -j greenAll
iptables -A FORWARD -o eth1 -d 10.0.4.0/24 -j allGreen

iptables -A redTAP -j ACCEPT
iptables -A TAPRed -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESATBLISHED,RELATED -j ACCEPT
