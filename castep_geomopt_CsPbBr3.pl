#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $system = Documents->Import("CsPbBr3.xsd");

my $results = Modules->CASTEP->GeometryOptimization->Run($system, Settings(
	OptimizeCell => "Yes",
	CalculateDOS => "Full"
));

