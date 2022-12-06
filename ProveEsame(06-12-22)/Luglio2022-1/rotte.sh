#! /bin/bash
#F1
#F1 -> TAP
post-up route add default -net gw IP_TAP dev eth2
#F1 -> GREEN
post-up route add IPGreen/22 -net gw R1[eth3] dev eth2
#F1 -> CD4
post-up route add -net IPCD4/30 gw R1[eth3] dev eth2
#F1 -> CD5
post-up route add -net IPCD5/30 gw R1[eth3] dev eth2
#F1 -> DMZ
post-up route add -net IPDMZ/23 gw R1[eth3] dev eth2

#R1
#R1 -> TAP
post-up route add -net default gw F1[eth2] dev eth3
#R1 -> RED
post-up route add -net IPRed/23 gw F1[eth2] dev eth3
#R1 -> CD5
post-up route add -net IPCD5/30 gw F2[eth0] dev eth0
#R1 -> GREEN
post-up route add -net IPGreen/22 gw F2[eth0] dev eth0

#F2
#F2 -> TAP
post-up route add -net default gw R1[eth0] dev eth0 
#F2 -> CD2
post-up route add -net IPCD2/30 gw R1[eth0] dev eth0 
#F2 -> RED
post-up route add -net IPRed/23 gw R1[eth0] dev eth0 
#F2 -> DMZ
post-up route add -net IPDMZ/23 gw R1[eth0] dev eth0 
#F2 -> GREEN
post-up route add -net IPGreen/22 gw R3[eth0] dev eth1 

#R3
#R3 -> TAP
post-up route add -net default gw F2[eth1] dev eth0
#R3 -> CD2
post-up route add -net IPCD2/30 gw F2[eth1] dev eth0
#R3 -> CD4
post-up route add -net IPCD4/30 gw F2[eth1] dev eth0
#R3 -> RED
post-up route add -net IPRed/23 gw F2[eth1] dev eth0
#R3 -> DMZ
post-up route add -net IPDMZ/23 gw F2[eth1] dev eth0