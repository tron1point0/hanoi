#!/usr/bin/env python

from sys import argv

n = 7
if len(argv) > 1:
    n = int(argv[1])

def solve (n,a,b,c):
    if not n:
        return []
    left = solve(n-1,a,c,b)
    left.append(a + " -> " + c)
    left.extend(solve(n-1,b,a,c))
    return left

print n
for m in solve(n,'A','B','C'):
    print m
