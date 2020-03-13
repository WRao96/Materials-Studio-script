#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("zeolite.xsd");

###############################################################

Modules->Forcite->ChangeSettings([Ensemble3D => "NVT",
                                  AssignForcefieldTypes => "Yes",
                                  AssignChargeGroups => "Yes",
                                  ChargeAssignment => "Forcefield assigned",
                                  "3DPeriodicElectrostaticSummationMethod" => "Ewald",
                                  "3DPeriodicvdWSummationMethod" => "Atom based",
                                  Temperature => 298,
                                  InitialVelocities => "Random",
                                  NumberOfSteps => 21000000,
                                  WriteForces => "No",
                                  EnergyDeviation => 50000,
                                  RandomSeed => 1,
                                  TimeStep => 1,
                                  WriteVelocities => "No",
                                  TrajectoryFrequency => 1000,
                                  Thermostat => "Nose",
                                  TrajectoryRestart => "No",
                                  CurrentForcefield => "COMPASS",
                                  Quality => "Medium"]);
my $results = Modules->Forcite->Dynamics->Run($doc);
