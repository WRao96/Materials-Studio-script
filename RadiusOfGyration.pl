#!perl

use strict;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_C12H26.xtd");
my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

my @C12;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
                my $molecule = $doc->DisplayRange->Molecules($i);
                if ($molecule->ChemicalFormula eq "C12 H26"){
                        foreach my $atom(@{$molecule->Atoms}){
                                push(@C12, $atom);
                        }
                }
}

$doc->CreateSet("Alkane", \@C12);

my $resultG = Modules->Forcite->Analysis->RadiusOfGyration($doc, Settings(
        RadiusOfGyrationSetA => "Alkane"));
my $outRadiusOfGyrationChartA = $resultG->RadiusOfGyrationChart;
my $outRadiusOfGyrationChartAsStudyTableA = $resultG->RadiusOfGyrationChartAsStudyTable;
