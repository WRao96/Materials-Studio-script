#!perl
# Coder: Mr. Rao
# Time: 2020/09/28
# Purpose: Obtain coordination of  molecule C2 and C9 every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_Fur_12.xtd");

my $trajectory = $doc->Trajectory;

my $File = Documents->New("DipoleMoment.txt");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		if ($molecule->NumAtoms eq 13){
			my $atom1 = $molecule->Atoms("C2");
			my $atom2 = $molecule->Atoms("C9");
			my $atom3 = $molecule->Atoms("O12");
			my $atom4 = $molecule->Atoms("H13");
			my $p = $molecule->DipoleMoment;

			$File->Append(sprintf "%s %f %f %f\n", "C2", $atom1->X, $atom1->Y, $atom1->Z);
			$File->Append(sprintf "%s %f %f %f\n", "C9", $atom2->X, $atom2->Y, $atom2->Z);
			$File->Append(sprintf "%s %f %f %f\n", "O12", $atom3->X, $atom3->Y, $atom4->Z);
			$File->Append(sprintf "%s %f %f %f\n", "H13", $atom4->X, $atom4->Y, $atom4->Z);
			$File->Append(sprintf "%s %f %f %f\n", "Fur", $p->X, $p->Y, $p->Z);
			
			foreach my $atom (@{$molecule->Atoms}){
				if ($atom->IsInRing){
					$File->Append(sprintf "%s %f %f %f\n", "Ring".$atom->Name, $atom->X, $atom->Y, $atom->Z);
				}
			}	
		}
	}
}
$File->Close;
