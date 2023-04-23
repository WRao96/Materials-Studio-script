#!perl

use strict;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI.xsd");

my $fieldConnolly = Tools->AtomVolumesSurfaces->Connolly->Calculate($doc, Settings(
	ConnollyRadius => 2));
$fieldConnolly->IsVisible = "No";
my $isosurfaceConnolly = $fieldConnolly->CreateIsosurface([
	IsoValue => 0.0, 
	HasFlippedNormals  => "No"]);
