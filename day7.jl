abstract type ANode end
abstract type ADir <: ANode end

mutable struct RootDir <: ADir
  name::String
  children::Vector{ANode}
  RootDir(x,y) = x != "//" ? error("Root Directory must be called \\") : new(x,y) 
end

RootDir(x::Vector{ANode}) = RootDir("//" , x)

mutable struct Dir <: ADir
  name::String
  children::Vector{ANode}
  parent::ADir
end

mutable struct File <: ANode
  name::String
  filesize::Int128
  parent::ADir
end

Base.show(io::IO, node::ANode) = print(io, "$(typeof(node) <: ADir ? [i.name for i in node.children] : typeof(node))")

file = open((@__DIR__)*"/inputtest.txt")
inputlist = [line for line in eachline(file)]
close(file)

currdir = RootDir(Vector{ANode}([]))

line = split(popfirst!(inputlist), ' ')
line = split(popfirst!(inputlist), ' ')

currdir = RootDir(Vector{ANode}([]))
while length(inputlist) > -1
    print(line)
    print(" ")
    println(currdir)
    if line[1] == "\$"
        if line[2] == "cd"
            if line[3] == ".."
                currdir = currdir.parent
            else #cd into child
                for i in currdir.children
                    if i.name == line[3]
                        currdir = i
                        break
                    end
                end
            end
        end
    else
        if line[1] == "dir"
            append!(currdir.children, [Dir(line[2], Vector{ANode}([]), currdir)])
        else
            append!(currdir.children, [File(line[2], parse(Int, line[1]), currdir)])
        end
    end
    line = split(popfirst!(inputlist), ' ')
end

while currdir.name != "//"
  currdir = currdir.parent
end

########################
# Part 1
########################

function getsizeofchildren(currdir) 
  tot = 0
  dirlist = []
  for node in currdir.children
    if typeof(node) == File
      tot += node.filesize
    else
      append!(dirlist, [node])
    end
  end
  for i in dirlist
    tot += getsizeofchildren(i)
  end
  return tot
end

function addtosum(topdir)
  dirlist = filter(x-> typeof(x) == Dir, topdir.children)
  temp = getsizeofchildren(topdir)
  tot = 0
  tot += temp <= 100000 ? temp : 0
  for i in dirlist
    tot += addtosum(i)
  end
  
  return tot
end

addtosum(currdir)

########################
# Part 2
########################

totlist = []
function addtosum(topdir)
  global totlist
  dirlist = filter(x-> typeof(x) == Dir, topdir.children)
  temp = getsizeofchildren(topdir)
  tot = 0
  tot += temp 
  for i in dirlist
    tot += addtosum(i)
  end
  
  append!(totlist, temp)
  return tot
end

spacetofree = 30000000 + totlist[end] - 70000000

addtosum(currdir)
sort!(totlist)
totlist[findfirst(>=(spacetofree), totlist)]

