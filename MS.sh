#!/bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=12
#PBS -N MFI_1
#PBS -l walltime=1500:00:00
#PBS -j oe
#PBS -V


export  NP=`cat $PBS_NODEFILE|wc -l`

cd $PBS_O_WORKDIR

/accelrys/MaterialsStudio7.0/etc/Scripting/bin/RunMatScript.sh -np $NP Forcite