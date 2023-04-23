#!perl
# Coder: Mr. Rao
# Time: 2020/09/28
# Purpose: Obtain coordination of  molecule C2 and C9 every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_Dio_48_Fur_12.xtd");

# -------------- Orientation distribution & dipolemoment & probability density
my $trajectory = $doc->Trajectory;

my $File1=Documents->New("AtomsXYZ.txt");
my $File2=Documents->New("Center.txt");

my $File_solvent = Documents->New("Dioxane_48.txt");
my $File_solute = Documents->New("Furfuryl.txt");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File1->Append(sprintf "%s %i \n", "Frame", $frame);
	$File2->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		my $center = $molecule->center;
		if ($molecule->NumAtoms eq 13){
			my $atom1 = $molecule->Atoms("C2");
			my $atom2 = $molecule->Atoms("C9");
			my $p = $molecule->DipoleMoment;
			$File1->Append(sprintf "%s %f %f %f\n", "C2", $atom1->X, $atom1->Y, $atom1->Z);
			$File1->Append(sprintf "%s %f %f %f\n", "C9", $atom2->X, $atom2->Y, $atom2->Z);
			$File1->Append(sprintf "%s %f %f %f\n", "Moment", $p->X, $p->Y, $p->Z);
			$File_solute->Append(sprintf "%s %f %f %f\n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
		}

		if ($molecule->NumAtoms eq 14){
			$File_solvent->Append(sprintf "%s %f %f %f\n", $molecule->ChemicalFormula, $center->X,$center->Y, $center->Z);
		}
                $File2->Append(sprintf "%s %f %f %f \n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);

	}
}
$File1->Close;
$File2->Close;
$File_solvent->Close;
$File_solute->Close;

# ---------------- msd & input as txt formate

my @dioxane;
my @furfuryl;

my @Oatom;

for (my $i =0; $i < $NumberOfMolecules; ++$i){
                my $molecule = $doc->DisplayRange->Molecules($i);
                if ($molecule->ChemicalFormula eq "C4 H8 O2"){
                        foreach my $atom(@{$molecule->Atoms}){
                                push(@dioxane, $atom);
                        }
                }

		if ($molecule->ChemicalFormula eq "C5 H6 O2"){
			foreach my $atom(@{$molecule->Atoms}){
				push(@furfuryl, $atom);
				if (abs($atom->Charge + 0.57)< 0.01){
					push(@Oatom, $atom);
				}
			}
		}
}

$doc->CreateSet("Dioxane", \@dioxane);
$doc->CreateSet("Furfuryl", \@furfuryl);
$doc->CreateSet("O", \@Oatom);

my $resultsA = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
        MSDMaxFrameLength => 100,
        MSDComputeAnisotropicComponents => "Yes",
        MSDSetA => "Furfuryl"));
my $outMSDChartA = $resultsA->MSDChart;
my $outMSDChartAsStudyTableA = $resultsA->MSDChartAsStudyTable;

my $resultsB = Modules->Forcite->Analysis->MeanSquareDisplacement($doc, Settings(
        MSDMaxFrameLength => 100,
        MSDComputeAnisotropicComponents => "Yes",
        MSDSetA => "Dioxane"));
my $outMSDChartB = $resultsB->MSDChart;
my $outMSDChartAsStudyTableB = $resultsB->MSDChartAsStudyTable;

my $RowCountmsd = $outMSDChartAsStudyTableA->Sheets(0)->RowCount;


my $FileA = Documents->New("MSD_Furfuryl.txt");
my $FileB = Documents->New("MSD_Dioxane.txt");

my $sheetA0 = $outMSDChartAsStudyTableA->Sheets(0);
my $sheetA1 = $outMSDChartAsStudyTableA->Sheets(1);
my $sheetA2 = $outMSDChartAsStudyTableA->Sheets(2);
my $sheetA3 = $outMSDChartAsStudyTableA->Sheets(3);
my $sheetB0 = $outMSDChartAsStudyTableB->Sheets(0);
my $sheetB1 = $outMSDChartAsStudyTableB->Sheets(1);
my $sheetB2 = $outMSDChartAsStudyTableB->Sheets(2);
my $sheetB3 = $outMSDChartAsStudyTableB->Sheets(3);


