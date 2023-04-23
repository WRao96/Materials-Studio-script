#!perl
# Coder: Mr. Rao
# Time: 2022/09/08
# Purpose: Obatin the coordinates of each molecular center in a periodic box every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_010_OCH3.xtd");

my $trajectory = $doc->Trajectory;
my $Molecules = $doc->UnitCell->Molecules;
my $File = Documents->New("CoorInBox.txt");
my $lengthA = $doc->Lattice3D->LengthA;
my $lengthB = $doc->Lattice3D->LengthB;
my $lengthC = $doc->Lattice3D->Lengthc;

for (my $frame=0; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	foreach my $molecule(@{$Molecules}){
		my $center = $molecule->center;
		my ($X, $Y, $Z) = &pbc($center->X, $center->Y, $center->Z);
		$File->Append(sprintf "%d	%10.3f	%10.3f	%10.3f\n ", $frame, $X, $Y, $Z);
	}
}
$File->Close;

sub pbc{
	my $x = @_[0];
	my $y = @_[1];
	my $z = @_[2];
	# my $y = @_; is wrong for @_ representing the length of the list, which equals to 1
	
	my $divx = $x / $lengthA;
	my $divy = $y / $lengthB;
	my $divz = $z / $lengthC;
	if ($divx < 0){
		$divx = int($divx - 1);
	}
	else{
		$divx = int($divx);
	}
	if ($divy < 0){
		$divy = int($divy - 1);
	}
	else{
		$divy = int($divy);
	}
	if ($divz < 0){
		$divz = int($divz - 1);
	}
	else{
		$divz = int($divz);
	}

	my $resultx = $x - $divx * $lengthA;
	my $resulty = $y - $divy * $lengthB;
	my $resultz = $z - $divz * $lengthC;
	return($resultx, $resulty, $resultz);
}

