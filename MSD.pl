#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_C6H6.xtd");

#############################################
# Set "Furfuryl" and "C6H6" must be in MFI_C6H6_xtd
# They can be set manually
#############################################

my $resultsA = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
	MSDMaxFrameLength => 100,
	MSDComputeAnisotropicComponents => "Yes",
	MSDSetA => "Furfuryl"));
my $outMSDChartA = $resultsA->MSDChart;
my $outMSDChartAsStudyTableA = $resultsA->MSDChartAsStudyTable;

my $resultsB = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
	MSDMaxFrameLength => 100,
	MSDComputeAnisotropicComponents => "Yes",
	MSDSetA => "C6H6"));
my $outMSDChartB = $resultsB->MSDChart;
my $outMSDChartAsStudyTableB = $resultsB->MSDChartAsStudyTable;
