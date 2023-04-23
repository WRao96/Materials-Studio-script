#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("Dio_inter_1.xsd");

my $results = Modules->Forcite->GeometryOptimization->Run($doc,Settings(
	CurrentForcefield => "COMPASS",
	ChargeAssignment => "Forcefield assigned"));

