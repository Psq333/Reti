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


iptables -A FORWARD -i eth0 -s IPGreen/MaskGreen -j greenAll
iptables -A FORWARD -o eth0 -d IPGreen/MaskGreen -j allGreen
iptables -A FORWARD -i eth2 -o eth1 -d IPDMZ/MaskDMZ -j TAPDMZ
iptables -A FORWARD -o eth2 -i eth1 -s IPDMZ/MaskDMZ -j DMZTAP


iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A TAPDMZ -j ACCEPT
iptables -A DMZTAP -m state --state ESTABLISHED,RELATED -j ACCEPT
