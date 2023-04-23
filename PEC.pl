#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_Dioxane_48_Furfuryl_12.xtd");

my $results = Modules->Forcite->Analysis->PotentialEnergyComponents($doc, Settings(
	PotentialEnergyComponentsShowAll => "Yes"));
my $outPotentialEnergyComponentsChart = $results->PotentialEnergyComponentsChart;
my $outPotentialEnergyComponentsChartAsStudyTable = $results->PotentialEnergyComponentsChartAsStudyTable;

