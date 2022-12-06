#! /bin/perl


$output = qx{arp -n};
chomp(@split);
@split = split/[\n]/,$output;

@s = split/[ ]/,$split[1];
chomp(@s);
chop(@s);
print("$#s\n"); 


