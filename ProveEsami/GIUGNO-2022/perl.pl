#!/bin/perl

@netstat = qx{netstat -t 192.168.1.50};
$numConnessioni = 0;
chomp(@netstat);

while(1){
	print "ok";
	for(@netstat){
		if ($_ =~ /ESTABLISHED/){
			$numConnessioni = $numConnessioni + 1;
		}
	}
	#print($numConnessioni);
	
}	
