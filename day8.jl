inputlist = map(x->parse.(Int, Vector{Char}(x)), split(input, "\n"))
    
function checktree(currtree, pos, currmax, treepos) 
    if currtree > currmax 
        push!(treepos, [pos])
        return currtree
    end
    return currmax
end

########################
# Part 1
########################
treepos = Set([])
for (numi, i) in enumerate(inputlist)
    currmax = -1
    for (numj, currtree) in enumerate(i)
        currmax = checktree(currtree, [numj, numi], currmax, treepos)
    end
    currmax = -1
    for (numj, currtree) in collect(enumerate(i))[end:-1:begin]
        currmax = checktree(currtree, [numj, numi], currmax, treepos)
    end
end

for (numi, i) in enumerate(collect(eachrow(reduce(hcat, inputlist))))
    currmax = -1
    for (numj, currtree) in enumerate(i)
        currmax = checktree(currtree, [numi, numj], currmax, treepos)
    end
    currmax = -1
    for (numj, currtree) in collect(enumerate(i))[end:-1:begin]
        if currtree > currmax
            currmax = checktree(currtree, [numi, numj], currmax, treepos)
        end
    end

end
length(treepos)

########################
# Part 2
########################

maxscore = 0
for (numi, i) in enumerate(inputlist)
    append!(treescores, [[]])
    for (numj, currtree) in enumerate(i)
        #move up
        canmove = true
        up = numi
        while canmove && (up > 1 )
            up -= 1
            if inputlist[up][numj] >= currtree
                canmove = false
            end
        end
        score = numi - up

        #move left
        canmove = true
        left = numj
        while canmove && (left > 1 )
            left -= 1
            if i[left] >= currtree
                canmove = false
            end
        end
        score *= numj - left

        #move down
        canmove = true
        down = numi
        len = length(inputlist)
        while canmove && (down < len )
            down += 1
            if inputlist[down][numj] >= currtree
                canmove = false
            end
        end
        score *= down - numi 


        #move right
        canmove = true
        right = numj
        len = length(i)
        while canmove && (right < len )
            right += 1
            if i[right] >= currtree
                canmove = false
            end
        end

        score *= right - numj 
        maxscore = score > maxscore ? score : maxscore
    end
end

maxscore
