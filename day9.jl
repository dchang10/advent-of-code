inputlist = map(x->[x[1], parse(Int,x[2])],split.(split(input, "\n"), " "))
dirhash = Dict{String, Vector{Int}}("R"=>[0,1], "L"=>[0,-1], "U"=>[1,0], "D"=>[-1,0])
########################
# Part 1
########################

tailloc = [0,0]
headloc = [0,0]
locations = Set([[0,0]])

for (direction, numsteps) in inputlist
  for _ in 1:numsteps
    headloc += dirhash[direction]
    check = abs.(tailloc - headloc)
    
    if !(check == [1, 0] || check == [0, 1] || check == [1, 1])
      
      tailloc += [sign(headloc[1] - tailloc[1]), sign(headloc[2] - tailloc[2])]
    end
    push!(locations, tailloc)
  end
end
length(locations)

########################
# Part 2
########################

knotlocs = [[0,0] for i in 1:10]
locations = Set([[0,0]])

for (direction, numsteps) in inputlist
  for _ in 1:numsteps
    knotlocs[1] += dirhash[direction]
    for knotnum in 1:9
      check = abs.(knotlocs[knotnum+1] - knotlocs[knotnum])
      leadknot = knotlocs[knotnum]
      currknot = knotlocs[knotnum+1]
      if !(check == [1, 0] || check == [0, 1] || check == [1, 1])
        knotlocs[knotnum+1] += [sign(leadknot[1] - currknot[1]), sign(leadknot[2] - currknot[2])]
      end
    end
    push!(locations, knotlocs[end])
  end
end
length(locations)
