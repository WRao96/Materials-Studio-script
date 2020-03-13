#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

Documents->Import("MFI.xsd");
my $doc = $Documents{"MFI.xsd"};

###############################################################


my $sorptionAdsorptionIsotherm = Modules->Sorption->AdsorptionIsotherm;
my $component1 = Documents->Import("Furfuryl.xsd");
$sorptionAdsorptionIsotherm->AddComponent($component1);
$sorptionAdsorptionIsotherm->FugacityStart($component1) = .01;
$sorptionAdsorptionIsotherm->FugacityEnd($component1) = 1000;

my $results = $sorptionAdsorptionIsotherm->Run($doc, Settings(
	CurrentForcefield => "COMPASS",
	NumEquilibrationSteps => 500000,
	NumProductionSteps => 1000000,
	NumFugacitySteps => 50,
	CalculateProbabilityFields => "Yes",
	CalculateEnergyFields => "Yes",
	CalculateEnergyDistributions => "Yes",
	UseFugacityLogScale => "Yes"));
