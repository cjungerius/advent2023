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

    for (a, b) in combinations(galaxylist, 2)
        row1, row2 = a[1], b[1]
        col1, col2 = a[2], b[2]

        if row1 > row2
            row1, row2 = row2, row1
        end

        if col1 > col2
            col1, col2 = col2, col1
        end

        pairdist += sum(distancemat[row1:row2, a[2]]) + sum(distancemat[a[1], col1:col2]) - 2
    end
    pairdist
end
