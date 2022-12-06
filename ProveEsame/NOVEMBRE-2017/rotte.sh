
#F1
#CD1 -> CD2
route add -net 10.0.0.0/23 gw R1[eth0] dev eth1

#F2
#CD2 -> CD1
eoute add -net 10.0.2.0/25 gw F![eth1] dev eth0
