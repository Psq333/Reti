#!/usr/bin/sh

iptables -F
iptables -X #rimozioni catene

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenAll
iptables -N allGreen
iptables -N TAPDMZ
iptables -N DMZTAP
iptables -N TAP443
iptables -N 443TAP 

iptables -A INPUT -j TAP443
iptables -A OUTPUT -j 443TAP

iptables -A TAP443 --dport 443 -j ACCEPT
iptables -A 443TAP --sport 443 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -s 10.0.0.0/22 -j greenAll
iptables -A FORWARD -d 10.0.0.0/22 -j allGreen
iptables -A FORWARD -s 10.0.0.0/22 -d 10.0.4.0/23 -j greenRed
iptables -A FORWARD -d 10.0.4.0/23 -d 10.0.0.0/22 -j redGreen
iptables -A FORWARD -i eth3 -d 10.0.6.0/23-j greenDMZ
iptables -A FORWARD -o eth3 -s 10.0.6.0/23 -j DMZgreen

iptables -A greenAll -j ACCEPT
iptables -A greenAll -m state --state ESTABLISHED, RELATED -j ACCEPT
iptables -A greenDMZ -j ACCEPT
iptables -A DMZgreen -m state --state ESTABLISHED, RELATED -j ACCEPT
iptables -A greenRed -p icpm -j ACCEPT
iptables -A redGreen -p icmp -m state --state ESTABLISHED, RELATED -j ACCEPT
