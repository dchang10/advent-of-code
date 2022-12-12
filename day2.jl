hash(x) = Dict(['X'=>1,'Y'=>2,'Z'=>3,'A'=>1,'B'=>2,'C'=>3])[x]
inputlist = map(x->hash.(x), eval(Meta.parse("['"*replace(replace(input,"\n"=>"'],['"), " "=>"','")*"']")))

########################
# Part 1
######################## 
scorehash = Dict([1=> 0, -1 => 6, 0 =>3, 2 => 6, -2 =>0]) 
sum(map(x -> scorehash[-(x...)] + x[2], inputlist))
  

########################
# Part 2
######################## 
strategyhash = Dict([1=>0, 2=>3, 3=>6])
+(map(x -> strategyhash[x[2]] + (y -> (y == 0 ? 3 : 0) + y)(+(x..., 1)%3), inputlist)...)


# Broadcasting is only faster on arrays and not general iterables
#+((x -> strategyhash[x[2]] + (y -> (y == 0 ? 3 : 0) + y)(+(x..., 1)%3)).(inputlist)...)


