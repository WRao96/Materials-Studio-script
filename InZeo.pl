#!perl
# Coder: Mr. Rao
# Time: 2021/11/08
# Purpose: Obatin the number of each molecule in zeolite every frames from trajectory file
use strict;
use MaterialsScript qw(:all);
use POSIX;

my $doc = Documents->Import("MFI.xtd");

my $trajectory = $doc->Trajectory;
my $Molecules = $doc->UnitCell->Molecules;
my $File = Documents->New("InZeo.txt");
my $lengthB = $doc->Lattice3D->LengthB;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	my $counter = 0;
	foreach my $molecule(@{$Molecules}){
		my $center = $molecule->center;
		my $Y = &pbc($center->Y);
		if (($Y < ($lengthB / 32.0 * 17.0)) and ($Y > ($lengthB / 32.0))){
			$counter += 1;
		}
	}
	$File->Append(sprintf "%d\n", $counter);
}
$File->Close;

sub pbc{
	my $y = @_[0];
# my $y = @_; is wrong for @_ representing the length of the list, which equals to 1
	my $divisor = floor($y / $lengthB);
	my $result = $y - $divisor * $lengthB;
	return($result);
}

