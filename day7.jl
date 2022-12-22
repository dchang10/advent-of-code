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
zero(::Dir) = nothing

mutable struct File <: ANode
  name::String
  filesize::Int128
  parent::ADir
end

inputlist = [line for line in eachline(open((@__DIR__)*"/inputtest.txt"))][begin+1:end]
line = split(popfirst!(inputlist), ' ')

currdir = RootDir(Vector{ANode}([]))
  
# Create directory and file tree
for _ in 0:length(inputlist)
    if line[1] == "\$" && line[2] == "cd"
        currdir = (line[3] == "..") ? currdir.parent : filter(x->x.name==line[3], currdir.children)[1]#cd into child
    elseif line[1] != "\$"
        line[1] == "dir" ? append!(currdir.children, [Dir(line[2], Vector{ANode}([]), currdir)]) : append!(currdir.children, [File(line[2], parse(Int, line[1]), currdir)])
    end
    line = length(inputlist) > 0 ? split(popfirst!(inputlist), ' ') : []
end

while currdir.name != "//"
  currdir = currdir.parent
end

########################
# Part 1
########################

getsizeofdir(currdir) = sum(map(x->typeof(x) == File ?  x.filesize : getsizeofdir(x), currdir.children))

function addtosum(topdir)
  dirlist = filter(x-> typeof(x) == Dir, topdir.children)
  temp = getsizeofdir(topdir)
  return (temp <= 100000 ? temp : 0) + (length(dirlist) > 0 ? sum(addtosum.(dirlist)) : 0)
end

addtosum(currdir)

########################
# Part 2
########################

function getsizelist(topdir, totlist)
  getsizelist.(filter(x-> typeof(x) == Dir, topdir.children), Ref(totlist))
  temp = getsizeofdir(topdir)
  append!(totlist, temp)
end

totlist = []
getsizelist(currdir, totlist)
spacetofree = 30000000 + totlist[end] - 70000000
totlist[findfirst(>=(spacetofree), sort!(totlist))]
