#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->New("Ethanol.xsd");
my $H1 = $doc->CreateAtom("H",Point());
my $H2 = $doc->CreateAtom("H",Point());
my $H3 = $doc->CreateAtom("H",Point());
my $H4 = $doc->CreateAtom("H",Point());
my $H5 = $doc->CreateAtom("H",Point());
my $H6 = $doc->CreateAtom("H",Point());
my $C1 = $doc->CreateAtom("C",Point());
my $C2 = $doc->CreateAtom("C",Point());
my $O = $doc->CreateAtom("O",Point());

$doc->CreateBond($H1,$C1,"Single");
$doc->CreateBond($H2,$C1,"Single");
$doc->CreateBond($H3,$C1,"Single");
$doc->CreateBond($C2,$C1,"Single");
$doc->CreateBond($H4,$C2,"Single");
$doc->CreateBond($H5,$C2,"Single");
$doc->CreateBond($O,$C2,"Single");
$doc->CreateBond($O,$H6,"Single");

my $mol = $doc->CreateMolecule([$H1,$H2,$H3,$H4,$H5,$H6,$C1,$C2,$O]);

my $results = Modules->Forcite->GeometryOptimization->Run($doc,Settings(
	CurrentForcefield => "COMPASS",
	ChargeAssignment => "Forcefield assigned"));
