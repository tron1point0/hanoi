#!/usr/bin/env ruby

n = ARGV[0].to_i
n = 7 if n == 0

def solve (n,a,b,c)
    return [] if n == 0
    solution = solve(n-1,a,c,b).push("#{a} -> #{c}")
    solve(n-1,b,a,c).each do |it|
        solution.push(it)
    end
    return solution
end

printf("%d\n",n)
solve(n,'A','B','C').each do |it|
    printf("%s\n",it)
end
