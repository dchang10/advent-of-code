inputlist = split.(split(input,"\n"), " ")
########################
# Part 1
########################

step = 1
register = 1
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

totsignal

########################
# Part 2
########################
#https://stackoverflow.com/questions/26953340/partition-equivalent-in-julia
yourpart(x,n) = [[x[i:min(i+n-1,length(x))]] for i in 1:n:length(x)] 
step = 1      
register = 1
signal = ""

for operation in inputlist
  if step == register || (step - 1) == register || (step - 2) == register
    signal = signal*"#"
  else
     signal = signal *"."
  end
  println("$step $register")
  step += 1
  step %= 40
  
  if operation[1] == "addx"
    if step == register || (step - 1) == register || (step - 2) == register
      signal = signal*"#"
    else
     signal = signal *"."
    end
  println("$step $register")
    step += 1
    step %= 40
    register += parse(Int, operation[2])
  end
end
yourpart(signal, 40)
