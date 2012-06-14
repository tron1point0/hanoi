n = process.argv[2] or 7

solve = (n,a,b,c) ->
    return [] unless n
    (solve n-1,a,c,b).concat("#{a} -> #{c}").concat (solve n-1,b,a,c)

console.log n
console.log m for m in (solve n,'A','B','C')
