#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);


my $doc = Documents->Import("MFI_Dioxane_48_Furfuryl_12 Forcite Potential energy components.std");

my @Energy = ("Electrostatic energy: Profile", "Electrostatic energy: Running average", "Total potential energy: Profile","Total potential energy: Running average","van der Waals energy: Profile","van der Waals energy: Running average");
my @filename = ("EE_1.txt", "EE_2.txt", "TPE_1.txt", "TPE_2.txt", "VDW_1.txt", "VDW_2.txt");

my $SheetCount = $doc->Sheets->Count;
my $RowCount = $doc->Sheets(0)->RowCount;


for (my $i=0; $i<$SheetCount; ++$i){

	my $sheet = $doc->Sheets($i);
	my $title = $sheet->Title;
	
	for (my $j=0; $j< @Energy; ++$j){
	
		if ($title eq $Energy[$j]){
		
			my $file = Documents->New($filename[$j]);
			$file->Append(sprintf "%s,%s\n", "Time(ps)", $Energy[$j]);
			
			for (my $k=0; $k< $RowCount; ++$k){
			
				$file->Append(sprintf "%i,%f\n", $sheet->Cell($k,0), $sheet->Cell($k, 1));
			}
			$file->Close;
		}
	}
}
