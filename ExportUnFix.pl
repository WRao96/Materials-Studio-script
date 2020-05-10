#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI Low energy.xtd");

my $atoms = $doc->DisplayRange->Atoms;
$atoms->Unfix("XYZ");
$doc->Export("./MFI_H2O_320.xsd");
