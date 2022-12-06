#!/usr/bin/sh

iptables -F
iptables -X

iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -P INPUT DROP

iptables -N redDMZ
iptables -N DMZRed
iptables -N redTAP
iptables -N TAPRed

iptables -F FORWARD -s 10.0.8.0/22 -d 10.0.12.0/23 -j redDMZ
iptables -F FORWARD -s 10.0.12.0/23 -d 10.0.8.0/22 -j DMZRed
iptables -F FORWARD -o eth0 -s 10.0.8.0/22 -j redTAP
iptables -F FORWARD -i eth0 -d 10.0.8.0/22 -j TAPRed

iptables -F redDMZ -j ACCEPT
iptables -F DMZRed -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -F redTAP -j ACCEPT
iptables -F TAPRed -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -F PREROUTING -i eth0 --dport 1090 -j DNAT --to-destination 10.0.12.2:443
iptables -t nat -F PREROUTING -i eth0 --dport 5657 -j DNAT --to-destination 10.0.12.3:25 
