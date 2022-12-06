#!/bin/perl

die "Non inserire elementi" if(scalar(@ARGV) != 0);

#@output = qx{iptables -nvL};
open $fh, "<", "provaPerl.txt" || die "File non aperto";

%hash = {};

print("Pacchetti Droppati:\n");

$internetRED = 0;
$drop = 0;
$accept = 0;
$totale = 0;
for(@output){
    if(/Chain ([A-Z]+) \(policy DROP (\d+) packets/){
        print("$1:      $2\n");
        $totale += $2;
    }
    elsif(/Chain internetRED\(\d+ references\)/){
        $internetRED = 1;
    }
    if($internetRED == 1){
        if(/(\d*).*ACCEPT/){
            $accept =+ $1;
        }
        elsif(/(\d*).*DROP/){
            $drop =+ $1;
        }
    }
    if($internetRED == 1 && /^\n?/){
        $internetRED = 0;
    }
}

if($accept >= 10){
    qx{iptables -F internetRed};
}
else{
    print("internetRed:     $drop\n");
    $totale += $drop;
}
print("--------------------------------\n");
print("TOTALE: $totale");