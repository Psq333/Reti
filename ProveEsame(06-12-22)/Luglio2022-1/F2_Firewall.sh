#! /bin/sh

iptables -F
iptables -X

iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#GreenAll
iptables -N greenAll
iptables -N allGreen
iptables -A FORWARD -i eth1 -s IPGreen/22 -j greenAll
iptables -A FORWARD -o eth1 -d IPGreen/22 -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,REALTED -j ACCEPT

#icmpVersoRed
iptables -N greenRed
iptables -N redGreen
iptables -A FORWARD -i eth1 -o eth0 -s IPGreen/22 -d IPRed/23 -j greenAll
iptables -A FORWARD -i eth0 -o eth1 -s IPRed/23 -d IPGreen/22 -j allGreen
iptables -A greenAll -p icmp --icmp-type = 8 -j ACCEPT
iptables -A allGreen -p icmp --icmp-type = 0 -j ACCEPT

#Apertura porta 443
iptables -A INPUT -i eth0 -t tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -o eth0 -t tcp --sport 443 -j ACCEPT
