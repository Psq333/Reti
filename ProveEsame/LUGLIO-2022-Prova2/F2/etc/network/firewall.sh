#!/usr/bin/sh

iptables -F
iptables -X

iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -P INPUT DROP

iptables -N greenAll
iptables -N allGreen
iptables -N allDMZ
iptables -N DMZAll

iptables -F FORWARD -s 10.0.0.0/21 -j greenAll
iptables -F FORWARD -d 10.0.0.0/21 -j allGreen
iptables -F FORWARD -s 10.0.12.0/23 -j DMZAll
iptables -F FORWARD -d 10.0.12.0/23 -j allDMZ

iptables -F greenAll -j ACCEPT
iptables -F allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -F allDMZ -j ACCEPT
iptables -F DMZAll -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -F FORWARD -p icmp icmp-type = 0 -s 10.0.0.0/21 -d 10.0.8.0/22 -j ACCEPT
iptables -F FORWARD -p icmp icmp-type = 8 -s 10.0.8.0/22 -d 10.0.0.0/21 -j ACCEPT

iptables -F INPUT -p tcp --dport 443 -j ACCEPT
iptables -F OUTPUT -p tcp --sport 443 -j ACCEPT
