inputlist = split.(split(input,"\n"), " ")
########################
# Part 1
########################

step = 1
newstep = 1
register = 1
newregister = 1
totsignal = 0


for operation in inputlist
  signal = step == 20 ? 20*register : 0
  signal = (step-20)%40 == 0 ? step*register : 0
  totsignal += signal
  step += 1
  
  if operation[1] == "addx"
    signal = step == 20 ? 20*register : 0
    signal = (step-20)%40 == 0 ? step*register : 0
    totsignal += signal
    step += 1
    register += parse(Int, operation[2])
  end
  
end
