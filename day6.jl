########################
# Part 1
########################
findfirst(==(1), [(input[begin+i:begin+i+3] |> Set |> length) == 4 for i in 0:(length(input)-4)])+3

########################
# Part 2
########################
findfirst(==(1), [(input[begin+i:begin+i+13] |> Set |> length) == 14 for i in 0:(length(input)-14)])+13
