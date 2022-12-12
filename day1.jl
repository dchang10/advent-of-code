callist = eval(Meta.parse("["*replace(replace(input,"\n\n"=>"],["), "\n"=>",")*"]"))

########################
# Part 1
########################
maximum(sum, callist)

########################
# Part 2
########################
sum(sum.(sort(collect(callist), by=sum,rev=true)[begin:begin+2]))
