use Module::Build 0.18;

use File::Spec;

my $build = Module::Build->new
  (module_name   => 'Class::MethodMaker',
   license       => 'perl',
   autosplit     => File::Spec->catfile(qw(lib Class MethodMaker.pm))
  );

$build->create_build_script
