function findreflection(pattern, parttwo=false)

    p = fill(false, length(pattern), length(pattern[1]))

    for i in 1:lastindex(pattern)
        for j in 1:lastindex(pattern[1])
            p[i,j] = (pattern[i][j] == '#')
        end
    end
    
    # check if pattern is symmetric around each row, then check for each column
    n, m = size(p)
    for row in 1:n-1

        maxsize = min(row, n-row)
        difference = 0
        for (i,rowrefl) in enumerate(row+1:row+maxsize)
            difference += sum(xor.(p[row+1-i,:], p[rowrefl,:]) )
        end
        if (difference == 0 && !parttwo) || (parttwo && difference == 1)
            return 0, row*100
        end
    end

    for col in 1:m-1

        maxsize = min(col, m-col)
        difference = 0
        for (i, colrefl) in enumerate(col+1:col+maxsize)
            difference += sum(xor.(p[:, col+1-i], p[:, colrefl]))
        end
        if (difference == 0 && !parttwo) || (parttwo && difference == 1)
            return col, 0
            break
        end
    end
    0, 0
end

function solve(io, parttwo=false)
    pattern = []
    colnum = 0
    rownum = 0
    for line in readlines(io)

        if length(line) > 0
            push!(pattern, line)
        else
            c,r = findreflection(pattern, parttwo)
            colnum += c
            rownum += r
            pattern = []
        end
    end
    c,r = findreflection(pattern, parttwo)
    colnum += c
    rownum += r

    colnum + rownum
end