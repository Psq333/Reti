#!/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i eth2 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o eth2 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -N DMZRed
iptables -N RedDMZ
iptables -N allDMZ
iptables -N DMZAll

iptables -A FORWARD -i eth0 -o eth1 -s 10.0.0.0/22 -d 10.0.4.0/25 -j DMZRed
iptables -A FORWARD -i eth1 -o eth0 -s 10.0.4.0/25 -d 10.0.0.0/22 -j RedDMZ

iptables -A FORWARD -i eth0 -s 10.0.0.0/22 -j DMZAll
iptables -A FORWARD -o eth0 -d 10.0.0.0/22 -j allDMZ

iptables -A DMZRed -j ACCEPT
iptables -A RedDMZ -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZAll -p tcp --dport 53 -j ACCEPT
iptables -A DMZAll -p tcp --dport 25 -j ACCEPT
iptables -A DMZAll -p tcp --dport 21 -j ACCEPT
iptables -A allDMZ -p tcp --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A allDMZ -p tcp --sport 25 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A allDMZ -p tcp --sport 21 -m state --state ESTABLISHED,RELATED -j ACCEPT
