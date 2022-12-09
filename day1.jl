########################
# Part 1
########################
callist = eval(Meta.parse("["*replace(replace(input,"\n\n"=>"],["), "\n"=>",")*"]"))
maximum(sum, callist)

########################
# Part 2
########################
sum(sum.(sort(collect(callist), by=sum,rev=true)[begin:begin+2]))
