using Combinatorics

function solve(io, expansion = 2)
    
    input = readlines(io)
    galaxylist = []
    galaxycols = Set{Int}([])
    distancemat = ones(Int,length(input),length(input[1]))

    for (i, line) in enumerate(input)
        empty = true
        for (j, char) in enumerate(line)
            if char == '#'
                empty = false
                push!(galaxylist, (i,j))
                push!(galaxycols, j)
            end
        end 

        if empty
            distancemat[i,:] .= expansion
        end
    end

    for i in axes(distancemat,2)
        if !(i in galaxycols)
            distancemat[:,i] .= expansion
        end
    end

    pairdist = 0

    distdict = Dict{Tuple{Int,Int},Tuple{Int,Int}}()

    for coords in galaxylist
        rowsum = sum(distancemat[1:coords[1],coords[2]])
        colsum = sum(distancemat[coords[1],1:coords[2]])
        distdict[coords] = (rowsum, colsum)
    end

    for (a, b) in combinations(galaxylist, 2)

        pairdist += sum(abs.(distdict[a] .- distdict[b]))

    end
    pairdist
end
