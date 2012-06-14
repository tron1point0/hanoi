#!/usr/bin/env perl

use strict;
use warnings;
use Carp;

croak "Improper header." unless <> =~ /^BEGIN (\d+)$/;
my $n = $1;

sub line {
    my ($peg,$nums) = $_[0] =~ /^(\w+):\s+(?:([0-9,]+))?$/;
    $nums //= '';
    return $peg,[split ',',$nums];
}

my %initial;
my %last;

while (<>) {
    next unless /^(\w+)\s*:/;
    my %state = map {line $_} $_,scalar <>,scalar <>;
    %initial = %state unless %initial;
    %last = %state;
    for (keys %state) {
        next if @{$state{$_}} == 0;
        my $k = $_;
        my $last = $state{$_}[0];
        for (@{$state{$_}}) {
            croak "Invalid peg number ($k: $_)." if $_ > $n;
            croak "Big peg on small peg ($k: $_ > $last)."
                if $_ > $last;
            $last = $_;
        }
    }
}

my ($start_peg,$end_peg,$error);
($start_peg,$error) = grep {@{$initial{$_}} > 0} keys %initial;
croak "Incorrect initial state ($error: @{[join ',',@{$initial{$error}}]})." if $error;
($end_peg,$error) = grep {@{$last{$_}} > 0} keys %last;
croak "Pegs left over ($error: @{[join ',',@{$last{$error}}]})." if $error;
croak "No change in board state." if $start_peg eq $end_peg;
