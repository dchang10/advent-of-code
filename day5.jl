inputlist = split(input,"\n")
stacks1 = filter.(x->x!=' ', eachrow(reduce(hcat, reverse([map(x->x[2], Iterators.partition(inputlist[i], 4)) for i in 1:8]))))
instructionlist = [[parse(Int, i[j]) for j in findall(r"[0-9]+", i)] for i in inputlist[11:end]] # blocks, from, to
stacks2 = deepcopy(stacks)  
########################
# Part 1
########################

for i in instructionlist
  l = length(stacks1[i[2]])
  append!(stacks1[i[3]], reverse(stacks1[i[2]][end-i[1]+1:end]))
  deleteat!(stacks1[i[2]], l-i[1]+1:l)
end

join([i[end] for i in stacks])

########################
# Part 2
########################

for i in instructionlist
  l = length(stacks2[i[2]])
  append!(stacks2[i[3]], stacks2[i[2]][end-i[1]+1:end])
  deleteat!(stacks2[i[2]], l-i[1]+1:l)
end

join([i[end] for i in stacks2])
