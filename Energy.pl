#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MOR_CH4.xsd");

my $results = Modules->Forcite->Energy->Run($doc,Settings(CurrentForcefield => "COMPASS"));
