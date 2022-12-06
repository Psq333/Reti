#!bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED  -j ACCEPT

iptables -A FORWARD -i eth0 -p tcp --dport 22 -d 10.0.4.138 -j ACCEPT
iptables -A FORWARD -o eth0 -p tcp --sport 22 -s 10.0.4.138 -j ACCEPT

iptables -N greenAll
iptables -N allGreen
iptables -N DMZTAP
iptables -N TAPDMZ
iptables -N DMZRed
iptables -N RedDMZ

iptables -A FORWARD -i eth1 -s 10.0.4.128/29 -j greenAll
iptables -A FORWARD -o eth1 -d 10.0.4.128/29 -j allGreen
iptables -A FORWARD -s 10.0.0.0/22 -j DMZAll
iptables -A FORWARD -d 10.0.0.0/22 -j allDMZ
iptables -A FORWARD -i eth2 -o eth2 -s 10.0.0.0/22 -d 10.0.4.0/25 -j DMZRed
iptables -A FORWARD -i eth1 -o eth1 -s 10.0.4.0/25 -d 10.0.0.0/22 -j RedDMZ

iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A allDMZ -p tcp --dport 53 -j ACCEPT
iptables -A allDMZ -p tcp --dport 25 -j ACCEPT
iptables -A allDMZ -p tcp --dport 21 -j ACCEPT
iptables -A DMZAll -p tcp --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZAll -p tcp --sport 25 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZAll -p tcp --sport 21 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZRed -j ACCEPT
iptables -A RedDMZ -m state --state ESTABLISHED,RELATED -j ACCEPT
