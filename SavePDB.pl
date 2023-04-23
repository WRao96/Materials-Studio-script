#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI Low energy.xtd");
$doc->Export("./MFI_H2O_32_1.pdb");
