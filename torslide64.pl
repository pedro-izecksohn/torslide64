use strict;
use warnings;

print "torslide64 - Slide the numbers on a torus.\nWritten by: Pedro Izecksohn , izecksohn".'@'."yahoo.com\nVersion: 2020 November 14 15:25\nLicense: Free Software Foundation's GNU Public License version 3.\n\n";

my @table = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
             31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
			 61,62,63);

my %cursor = ('x',0,'y',0);

sub print_table {
	for (my $l=0;$l<8;$l++){
		for (my $c=0;$c<8;$c++){
			my $value = $table[($l*8)+$c];
			if ($value<10) {
				print 0;
				}
			print $value;
			print ',';
		}
		print "\n";
	}
}
#print_table();

sub apply_command
{
	my $command = shift;
	#print "cursor{x}=$cursor{x}\tcursor{y}=$cursor{y}\n";
	#print "command is $command.\n";
	if ($command eq 'u')
	{
		#print "command = u\n";
		if ($cursor{y}==0) {
			$table[$cursor{x}] = $table[56+$cursor{x}];
			$table[56+$cursor{x}] = 0;
			$cursor{y}=7;
			return;
			}
		$table[($cursor{y}*8)+$cursor{x}] = $table[(($cursor{y}-1)*8)+$cursor{x}];
		$table[(($cursor{y}-1)*8)+$cursor{x}] = 0;
		$cursor{y}--;
		return;
	}
  if ($command eq 'd')
	{
		#print "command = d\n";
		if ($cursor{y}==7) {
			$table[56+$cursor{x}] = $table[$cursor{x}];
			$table[$cursor{x}] = 0;
			$cursor{y}=0;
			return;
			}
		$table[($cursor{y}*8)+$cursor{x}] = $table[(($cursor{y}+1)*8)+$cursor{x}];
		$table[(($cursor{y}+1)*8)+$cursor{x}] = 0;
		$cursor{y}++;
		return;
	}
	if ($command eq 'l')
	{
		#print "command = l\n";
		if ($cursor{x}==0) {
			$table[$cursor{y}*8] = $table[$cursor{y}*8+7];
			$table[$cursor{y}*8+7] = 0;
			$cursor{x}=7;
			return;
			}
		$table[($cursor{y}*8)+$cursor{x}] = $table[($cursor{y}*8)+$cursor{x}-1];
		$table[($cursor{y}*8)+$cursor{x}-1] = 0;
		$cursor{x}--;
		return;
	}
	if ($command eq 'r')
	{
		#print "command = r\n";
		if ($cursor{x}==7) {
			$table[$cursor{y}*8+7] = $table[$cursor{y}*8];
			$table[$cursor{y}*8]=0;
			$cursor{x}=0;
			return;
			}
		$table[($cursor{y}*8)+$cursor{x}] = $table[($cursor{y}*8)+$cursor{x}+1];
		$table[($cursor{y}*8)+$cursor{x}+1] = 0;
		$cursor{x}++;
	}
}

my $level = 0;
until ($level>0)
{
	print "Enter the level (a number greater than 0): ";
	$level = <>;
	$level = int ($level);
}

sub table_is_right
{
	for (my $i=0;$i<64;$i++)
	{
		if ($table[$i]!=$i)
		{
		  return 0;
		}
	}
	return 1;
}

do {
for (my $i=0; $i<$level; $i++)
{
  my $r = rand(4);
  my @a = qw (u d l r);
  my $c = $a[$r];
  #print "$c\n";
  apply_command ($c);
  #print_table();
  #print "\n";
 }
} while (table_is_right);
#print "\n";
until (table_is_right)
{
	print_table();
	print "Enter u, d, r or l: ";
	my $command = <>;
	chomp $command;
	apply_command ($command);
}
print "You won.\n";
