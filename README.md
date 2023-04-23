# Materials-Studio-script
All scripts can be run in the Materials Studio, involving Monte Carlo, Molecular Dynamics.
All scripts can be executed on server, in order to free your PC

If you have any questions about the perl script in the Materials Studio, you can contact me via email: **weirao100@qq.com**

## All.pl
Including the coordinates and dipolemoment of atoms, MSD, concentration of the molecules in the set of trajectory, Potential Energy component, Radial Distribution Function and Radius Of Gyration.

## AtomsXYZ.pl
Print trajectory of every atom you need to the AtomsXYZ.txt from \*.trj and \*.xtd file

## CenterInBox.pl
Export the coordiantes of molecular center every frames from the trajectory, which must be within one periodic box.

The initial coordiantes of every atom may be out of the periodic box, and then the final coordinate are put in the box after running this script.

## Config.pl
Alkane diffuses in the channel of zeolite, recorded in the **MOR-C12.xsd**, now we need execute the *dlpoly*, a molecular dynamics package, rather than the *Materilas studio*. The input file of *dlpoly*, named as CONFIG, can be transferred via the **MOR-C12.xsd** by this perl script. It is worthing noting that the force field of this task is taken from the [ref 1](https://pubs.acs.org/doi/10.1021/ct900315r) and [ref 2](https://pubs.acs.org/doi/10.1021/ja0476056).

## CreateMoleAndGeomOpt.pl
Create a methanol molecule and geometry optimization is done by compass force field

## Deformation.pl
Calculate the Length, Width, Height and angle, which can demonstrate the deformation of alkane when it diffuses in the channel of zeolite.

## Dipole.pl

calculate the DipoleAutocorrelationFunction of molecules in the set and the molecular orientation

## DipoleAndBond.pl
Print dipole moment and trajectory of every atoms in bonds to DipoleMoment.txt

## Energy.pl
Calculate the energy of MOR\_CH4.xsd using compass force field

## EnergyExtract.pl
Extract the all kinds of energy data from *std* file.

## fractionalX.pl
obtain the atmoic fractional coordiantes from *.cif file
## Forcite.pl
Do molecular dynamics, such as NPT, NVT, N$\mu$T Simulation

## GeomOpt.pl
Do geometry optimization in \*.xsd file using compass force field

## InZeo.pl
molecules may be in zeolite or the vacuumn,, thus this script can be used to determine the number of molecules in zeolite every frames from trajectory file

## MS.sh
Commit computational job to qsub. In MS.sh, you can rewrite cores of CPU, name of jobs, etc. There is one thing to be noted that you must change location of  *RunMatScript.sh*

## MSD.pl
Create set including molecules, and calculate Mean Square Displacement, which often is applied to calculate the diffusion coefficient

## PEC.pl
Calculate the potential energy component.

## rdf.pl
Create set including molecules and Calculate radial distribution function and structure factor between set A and B

## RTCF.pl
Create set including molecules and Calculate RotationalTimeCorrelationFunction

## RadiusOfGyration.pl
Create set including molecules and Calculate RadiusOfGyration

## STCF.pl
Calculate SpaceTimeCorrelationFunction, where the set should be created first in the xtd file.

## SavePDB.pl
Import \*.xtd file and save as \*.pdb file

## SaveUnFix.pl
Import \*.xtd file and unfix the coordination of every atoms, and then save as \*.xsd file, which is the appropriate step to consider the flexibility of zeolite framework in doing molecular dynamics by compass force field

## SorptionAdsorptionIsotherm.pl
Calculate Isotherm

## SorptionFixedLoading.pl and SorptionFixedPressure.pl
Calculate structure, adsorption energy and dendity using GCMC simulation

## Stress.pl
Create set including molecules and Calculate StressAutocorrelationFunction

## Torsion.pl
Create set including torsion angles and Calculate the torsion or dihedral of C-C chain in the C12H26 from the trajectory file 

## Transfer.pl
Transfer a cif file to be xyz and pdb or a new cif file and then output the lattice information.

## VACF.pl
Create set including molecules and Calculate VelocityAutocorrelationFunction

## gulp_bat.sh
run one batch of gulp task

## Xtd2UnFix.sh
Import \*xtd file, to carry out *SaveUnFix.pl* and then copy the output, \*.xsd to destination directory

## xsd\_qsub.sh
Carry out the command, *qsub MS.sh*

## castep\_geomopt\_CsPbBr3.pl
Carry out geometry optimization task of CsPbBr3.

Something to be noticed:
* OptimizeCell must be "Yes"
* It can not calculate the Mulliken analysis, so Mulliken should be deleted.

## castep\_geomopt\_graphene.pl
Carry out the geometry optimization task of Graphene

## mesopore_2x2.pl
create mesopore with 2nm x 2nm in zeolite

## xxx.bat
show the diffusion trajectory via cartoon using the VMD 

