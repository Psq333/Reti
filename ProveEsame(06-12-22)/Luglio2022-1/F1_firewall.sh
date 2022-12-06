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
iptables -A FORWARD -i eth2 -s IPGreen/22 -j greenAll
iptables -A FORWARD -o eth2 -d IPGreen/22 -j allGreen
iptables -A greenAll -j ACCEPT
iptables -A allGreen -m state --state ESTABLISHED,REALTED -j ACCEPT

# Red verso TAP e DMZ
iptables -N redTAP
iptables -N TAPRed
iptables -N redDMZ
iptables -N DMZRed
iptables -A FORWARD -i eth1 -o eth0 -s IPRed/23 -j redTAP
iptables -A FORWARD -i eth0 -o eth1 -d IPRed/23 -j TAPRed
iptables -A FORWARD -i eth1 -o eth2 -s IPRed/23 -d IPGreen/23 -j redDMZ
iptables -A FORWARD -i eth2 -o eth1 -s IPGreen/23 -d IPRed/23 -j DMZRed
iptables -A redTAP -j ACCEPT
iptables -A TAPRed -m state --state ESTABLISHED,REALTED -j ACCEPT
iptables -A redDMZ -j ACCEPT
iptables -A DMZRed -m state --state ESTABLISHED,REALTED -j ACCEPT

#icmpVersoRed
iptables -N greenRed
iptables -N redGreen
iptables -A FORWARD -i eth2 -o eth1 -s IPGreen/22 -d IPRed/23 -j greenRed
iptables -A FORWARD -i eth1 -o eth2 -s IPRed/23 -d IPGreen/22 -j redGreen
iptables -A greenRed -p icmp --icmp-type 8 -j ACCEPT
iptables -A redGreen -p icmp --icmp-type 0 -j ACCEPT

#Apertura porta 443 DI F2
iptables -A FORWARD -i eth0 -o eth2 -d IPF2 -t tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -s IPF2 -t tcp --sport 443 -j ACCEPT

#Natting
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 1234 -j DNAT --to-destination S1[eth0]:2222
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8052 -j DNAT --to-destination S3[eth0]:22

#Mascherare IP
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source F1[eth0]