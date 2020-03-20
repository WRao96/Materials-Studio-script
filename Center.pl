#!perl
# Coder: Mr. Rao
# Time: 2020/03/20
# Purpose: Obatin center of each molecule every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_Fur_Acetone.xtd");

my $trajectory = $doc->Trajectory;

my $File=Documents->New("center.txt");

# Solute is Fur, and solvent is Acetone
my $NumberOfSolute = 8;
my $NumberOfSolvent = 80;

# Read from xtd file, we can know that the first 8 Molecules are solute, and the remained are solvent
for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < $NumberOfSolute; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		my $center = $molecule->center;
		$File->Append(sprintf "%s %f %f %f \n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
	}

	for (my $i = $NumberOfSolute; $i < $NumberOfSolvent + $NumberOfSolute; ++$i ){
		my $molecule = $doc->DisplayRange->Molecules($i);
		my $center = $molecule->center;
		$File->Append(sprintf "%s %f %f %f \n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
	}
}
$File->Close;
