#!/usr/bin/sh

iptables -F
iptables -X #rimozioni catene

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N redDMZ
iptables -N DMZRed
iptables -N TAPDMZ
iptables -N DMZTAP

iptables -A FORWARD -o eth2 -d 10.0.6.0/23-j TAPDMZ
iptables -A FORWARD -i eth2 -s 10.0.6.0/23 -j DMZTAP
iptables -A FORWARD -o eth2 -s 10.0.4.0/23 -d 10.0.6.0/23-j redDMZ
iptables -A FORWARD -i eth2 -s 10.0.6.0/23 -d 10.0.4.0/23 -j DMZRed


iptables -A TAPDMZ -j ACCEPT
iptables -A DMZTAP -m state --state ESTABLISHED, RELATED -j ACCEPT
iptables -A redDMZ -j ACCEPT
iptables -A DMZRed -m state --state ESTABLISHED, RELATED -j ACCEPT


iptables -t nat -A PREROUTING -i eth0 --dport 1234 --to-destination 10.0.6.2:2222
iptables -t nat -A PREROUTING -i eth0 --dport 8052 --to-destination 10.0.7.2:22

iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 200.0.0.4
