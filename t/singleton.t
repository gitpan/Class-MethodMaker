#!/usr/local/bin/perl

package XXX;

use Class::MethodMaker
    singleton => 'instance',
    get_set => [ qw/foo bar baz/ ];

sub init {
	my $self = shift;
	$self->bar(666);
	$self->baz(42);
}

package main;
use lib qw ( ./t );
use Test;

# test the classes themselves

# 1--4
my $obj = XXX->instance(foo => 7, bar => 13);
TEST { $obj->isa('XXX'); };
TEST { $obj->foo == 7; };
TEST { $obj->bar == 666; };
TEST { $obj->baz == 42; };

# 5--8
my $obj2 = XXX->instance;
TEST { $obj2->isa('XXX'); };
TEST { $obj2->foo == 7; };
TEST { $obj2->bar == 666; };
TEST { $obj2->baz == 42; };
