#!/usr/bin/env perl

use feature 'say';
use warnings;

my ($n) = @ARGV;
$n //= 7;

sub solve {
    my ($n,$a,$b,$c) = @_;
    return unless $n;
    return solve($n-1, $a, $c, $b),"$a -> $c",solve($n-1, $b, $a, $c);
}

say join "\n", $n, solve $n, 'A'..'C';
