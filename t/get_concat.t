#!/usr/local/bin/perl

package X;

use lib qw ( ./t );
use Test;

use Class::MethodMaker get_concat => 'x';
sub new { bless {}, shift; }
my $o = new X;

TEST { 1 };
TEST { ! defined $o->x };
TEST { $o->x('foo') };
TEST { $o->x eq 'foo' };
TEST { $o->x('bar') };
TEST { $o->x eq 'foobar' };
TEST { ! defined $o->clear_x };
TEST { ! defined $o->x };

exit 0;

