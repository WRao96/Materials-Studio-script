#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_Dio_108_Fur_12.xtd");

#############################################
# Set "Furfuryl" and "C6H6" must be in MFI_C6H6_xtd
# They can be set manually
#############################################

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

my @dioxane;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		if ($molecule->ChemicalFormula eq "C4 H8 O2"){
			foreach my $atom(@{$molecule->Atoms}){
				push(@dioxane, $atom);
			}
		}
}

$doc->CreateSet("Dioxane", \@dioxane);
my $resultsA = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
	MSDMaxFrameLength => 100,
	MSDComputeAnisotropicComponents => "Yes",
	MSDSetA => "Dioxane"));
my $outMSDChartA = $resultsA->MSDChart;
my $outMSDChartAsStudyTableA = $resultsA->MSDChartAsStudyTable;