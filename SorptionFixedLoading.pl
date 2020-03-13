#!perl
use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

Documents->Import("MFI.xsd");
my $doc = $Documents{"MFI.xsd"};

###############################################################

my $sorptionFixedLoading = Modules->Sorption->FixedLoading;
my $component1 = Documents->Import("Furfuryl.xsd");
$sorptionFixedLoading->AddComponent($component1);
$sorptionFixedLoading->Loading($component1) = 8;

# calculating Energy will return heat of adsorption
my $results = $sorptionFixedLoading->Run($doc, Settings(
	CurrentForcefield => "COMPASS",
	AssignChargeGroups => "Yes",
	Temperature => 298,
	LoadingMoves => 5000000,
	NumEquilibrationSteps => 5000000,
	ReturnLowEnergyConfigurations => "Yes",
	CalculateProbabilityFields => "Yes",
	CalculateEnergyFields => "Yes",
	CalculateEnergyDistributions => "Yes"));
