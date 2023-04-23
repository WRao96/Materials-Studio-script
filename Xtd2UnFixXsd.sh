#! /usr/bin/bash

declare -a furanmethanol_12

furanmethanol_12=(Tetrahydrofuran_48_Tetrahydro-2-furanmethanol_12 n-Butanol_48_Tetrahydro-2-furanmethanol_12 Methanol_48-Tetrahydro-2-furanmethanol_12 Tetrahydro-2-furanmethanol_12 2-Butanol_48_Tetrahydro-2-furanmethanol_12 Dioxane_48-Tetrahydro-2-furanmethanol_12 H2O_48-Tetrahydro-2-furanmethanol_12)


for ((i=0; i<7; ++i))
do
	cd ${furanmethanol_12[i]}/SorptionFixedLoading_Files/Documents/
	mkdir SaveUnFix
	cp MFI_T12_H\ Low\ energy.* SaveUnFix
	cd SaveUnFix
	cp ~/Materials-Studio-script-master/SaveUnFix.pl .
	sed -i '7s/MFI/MFI_T12_H/g' SaveUnFix.pl
	temp=MFI_T12_H_${furanmethanol_12[i]}
	echo ${temp}
	sed -i "11s/MFI_H2O_320/${temp}/" SaveUnFix.pl     # sed -i /// 三个/，一个不能少，当替换字符串包含变量时，应该用 "" 
	/public/software/accelrys/MaterialsStudio7.0/etc/Scripting/bin/RunMatScript.sh -np 1 SaveUnFix
	cd SaveUnFix_Files/Documents/
	cp ${temp}.xsd ~/Polarity_1120/MD/MFI_T12_H/
	cd ~/Polarity_1120/Sorption/MFI_T12_H/
done
