#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MOR-C12.xsd");

my $File = Documents->New("CONFIG.txt");

my $Atoms = $doc->DisplayRange->Atoms;
my $Atom = 0;

my $ABC = $doc->DisplayRange->Lattice3D;

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

foreach my $atom (@$Atoms){
	if ($atom->ElementName ne "Hydrogen"){
		$Atom += 1;
	}
}


if ($NumberOfMolecules == 8){
	$File->Append(sprintf "Zeolite and Alkane\n");
	$File->Append(sprintf "0	3	%d\n", $Atom);
	$File->Append(sprintf "%f %f %f\n",$ABC->VectorA->X, $ABC->VectorA->Y, $ABC->VectorA->Z);
	$File->Append(sprintf "%f %f %f\n",$ABC->VectorB->X, $ABC->VectorB->Y, $ABC->VectorB->Z);
	$File->Append(sprintf "%f %f %f\n",$ABC->VectorC->X, $ABC->VectorC->Y, $ABC->VectorC->Z);
	
	$Atom = 0;
	
	foreach my $element (@$Atoms){
		if ($element->ElementSymbol eq "Al"){
			$Atom += 1;
			$File->Append(sprintf "Al %d\n %f %f %f\n", $Atom, $element->X, $element->Y, $element->Z);
		}
	
	}
	
	foreach my $element (@$Atoms){
		if ($element->ElementSymbol eq "Na"){
			$Atom += 1;
			$File->Append(sprintf "Na %d\n %f %f %f\n", $Atom, $element->X, $element->Y, $element->Z);
		}
	
	}
	
	foreach my $element (@$Atoms){
		if ($element->ElementSymbol eq "Si"){
			$Atom += 1;
			$File->Append(sprintf "Si %d\n %f %f %f\n", $Atom, $element->X, $element->Y, $element->Z);
		}
	
	}
	
	my @OAl;
	my @OSi;
	
	foreach my $element (@$Atoms){
		if ($element->ElementSymbol eq "O"){
			my $temp = 0;
			my $connectedAtoms = $element->AttachedAtoms;

			foreach my $conatom (@$connectedAtoms){
				if ($conatom->ElementSymbol eq "Al"){
					$temp += 1;	
				}
			}
			
			if ($temp == 1){
				push @OAl, $element;
			}
			if ($temp == 0){
				push @OSi, $element;
			}

		}
	
	}
	
	foreach my $Oatom (@OAl){
		$Atom += 1;
		$File->Append(sprintf "OAl %d\n %f %f %f\n", $Atom, $Oatom->X, $Oatom->Y, $Oatom->Z);
	}
	
	foreach my $Oatom (@OSi){
		$Atom += 1;
		$File->Append(sprintf "OSi %d\n %f %f %f\n", $Atom, $Oatom->X, $Oatom->Y, $Oatom->Z);
	}
	
	my @C4;
	my @C3;
	my @C2;
	my @C1;
	my @C0;

	foreach my $element (@$Atoms){
		if ($element->ElementSymbol eq "C"){
			my $temp = 0;
			my $connectedAtoms = $element->AttachedAtoms;
			
			foreach my $conatom (@$connectedAtoms){
				if ($conatom->ElementSymbol eq "H"){
					$temp += 1;	
				}
			}
			
			if ($temp == 4){
				push @C4, $element;
			}
			elsif ($temp == 3){
				push @C3, $element;
			}
			elsif ($temp == 2){
				push @C2, $element;
			}
			elsif ($temp == 1){
				push @C1, $element;
			}
			else {
				push @C0, $element;
			}
		}
	
	}
	
	foreach my $Catom (@C4){
		$Atom += 1;
		$File->Append(sprintf "C4 %d\n %f %f %f\n", $Atom, $Catom->X, $Catom->Y, $Catom->Z);
	}
	
	foreach my $Catom (@C3){
		$Atom += 1;
		$File->Append(sprintf "C3 %d\n %f %f %f\n", $Atom, $Catom->X, $Catom->Y, $Catom->Z);
	}
	
	foreach my $Catom (@C2){
		$Atom += 1;
		$File->Append(sprintf "C2 %d\n %f %f %f\n", $Atom, $Catom->X, $Catom->Y, $Catom->Z);
	}
	
	foreach my $Catom (@C1){
		$Atom += 1;
		$File->Append(sprintf "C1 %d\n %f %f %f\n", $Atom, $Catom->X, $Catom->Y, $Catom->Z);
	}
	
	foreach my $Catom (@C0){
		$Atom += 1;
		$File->Append(sprintf "C0 %d\n %f %f %f\n", $Atom, $Catom->X, $Catom->Y, $Catom->Z);
	}
	
	
}
