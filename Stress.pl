#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_12Acetone_R1.xtd");

my $NumberOfMolecules = $doc->UnitCell->Molecules->Count;
print $NumberOfMolecules;
my @acetone;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->UnitCell->Molecules($i);
		if ($molecule->ChemicalFormula eq "C3 H6 O"){
			my $atoms = $molecule->Atoms;
			push(@acetone, $doc->CreateCentroid($atoms));
		}
}

$doc->CreateSet("Acetone", \@acetone);

my $resultG = Modules->Forcite->Analysis->StressAutocorrelationFunction($doc, Settings(
	SACFMaxFrameLength => 99.995, 
	SACFComputeAnisotropicComponents => "Yes"));
my $outSACFChart = $resultG->SACFChart;
my $outSACFChartAsStudyTable = $resultG->SACFChartAsStudyTable;
my $outSACFViscosityStudyTable = $resultG->SACFViscosityStudyTable;


