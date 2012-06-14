#!/usr/bin/env perl

use feature 'say';
use warnings;
use Carp;

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

$t = tower $n;
say join "\n\n", "BEGIN $n\n" . $t->{show}->(), map {
    my ($a,undef,$b) = split /\s+/;
    $t->{m}->($a,$b);
    "$_" . $t->{show}->();
} <>;
