require 5.00307;
use strict;

use ExtUtils::MakeMaker;

WriteMakefile (
  NAME         => 'Class-MethodMaker',
  VERSION      => '1.12',
  AUTHOR       => 'Martyn J. Pearce ',
  ABSTRACT     => 'a module for creating generic methods',
  PREREQ_PM    => +{ },
  EXE_FILES    => [ ],
  # Need this to stop Makefile treating Build.PL as a producer of Build as a
  # target for 'all'.
  PL_FILES     => +{},
  clean        => +{ FILES => join(' ', qw( Build _build )) },
  realclean    => +{ FILES => join(' ', qw( Build.PL META.yml
                                            Makefile.PL
                                            SIGNATURE
                                            README INSTALL
                                            configure make-pm )) },
);
