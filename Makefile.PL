require 5.00307;
use strict;

use ExtUtils::MakeMaker;

WriteMakefile (
  NAME         => 'Class-MethodMaker',
  VERSION      => '1.11',
  AUTHOR       => 'Martyn J. Pearce ',
  ABSTRACT     => 'a module for creating generic methods',
  PREREQ_PM    => +{ },
  EXE_FILES    => [ ],
  # Need this to stop Makefile treating Build.PL as a producer of Build as a
  # target for 'all'.
  PL_FILES     => +{},
  clean        => +{ FILES => qw( Build _build ) },
);
