use Module::Build;
use File::Spec::Functions qw( catfile );

use lib '.';
use Generate qw( %GENERATE );

my $class = Module::Build->subclass
  (
   class => 'CMM::AutoSplit',
   code  => q{
              sub ACTION_code {
                my ($self) = @_;

                # All installable stuff gets created in blib/ .
                # Create blib/arch to keep blib.pm happy
                my $blib = $self->blib;
                $self->add_to_cleanup($blib);
                File::Path::mkpath( File::Spec->catdir($blib, 'arch') );

                foreach my $element (@{$self->build_elements}) {
                  my $method = "process_${element}_files";
                  $self->$method();
                }

                if ( my $autosplit = $self->autosplit ) {
                  if ( ref $autosplit eq 'ARRAY' ) {
                    $self->autosplit_file($_, $blib)
                      for @$autosplit;
                  } else {
                    $self->autosplit_file($autosplit, $blib);
                  }
                }
              }
            },
           );

my $build = $class->new(
                         module_name   => 'Class::MethodMaker',
                         license       => 'perl',
                         dist_version_from => catfile(qw( lib Class MethodMaker Engine.pm )),
                         sign          => 1,
                         dist_author   => 'Martyn J. Pearce <fluffy@cpan.org>',
                         dist_abstract => 'create generic class accessor methods',
                         PL_files      => +{ 'generate.PL', [ values %GENERATE ] },
                         autosplit     => [ values %GENERATE,
                                            catfile(qw(lib Class MethodMaker Engine.pm )) ],
                         create_makefile_pl => 'passthrough',
                       );

$build->create_build_script;
