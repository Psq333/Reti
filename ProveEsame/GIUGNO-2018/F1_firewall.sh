#!/bin/sh

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -N greenRed
iptables -N redGreen

iptables -A FORWARD -i eth1 -s 10.0.4.0/24 -j greenRed
iptables -A FORWARD -o eth1 -d 10.0.4.0/24 -j redGreen

iptables -A greenRed -j ACCEPT
iptables -A redGreen -m state --state ESTABLISHED,RELATED -j ACCEPT
