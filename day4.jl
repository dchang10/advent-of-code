inputlist = eval(Meta.parse("[[" .* replace.(input, ","=>"],[", "-"=>",", "\n"=>"]],[[") .* "]]"))

########################
# Part 1
########################
iswithin = (x, y)->Int((x[1] >= y[1] && x[2] <= y[2]) || (y[1] >= x[1] && y[2] <= x[2]))
sum(map(x->iswithin(x...), inputlist))
  
########################
# Part 2
########################
isoverlap = (x, y) -> (x[2] >= y[1] && y[1] >= x[1]) || (y[2] >= x[1] && x[1] >= y[1])
sum(map(x->isoverlap(x...), inputlist))
