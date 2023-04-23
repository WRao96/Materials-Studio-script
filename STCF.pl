#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_Dio_48_Fur_12.xtd");

my $resultsA = Modules->Forcite->Analysis->SpaceTimeCorrelationFunction($doc, Settings(
	STCFSetA => "Dioxane", 
	STCFFrameOriginStep => 200, 
	STCFMaxFrameLength => 99.99, 
	STCFCutoff => 20));
my $outSelfSTCFChartA = $resultsA->SelfSTCFChart;
my $outSelfSTCFChartAsStudyTableA = $resultsA->SelfSTCFChartAsStudyTable;
my $outDistinctSTCFChartA = $resultsA->DistinctSTCFChart;
my $outDistinctSTCFChartAsStudyTableA = $resultsA->DistinctSTCFChartAsStudyTable;


my $resultsB = Modules->Forcite->Analysis->SpaceTimeCorrelationFunction($doc, Settings(
        STCFSetA => "Furfuryl",
        STCFFrameOriginStep => 200,
        STCFMaxFrameLength => 99.99,
        STCFCutoff => 20));
my $outSelfSTCFChartB = $resultsB->SelfSTCFChart;
my $outSelfSTCFChartAsStudyTableB = $resultsB->SelfSTCFChartAsStudyTable;
my $outDistinctSTCFChartB = $resultsB->DistinctSTCFChart;
my $outDistinctSTCFChartAsStudyTableB = $resultsB->DistinctSTCFChartAsStudyTable;
