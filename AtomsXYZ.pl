#!perl
# Coder: Mr. Rao
# Time: 2020/03/20
# Purpose: Obatin center of each molecule every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_Dio_48_Fur_12.xtd");

my $trajectory = $doc->Trajectory;

my $File=Documents->New("AtomsXYZ.txt");

# Solute is Fur, and solvent is Acetone
my $NumberOfSolute = 12;
my $NumberOfSolvent = 48;

# Read from xtd file, we can know that the first 8 Molecules are solute, and the remained are solvent
# there are not 13 atoms in solvent molecule
# that $molecule->NumAtoms eq 13 is because there is 13 atoms in furfuryl alcohol
for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < 3 +  $NumberOfSolute + $NumberOfSolvent; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		if ($molecule->NumAtoms eq 13){
			my $atom1 = $molecule->Atoms("C2");
			my $atom2 = $molecule->Atoms("C9");
			$File->Append(sprintf "%s %f %f %f\n", "C2", $atom1->X, $atom1->Y, $atom1->Z);
			$File->Append(sprintf "%s %f %f %f\n", "C9", $atom2->X, $atom2->Y, $atom2->Z);
		}
	}
}
$File->Close;
