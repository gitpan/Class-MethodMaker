#!/usr/local/bin/perl

package XXX;

use Class::MethodMaker
    new_hash_with_init => 'new',
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

my $obj = XXX->new(foo => 7, bar => 13);
# 1--4
TEST { $obj->isa('XXX'); };
TEST { $obj->foo == 7; };
TEST { $obj->bar == 666; };
TEST { $obj->baz == 42; };
