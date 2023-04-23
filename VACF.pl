#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);


my $doc = Documents->Import("MFI_Dioxane_48_Furfuryl_12.xtd");
my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;
my @H2O;
for (my $i =0; $i < $NumberOfMolecules; ++$i){
     my $molecule = $doc->DisplayRange->Molecules($i);
        if ($molecule->ChemicalFormula eq "H2 O"){
            foreach my $atom(@{$molecule->Atoms}){
                push(@H2O, $atom);
            }
     }
}
$doc->CreateSet("Water", \@H2O);
my $results = Modules->Forcite->Analysis->VelocityAutocorrelationFunction($doc, Settings(
        VACFSetA => "Water",
        VACFMaxFrameLength => 100,
        VACFComputeAnisotropicComponents => "Yes"));
my $outVACFChart = $results->VACFChart;
my $outVACFChartAsStudyTable = $results->VACFChartAsStudyTable;

