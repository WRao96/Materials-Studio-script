#!perl
# Coder: Mr. Rao
# Time: 2020/09/28
# Purpose: Obtain coordination of  molecule C2 and C9 every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI.xtd");

my $NumberOfMolecules = $doc->UnitCell->Molecules->Count;
my @center;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
        my $molecule = $doc->UnitCell->Molecules($i);
		my $atoms = $molecule->Atoms;
		push @center,$doc->CreateCentroid($atoms);
}

$doc->CreateSet("Cen", \@center);

my $resultF = Modules->Forcite->Analysis->RadialDistributionFunction($doc, Settings(
        RDFComputeMolecularComponents => "No",
        RDFComputeStructureFactor => "No",
        RDFSetA => "Cen",
        RDFSetB => "Cen"));
my $outRDFChart = $resultF->RDFChart;
my $outRDFChartAsStudyTable = $resultF->RDFChartAsStudyTable;

