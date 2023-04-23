#!perl
# Coder: Mr. Rao
# Time: 2021/03/28
# Purpose: Obtain the torsion or dihedral  and radius of gyration of C-C chain in C12H26 from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MOR-C12.xtd");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

my @C12H26;
my @C12H26_Torsion;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
                my $molecule = $doc->DisplayRange->Molecules($i);
                if ($molecule->ChemicalFormula eq "C12 H26"){
			my $atoms = $molecule->Atoms;
			foreach my $atom(@$atoms){
				if ($atom->ElementSymbol eq "C"){
					push @C12H26, $atom;
				}
			}			
                }
}

my $length = @C12H26;
my $NumAtoms = $length / $NumberOfMolecules;

if (($length % $NumberOfMolecules) == 0){
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		for (my $j =0; $j < $NumAtoms - 3; ++$j){
			my $k = $i * $NumAtoms + $j;
			push @C12H26_Torsion, $doc->CreateTorsion([@C12H26[$k], @C12H26[$k+1], @C12H26[$k+2], @C12H26[$k+3]]);
		}
	}

}

$doc->CreateSet("C12", \@C12H26);
$doc->CreateSet("C12_Torsion", \@C12H26_Torsion);


my $trajectory = $doc->Trajectory;
my $File1 = Documents->New("torsion.txt");
my $label;
for (my $frame = 0; $frame < $trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	for (my $i = 0; $i < $NumberOfMolecules; ++$i){
		for (my $j = 0; $j < $NumAtoms - 3; ++$j){
			my $k = $i * $NumAtoms + $j;
			my $Torsion = $doc->CreateTorsion([@C12H26[$k], @C12H26[$k+1], @C12H26[$k+2], @C12H26[$k+3]]);
			my $Angle = $Torsion->Angle;
			if (($Angle > 0) && ($Angle < 120)){
				$label = 0;
			}
			elsif(($Angle < 0) && ($Angle > -120)){
				$label = 1;
			}
			elsif ((($Angle > 120) && ($Angle < 180.1)) || (($Angle > -180.1) && ($Angle < -120))){
				$label = 2;
			}
			else{
				die "Angle is not right!";
			}
			$File1->Append(sprintf "%d", $label);
		}
		$File1->Append(sprintf "\n");
	
	}	
}
$File1->Close;



my $resultsA = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
        MSDMaxFrameLength => 100,
        MSDComputeAnisotropicComponents => "Yes",
        MSDSetA => "C12"));
my $outMSDChartA = $resultsA->MSDChart;
my $outMSDChartAsStudyTableA = $resultsA->MSDChartAsStudyTable;

my $resultB = Modules->Forcite->Analysis->RadiusOfGyration($doc, Settings(
	RadiusOfGyrationSetA => "C12"));
my $outRadiusOfGyrationChart = $resultB->RadiusOfGyrationChart;
my $outRadiusOfGyrationChartAsStudyTable = $resultB->RadiusOfGyrationChartAsStudyTable;

my $resultC = Modules->Forcite->Analysis->TorsionDistribution($doc, Settings(
	TorsionDistributionSetA => "C12_Torsion"));
my $outTorsionDistributionChart = $resultC->TorsionDistributionChart;
my $outTorsionDistributionChartAsStudyTable = $resultC->TorsionDistributionChartAsStudyTable;



