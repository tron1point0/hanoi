#!/usr/bin/env perl

use strict;
use warnings;
use Carp;

my $mem;
{
    open my $FD, '>', \$mem;
    my $n = <>;
    chomp $n;

    sub tower {
        my ($n) = @_;
        my $t; $t = {
            t => {
                A => [reverse(1..$n)],
                B => [],
                C => []},
            m => sub {
                my ($a,$b) = @_;
                my ($A,$B) = @{$t->{t}}{$a,$b};
                (@$B < 1 or $B->[-1] > $A->[-1]) and return push @$B, pop @$A;
                croak "Tried to move $A->[-1] onto $B->[-1]"},
            show => sub {
                join +($_[0] || "\n"), map {"$_: ".join ',', @{$t->{t}{$_}}} 'A'..'C'}}}

    my $t = tower $n;
    say {$FD} join "\n\n", "BEGIN $n\n" . $t->{show}->(), map {
        my ($a,undef,$b) = split /\s+/;
        $t->{m}->($a,$b);
        "$_" . $t->{show}->();
    } <>;
}

{
    open my $FD, '<', \$mem;
    croak "Improper header." unless <$FD> =~ /^BEGIN (\d+)$/;
    my $n = $1;

    sub line {
        my ($peg,$nums) = $_[0] =~ /^(\w+):\s+(?:([0-9,]+))?$/;
        $nums //= '';
        return $peg,[split ',',$nums];
    }

    my %initial;
    my %last;

    while (<$FD>) {
        next unless /^(\w+)\s*:/;
        my %state = map {line $_} $_,scalar <$FD>,scalar <$FD>;
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
}
