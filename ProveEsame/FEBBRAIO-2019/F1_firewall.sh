#! /bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth2 -s IPGREEN/MASK -j greenAll
iptables -A FORWARD -o eth2 -d IPGREEN/MASK -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED, RELATED -j ACCEPT

iptables -N redTAP
iptables -N TAPRed
iptables -A FORWARD -i eth1 -o eth0 -s IPRED/MASK -j redTAP
iptables -A FORWARD -i eth0 -o eth1 -d IPRED/MASK -j TAPRed
iptables -A redTAP -j ACCEPT
iptables -A TAPRed -m state --state ESTABLISHED, RELATED -j ACCEPT

iptables -N TAPDMZ
iptables -N DMZTAP
iptables -A FORWARD -i eth0 -o eth2 -d IPDMZ/MASK -j TAPDMZ
iptables -A FORWARD -o eth0 -i eth2 -s IPDMZ/MASK -j DMZTAP
iptables -A TAPDMZ -j ACCEPT
iptables -A DMZTAP -m state --state ESTABLISHED, RELATED -j ACCEPT
