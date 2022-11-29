#!/bin/perl


$numConnessioni = 0;


while(1){
	@netstat = qx{netstat -t};
	$numConnessioni = 0;
	chomp(@netstat);
	for(@netstat){
		if ($_ =~ /ESTABLISHED/){
			$numConnessioni = $numConnessioni + 1;
		}
	}
	print("Le porte ESTABLISHED sono: $numConnessioni\n");
	
	sleep(5);
}	
