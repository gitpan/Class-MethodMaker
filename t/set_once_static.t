#!/usr/local/bin/perl

package X;

use lib qw ( ./t );
use Test;

use Class::MethodMaker
  get_set  => [qw[ -set_once   -static foo ]],
  get_set  => [qw[ -static     -set_once bar ]],
  ;

sub new { bless {}, shift; }

my $a = new X;
my $b = new X;

# 1..5
TEST { 1 };
TEST { !defined $a->foo() };
TEST { $b->foo('x') eq 'x' };
TEST { $a->foo() eq 'x' };
TEST { eval{1}; eval{$a->foo('y')}; length($@) };

# 6..10
TEST { 1 };
TEST { !defined $a->bar() };
TEST { $b->bar('x') eq 'x' };
TEST { $a->bar() eq 'x' };
TEST { eval{1}; eval{$a->bar('y')}; length($@) };

exit 0;

