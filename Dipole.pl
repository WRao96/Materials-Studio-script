#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);
use Math::Trig qw(acos);

my $doc = Documents->Import("MFI_Furfuryl_12.xtd");
my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

my @dioxane;
my @C5H6O2;
for (my $i =0; $i < $NumberOfMolecules; ++$i){
     my $molecule = $doc->DisplayRange->Molecules($i);
        if ($molecule->ChemicalFormula eq "C4 H8 O2"){
            foreach my $atom(@{$molecule->Atoms}){
                push(@dioxane, $atom);
            }
        }
	if ($molecule->ChemicalFormula eq "C5 H6 O2"){
		foreach my $atom(@{$molecule->Atoms}){
			push(@C5H6O2, $atom);
		}
	}
}
$doc->CreateSet("Dioxane", \@dioxane);
$doc->CreateSet("Furfuryl",\@C5H6O2);

#my $resultC = Modules->Forcite->Analysis->DipoleAutocorrelationFunction($doc, Settings(
#        DACFSetA => "Dioxane",
#        DACFMaxFrameLength => 100,
#        DACFComputeAnisotropicComponents => "Yes",
#        DACFNormalize => "Yes"));
#my $outDACFChartC = $resultC->DACFChart;
#my $outDACFChartAsStudyTableC = $resultC->DACFChartAsStudyTable;

my $resultD = Modules->Forcite->Analysis->DipoleAutocorrelationFunction($doc, Settings(
        DACFSetA => "Furfuryl",
        DACFMaxFrameLength => 100,
        DACFComputeAnisotropicComponents => "Yes",
        DACFNormalize => "Yes"));
my $outDACFChartD = $resultD->DACFChart;
my $outDACFChartAsStudyTableD = $resultD->DACFChartAsStudyTable;

my $trajectory = $doc->Trajectory;
my $File = Documents->New("Theta.txt");
$File->Append(sprintf "X,Y,Z\n");
for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	my $pz_Furfuryl = 0;
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		if ($molecule->ChemicalFormula eq "C5 H6 O2"){
			my $p = $molecule->DipoleMoment;
			my $x = acos($p->X / sqrt($p->X * $p->X + $p->Y * $p->Y + $p->Z * $p->Z)) * 180 / 3.14159;
			my $y = acos($p->Y / sqrt($p->X * $p->X + $p->Y * $p->Y + $p->Z * $p->Z)) * 180 / 3.14159;
			my $z = acos($p->Z / sqrt($p->X * $p->X + $p->Y * $p->Y + $p->Z * $p->Z)) * 180 / 3.14159;
			$File->Append(sprintf "%.1f,%.1f,%.1f\n",$x,$y,$z);
		}
	}
}
$File->Close;
