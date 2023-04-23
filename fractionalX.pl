#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("CHA.cif");
$doc->MakeP1;

my $Atoms = $doc->UnitCell->Atoms;

# there is no $atom->FractionalX or $atom->FractionalXYZ->X 

foreach my $atom(@$Atoms){
        my $frac = $atom->FractionalXYZ;
        if ($frac){
                print($frac->X);
        }
}
