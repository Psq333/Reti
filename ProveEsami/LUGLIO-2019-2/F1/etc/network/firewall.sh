#!/usr/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenRed
iptables -N redGreen
iptables -N redTAP
iptables -N TAPRed
iptables -N TAPDMZ
iptables -N DMZTAP

iptables -A FORWARD -i eth2 -o eth1 -s IPGreen/MaskGreen -d IPRed/MaskRed -j greenRed
iptables -A FORWARD -o eth2 -i eth1 -d IPGreen/MaskGreen -s IPRed/MaskRed -j redGreen
iptables -A FORWARD -i eth1 -o eth0 -s IPRed/MaskRed -j redTAP
iptables -A FORWARD -o eth1 -i eth0 -d IPRed/MaskRed -j TAPRed
iptables -A FORWARD -i eth0 -o eth2 -d IPDMZ/MaskDMZ -j TAPDMZ
iptables -A FORWARD -o eth0 -i eth2 -s IPDMZ/MaskDMZ -j DMZTAP

iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A redTAP -j ACCEPT
iptables -A TAPRed -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A TAPDMZ -j ACCEPT
iptables -A DMZTAP -m state --state ESTABLISHED,RELATED -j ACCEPT
