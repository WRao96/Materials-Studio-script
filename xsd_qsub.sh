#! /usr/bin/bash

declare -a furanmethanol_12

furanmethanol_12=(Tetrahydrofuran_48_Tetrahydro-2-furanmethanol_12 n-Butanol_48_Tetrahydro-2-furanmethanol_12 Methanol_48-Tetrahydro-2-furanmethanol_12 Tetrahydro-2-furanmethanol_12 2-Butanol_48_Tetrahydro-2-furanmethanol_12 Dioxane_48-Tetrahydro-2-furanmethanol_12 H2O_48-Tetrahydro-2-furanmethanol_12)


for ((i=0; i<7; ++i))
do
	temp=${furanmethanol_12[i]}
	mkdir ${temp}
	mv MFI_T12_H_${temp}.xsd ${temp}
	cd ${temp}
	cp ~/Materials-Studio-script-master/Forcite.pl .
	sed -i "s/zeolite/MFI_T12_H_${temp}/g" Forcite.pl
	cp ~/MS_7.0.sh .
	sed -i "4s/MFI_FurAlc_H2O_298K/MFI_T12_H_${temp}/g" MS_7.0.sh
	qsub MS_7.0.sh
	cd ../
done
