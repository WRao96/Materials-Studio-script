#!perl
# Coder: Mr. Rao
# Time: 2021/07/27
# Purpose: create the mesopore along z axis, which is a square mesopore of 2nm x 2nm from the MFI zeolite  
use strict;
use MaterialsScript qw(:all);

# Input files include initial MFI zeolite, shape of which must be longer than 4nm in x and y axis
# Output files include Meso_MFI345.xsd
my $doc = Documents->Import("MFI345.xsd");

my $Atoms = $doc->DisplayRange->Atoms;

foreach my $atom(@$Atoms){
	if ((($atom->X > 20.0) and ($atom->X < 40.0)) and (($atom->Y > 35.0) and ($atom->Y < 55.0))){
		$atom->Delete;
	}
}
$doc->Export("./Meso_MFI345.xsd");
$doc->Close;
