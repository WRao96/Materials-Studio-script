#!perl

use strict;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI.xtd");
my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;
my @H2O;

for (my $i=0; $i < $NumberOfMolecules; ++$i){
	my $molecule = $doc->DisplayRange->Molecules($i);
	if ($molecule->ChemicalFormula eq "H2 O"){
		my $Bonds = $molecule->Bonds;
		foreach my $Bond(@$Bonds){
			my $atom1 = $Bond->Atom1;
			my $atom2 = $Bond->Atom2;
			my $distance = $doc->CreateDistance([$atom1, $atom2]);
			push(@H2O,$distance);
		}
	}

}

$doc->CreateSet("H2O", \@H2O);
my $results = Modules->Forcite->Analysis->RotationalTimeCorrelationFunction($doc, Settings(
	RTCFSetA => "H2O",
	RTCFFrameOriginStep => 1,
	RTCFMaxFrameLength => 100));
my $outRTCFChart = $results->RTCFChart;
my $outRTCFChartAsStudyTable = $results->RTCFChartAsStudyTable;

