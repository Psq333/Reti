#! /bin/perl

@iptables = qx{iptables -nvL};

$INPUT = 0;
$FORWARD = 0;
$OUTPUT = 0;
$LIBVIRT_OUT = 0;
$b = 0;

for(@iptables){
	@line = split/ /,$_;
	#print "@line\n";
	if(@line[0] = "Chain" and @line[1] = "LIBVIRT_OUT"){
		#print "@line\n";
		$b = 1;
	}
	for(@line){
		if($_ eq "INPUT"){
			$INPUT = @line[4];
		}
		if($_ eq "FORWARD"){
			$FORWARD = @line[4];
		}
		if($_ eq "OUTPUT"){
			$OUTPUT = @line[4];
		}
		
		if($b == 1 && @line[3] eq "ACCEPT"){
			$LIBVIRT_OUT += $_;
		}
	}
}

print "$INPUT $FORWARD $OUTPUT $LIBVIRT_OUT";
