#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $system = Documents->Import("Graphene.xsd");

my $results = Modules->CASTEP->GeometryOptimization->Run($system, Settings(
	CalculateBandStructure => "DispersionAndDos", 
	CalculateDOS => "Full", 
	CalculateELF => "FieldAndIsosurface", 
	CalculateBondOrder => "Mulliken", 
	CalculateCharge => "Mulliken", # or "Hirshfeld"
));
