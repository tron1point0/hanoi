#!/usr/bin/env node

var n = 7;
if (process.argv.length > 2) n = process.argv[2];

var solve = function (n,a,b,c) {
    if (!n) return [];
    return (solve(n-1,a,c,b)).concat(a + ' -> ' + c).concat(solve(n-1,b,a,c));
};

console.log(n);
var s = solve(n,'A','B','C');
for (var i in s) {
    console.log(s[i]);
}
