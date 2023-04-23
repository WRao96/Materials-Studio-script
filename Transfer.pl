#!perl
#
use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

open(RD, "a.txt");
my @lists_init = <RD>;
my @lists_update;
my $len_init = @lists_init;
for (my $i = 0; $i < $len_init; ++$i){
	my $temp1 = @lists_init[$i];
	my $temp2 = rindex($temp1, "cif");
	if ($temp2 > -1){
		print $temp1;
		push(@lists_update, $temp1);
	}
}
my $len_update = @lists_update;

mkdir("./XYZ_Files/");

my $File = Documents->New("Zeolite.txt");
$File->Append(sprintf "index,Zeo,a,b,c,alpha,beta,gamma,SuperCell,O,Si,Total\n");

for (my $i = 0; $i < $len_update; ++$i){
	my $filename1 = @lists_update[$i];
	my $filename = substr($filename1,-8,7);
	my $x = 1;
	my $y = 1;
	my $z = 1;
	my $doc = Documents->Import($filename);
	$doc->CalculateBonds;
	my $lengthA = $doc->Lattice3D->LengthA;
	my $lengthB = $doc->Lattice3D->LengthB;
	my $lengthC = $doc->Lattice3D->LengthC;
	my $Alpha = $doc->Lattice3D->AngleAlpha;
	my $Beta = $doc->Lattice3D->AngleBeta;
	my $Gamma = $doc->Lattice3D->AngleGamma;

	if ($lengthA > 10){
		$x = 1;
	}
	elsif ($lengthA >6){
		$x = 2;
	}
	else{
		$x = 3;
	}

	if ($lengthB > 10){
		$y = 1;
	}
	elsif ($lengthB > 6){
		$y = 2;
	}
	else{
		$y = 3;
	}

	if ($lengthC > 10){
		$z = 1;
	}
	elsif ($lengthC > 6){
		$z = 2;
	}
	else{
		$z = 3;
	}

	my $file = substr($filename,-7,3);
	my $name1 = join(".",$file,"cif");
	my $name2 = join(".",$file,"pdb");
	my $name3 = join(".",$file,"xyz");
	my $name4 = join("",">./XYZ_Files/",$name3);
	my $xyz = join("",$x,$y,$z);
	my $file_update = join("-",$file,$xyz);
	$doc->BuildSuperCell($x, $y, $z);
	$doc->MakeP1;

	my $Atoms = $doc->UnitCell->Atoms;
	my $count1=0;
	my $count2=0;
	my $count3=$Atoms->Count;
	open(DATA,$name4) || die "No such file!";
	print DATA  $count3;
	print DATA "\nGenerate by the transfer.pl\n";
	foreach my $atom(@$Atoms){
		if ($atom->ElementSymbol eq "O"){
			$count1 += 1;
		}
		if ($atom->ElementSymbol eq "Si"){
			$count2 += 1;
		}
		print DATA $atom->ElementSymbol, "    ", $atom->X, "    ", $atom->Y, "    ", $atom->Z, "\n";

	}
	close DATA;

	$doc->Export($name1);
	$doc->Export($name2);
	$File->Append(sprintf "%d,%s,%f,%f,%f,%f,%f,%f,,,,,\n",$i,$file,$lengthA,$lengthB,$lengthC,$Alpha,$Beta,$Gamma);
	$File->Append(sprintf ",%s,%f,%f,%f,%f,%f,%f,%s,%d,%d,%d\n",$file_update,$lengthA * $x, $lengthB * $y, $lengthC * $z, $Alpha, $Beta, $Gamma, $xyz,$count1,$count2,$count1 + $count2);
	
}

close(FD);
