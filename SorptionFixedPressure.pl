#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

Documents->Import("MFI.xsd");
my $doc = $Documents{"MFI.xsd"};

###############################################################

# unit of fugacity is kPa, calculating energy will return heat of adsorption
my $sorptionFixedPressure = Modules->Sorption->FixedPressure;
my $component1 = Documents->Import("H2O.xsd");
$sorptionFixedPressure->AddComponent($component1);
$sorptionFixedPressure->Fugacity($component1) = 101;
my $results = $sorptionFixedPressure->Run($doc, Settings(
	CurrentForcefield => "COMPASS",
	NumEquilibrationSteps => 5000000,
	NumProductionSteps => 10000000,
	ReturnLowEnergyConfigurations => "Yes",
	CalculateProbabilityFields => "Yes",
	CalculateEnergyFields => "Yes",
	CalculateEnergyDistributions => "Yes"));
