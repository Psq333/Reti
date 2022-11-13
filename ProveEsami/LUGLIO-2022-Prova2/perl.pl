#! /bin/perl

@output = qx{arp};
$uno = @output[1];
print("+$uno");
@s = split/ /,$uno;
print "@s[0]";
