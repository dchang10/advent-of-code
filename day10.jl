inputlist = split.(split(input,"\n"), " ")
########################
# Part 1
########################

step = 1
register = 1
totsignal = 0

function takestep1(step, register)
  signal = step == 20 ? 20*register : 0
  signal = (step-20)%40 == 0 ? step*register : 0
  return signal
end

for operation in inputlist
  totsignal += takestep1(step, register)
  step += 1
  
  if operation[1] == "addx"
    totsignal += takestep1(step, register)
    step += 1
    register += parse(Int, operation[2])
  end
end

totsignal

########################
# Part 2
########################
#https://stackoverflow.com/questions/26953340/partition-equivalent-in-julia
yourpart(x,n) = [[x[i:min(i+n-1,length(x))]] for i in 1:n:length(x)] 
step = 1      
register = 1
signal = ""
      
function takestep2(signal)
  if step == register || (step - 1) == register || (step - 2) == register
    signal = signal*"#"
  else
     signal = signal *"."
  end
  return signal
end

for operation in inputlist
  signal = takestep2(signal)
  step += 1
  step %= 40
  
  if operation[1] == "addx"
    signal = takestep2(signal)
    step += 1
    step %= 40
    register += parse(Int, operation[2])
  end
end
yourpart(signal, 40)
