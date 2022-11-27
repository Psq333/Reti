#!/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -t nat -A PREROUTING -p tcp --dport 25 -j DNAT --to-destination 10.0.2.2:25

iptables -A PREROUTING -s 10.0.2.2 -j REJECT

#Green apre connessioni verso tutti
iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth1 -s 10.0.4.0/25 -j greenAll
iptables -A FORWARD -o eth1 -d 10.0.4.0/25 -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT


#DMZ può aprire connessioni verso RED
iptables -N DMZRed
iptables -N RedDMZ
iptables -A FORWARD -i eth0 -o eth2 -s 10.0.0.0/22 -d 10.0.4.128/29 -j DMZRed
iptables -A FORWARD -i eth2 -o eth0 -s 10.0.4.128/29 -d 10.0.0.0/22 -j RedDMZ
iptables -A DMZRed -j ACCEPT
iptables -A RedDMZ -m state --state ESTABLISHED,RELATED -j ACCEPT


#Apertura porta 53 - 25 - 21 di DMZ
iptables -N allDMZ
iptables -N DMZAll
iptables -A FORWARD -o eth0 -d 10.0.0.0/22 -j allDMZ
iptables -A FORWARD -i eth0 -s 10.0.0.0/22 -j DMZAll
iptables -A allDMZ -p tcp --dport 53 -j ACCEPT
iptables -A allDMZ -p tcp --dport 25 -j ACCEPT
iptables -A allDMZ -p tcp --dport 21 -j ACCEPT
iptables -A DMZAll -p tcp --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZAll -p tcp --sport 25 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A DMZAll -p tcp --sport 21 -m state --state ESTABLISHED,RELATED -j ACCEPT