$FileA->Append(sprintf "Time(ps),Total,XX,YY,ZZ\n");
$FileB->Append(sprintf "Time(ps),Total,XX,YY,ZZ\n");
for (my $i=0; $i<$RowCountmsd; ++$i){
	$FileA->Append(sprintf "%i,%f,%f,%f,%f\n",$sheetA0->Cell($i,0),$sheetA0->Cell($i,1),$sheetA1->Cell($i,1),$sheetA2->Cell($i,1),$sheetA3->Cell($i,1));
        $FileB->Append(sprintf "%i,%f,%f,%f,%f\n",$sheetB0->Cell($i,0),$sheetB0->Cell($i,1),$sheetB1->Cell($i,1),$sheetB2->Cell($i,1),$sheetB3->Cell($i,1));
}
$FileA->Close;
$FileB->Close;

#-------- Concentration

my $resultC = Modules->Forcite->Analysis->ConcentrationProfile($doc, Settings(
        ConcentrationProfileSetA => "Dioxane",
        ConcentrationProfileSpecifiedDirection => "No",
        ConcentrationProfileAnalyzeInBlocks => "No"));
my $outConcentrationProfileChartC = $resultC->ConcentrationProfileChart;
my $outConcentrationProfileChartAsStudyTableC = $resultC->ConcentrationProfileChartAsStudyTable;

my $resultD = Modules->Forcite->Analysis->ConcentrationProfile($doc, Settings(
        ConcentrationProfileSetA => "Furfuryl",
        ConcentrationProfileSpecifiedDirection => "No",
        ConcentrationProfileAnalyzeInBlocks => "No"));
my $outConcentrationProfileChartD = $resultD->ConcentrationProfileChart;
my $outConcentrationProfileChartAsStudyTableD = $resultD->ConcentrationProfileChartAsStudyTable;

#---------------- Potential Energy component

my $resultE = Modules->Forcite->Analysis->PotentialEnergyComponents($doc, Settings(
        PotentialEnergyComponentsShowAll => "Yes"));
my $outPotentialEnergyComponentsChart = $resultE->PotentialEnergyComponentsChart;
my $outPotentialEnergyComponentsChartAsStudyTable = $resultE->PotentialEnergyComponentsChartAsStudyTable;

my @Energy = ("Electrostatic energy: Profile", "Electrostatic energy: Running average", "Total potential energy: Profile","Total potential energy: Running average","van der Waals energy: Profile","van der Waals energy: Running average");
my @filename = ("EE_1.txt", "EE_2.txt", "TPE_1.txt", "TPE_2.txt", "VDW_1.txt", "VDW_2.txt");

my $SheetCountPEC = $outPotentialEnergyComponentsChartAsStudyTable->Sheets->Count;
my $RowCountPEC = $outPotentialEnergyComponentsChartAsStudyTable->Sheets(0)->RowCount;


for (my $i=0; $i<$SheetCountPEC; ++$i){

        my $sheet = $outPotentialEnergyComponentsChartAsStudyTable->Sheets($i);
        my $title = $sheet->Title;

        for (my $j=0; $j< @Energy; ++$j){

                if ($title eq $Energy[$j]){

                        my $file = Documents->New($filename[$j]);
                        $file->Append(sprintf "%s,%s\n", "Time(ps)", $Energy[$j]);

                        for (my $k=0; $k< $RowCountPEC; ++$k){

                                $file->Append(sprintf "%i,%f\n", $sheet->Cell($k,0), $sheet->Cell($k, 1));
                        }
                        $file->Close;
                }
        }
}

#-----------rdf

my $resultF = Modules->Forcite->Analysis->RadialDistributionFunction($doc, Settings(
        RDFComputeMolecularComponents => "No",
        RDFComputeStructureFactor => "Yes",
        RDFSetA => "O",
        RDFSetB => "O"));
my $outRDFChart = $resultF->RDFChart;
my $outRDFChartAsStudyTable = $resultF->RDFChartAsStudyTable;

#------------ RG

my $resultG = Modules->Forcite->Analysis->RadiusOfGyration($doc, Settings(
        RadiusOfGyrationSetA => "Dioxane"));
my $outRadiusOfGyrationChartA = $resultG->RadiusOfGyrationChart;
my $outRadiusOfGyrationChartAsStudyTableA = $resultG->RadiusOfGyrationChartAsStudyTable;

my $resultH = Modules->Forcite->Analysis->RadiusOfGyration($doc, Settings(
        RadiusOfGyrationSetA => "Furfuryl"));
my $outRadiusOfGyrationChartB = $resultH->RadiusOfGyrationChart;
my $outRadiusOfGyrationChartAsStudyTableB = $resultH->RadiusOfGyrationChartAsStudyTable;
