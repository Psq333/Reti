#!/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth1 -s 10.0.4.0/24 -j greenAll
iptables -A FORWARD -o eth1 -d 10.0.4.0/24 -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT


iptables -N allDMZ
iptables -N DMZAll
iptables -A FORWARD -o eth0 -d 10.0.0.0/23 -j allDMZ
iptables -A FORWARD -i eth0 -s 10.0.0.0/23 -j DMZAll
iptables -A allDMZ -j ACCEPT
iptables -A DMZall -m state --state ESTABLISHED,RELATED -j ACCEPT
