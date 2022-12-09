inputlist = Vector{String}(spit(input,"\n"))
  
alpha = collect("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
priority = Dict(zip(alpha, [i for i in 1:52]))
yourpart(data,pfac) = [data[n:n+pfac-1] for n=1:pfac:length(data)]

sum([priority[intersect(collect.(i)...)[1]] for i in yourpart(inputlist,3)])
