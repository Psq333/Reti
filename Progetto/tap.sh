#!/bin/bash

tunctl -g netdev -t tap0
ifconfig tap0 10.0.4.145
ifconfig tap0 netmask 255.255.255.252
ifconfig tap0 broadcast 10.0.4.147
ifconfig tap0 up
iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
iptables -A FORWARD -i tap0 -j ACCEPT
sysctl -w net.ipv4.ip_forward = 1
route add -net 10.0.0.0/8 gw 10.0.4.146 dev tap0
