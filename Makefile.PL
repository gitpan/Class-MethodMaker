require 5.006;
use strict;

use ExtUtils::MakeMaker;
use File::Basename        qw( basename );
use File::Find            qw( find );
use File::Spec::Functions qw( catfile );

use constant RAW_COMPS    => map(join('.', basename($_, '.m'), 'pm'),
                                 glob(catfile qw(components *.m)));
use constant COMPONENTS   =>
  +{map {catfile('components', join('.',basename($_,'.pm'),'m')) =>
         catfile(qw(Class MethodMaker), $_)} RAW_COMPS};
use constant OPTEXT       => catfile qw( lib Class MethodMaker OptExt.pm );

my %pm;
find (sub {
        $File::Find::prune = 1, return
          if -d $_ and $_ eq 'CVS';
        return unless /\.pm$/;
        (my $target = $File::Find::name) =~
          s/^$File::Find::topdir/\$(INST_LIBDIR)/;
        $pm{$File::Find::name} = $target;
      },
      'lib');

$pm{catfile 'lib', $_} = catfile '$(INST_LIBDIR)', $_
  for values %{COMPONENTS()};

WriteMakefile (
  NAME         => 'Class-MethodMaker',
  VERSION_FROM => catfile(qw( lib Class MethodMaker Engine.pm )),
  AUTHOR       => 'Martyn J. Pearce ',
  ABSTRACT     => 'a module for creating generic methods',
  PREREQ_PM    => +{ },
  EXE_FILES    => [ ],
  # Need this to stop Makefile treating Build.PL as a producer of Build as a
  # target for 'all'.
  PL_FILES     => +{},
  PM           => \%pm,
  clean        => +{ FILES => join(' ', qw( Build _build ),
                                   map(catfile(qw(lib Class MethodMaker), $_),
                                       RAW_COMPS) 
                                  )
                   },
  depend       => +{
                    map({;catfile('lib', COMPONENTS->{$_}) =>
                          join(' ', 'cmmg.pl', %_, OPTEXT) . "\n\t" .
                          join(' ', '$(PERL)', 'cmmg.pl', $_, '>', '$@')
                         }
                        keys %{COMPONENTS()}
                       )
                   },
);
