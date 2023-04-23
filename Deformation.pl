#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);
use List::Util qw(max);
use List::Util qw(min);
use Math::Trig;

my $doc = Documents->Import("MOR-C12.xtd");

my $trajectory = $doc->Trajectory;

my $File1 = Documents->New("LWH_D.txt");
my $File2 = Documents->New("sinuous_angle.txt");

$File1->Append("Long,Width,Height,Distance\n");
$File2->Append("Angle(degree)\n");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);		
		if ($molecule->ChemicalFormula eq "C12 H26"){
			my @X;
			my @Y;
			my @Z;
			my $Atoms = $molecule->Atoms;
			foreach my $atom (@$Atoms){
				if ($atom->ElementName eq "Carbon"){
					push @X, $atom->X;
					push @Y, $atom->Y;
					push @Z, $atom->Z;
				}

			}
			my $deltaX = &max(@X) - &min(@X);
			my $deltaY = &max(@Y) - &min(@Y);
			my $deltaZ = &max(@Z) - &min(@Z);
			my $deltaXYZ = sqrt((@X[-1]-@X[0])*(@X[-1]-@X[0])+(@Y[-1]-@Y[0])*(@Y[-1]-@Y[0])+(@Z[-1]-@Z[0])*(@Z[-1]-@Z[0]));
			$File1->Append(sprintf "%f,%f,%f,%f\n", $deltaX, $deltaY, $deltaZ, $deltaXYZ);
			
			for (my $index=0; $index<=$#X - 4; ++$index){
				my $L1x = @X[$index+2] - @X[$index];
				my $L2x = @X[$index+4] - @X[$index+2];
				my $L1y = @Y[$index+2] - @Y[$index];
				my $L2y = @Y[$index+4] - @Y[$index+2];
				my $L1z = @Z[$index+2] - @Z[$index];
				my $L2z = @Z[$index+4] - @Z[$index+2];
				
				my $L1 = sqrt($L1x * $L1x + $L1y * $L1y + $L1z * $L1z);
				my $L2 = sqrt($L2x * $L2x + $L2y * $L2y + $L2z * $L2z);
				
				my $cos = ($L1x * $L2x + $L1y * $L2y + $L1z * $L2z)/($L1 * $L2);
				my $degree = acos($cos) * 180 / 3.1415926;
				
				$File2->Append(sprintf "%f\n", $degree);
			}			
		}

	}
}
$File1->Close;
$File2->Close;





