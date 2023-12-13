function findreflection(pattern)

    p = fill(false, length(pattern), length(pattern[1]))

    for i in 1:lastindex(pattern)
        for j in 1:lastindex(pattern[1])
            p[i,j] = (pattern[i][j] == '#')
        end
    end
    
    # check if pattern is symmetric around each row, then check for each column
    n, m = size(p)
    for row in 1:n-1

        rowsym = true
        maxsize = min(row, n-row)
        for (i,rowrefl) in enumerate(row+1:row+maxsize)
            if p[row+1-i,:] != p[rowrefl,:]
                rowsym = false
                break
            end
        end
        if rowsym
            return 0, row*100
            break
        end
    end

    for col in 1:m-1

        colsym = true
        maxsize = min(col, m-col)
        for (i, colrefl) in enumerate(col+1:col+maxsize)
            if p[:, col+1-i] != p[:, colrefl]
                colsym = false
                break
            end
        end
        if colsym
            return col, 0
            break
        end
    end
    0, 0
end

function findreflection_smudge(pattern)

    p = fill(false, length(pattern), length(pattern[1]))

    for i in 1:lastindex(pattern)
        for j in 1:lastindex(pattern[1])
            p[i,j] = (pattern[i][j] == '#')
        end
    end
    
    # check if pattern is symmetric around each row, then check for each column
    n, m = size(p)
    for row in 1:n-1
        
        smudge_used = false
        rowsym = true
        maxsize = min(row, n-row)
        for (i,rowrefl) in enumerate(row+1:row+maxsize)
            if p[row+1-i,:] != p[rowrefl,:]
                if sum(p[row+1-i,:]) - sum(p[rowrefl,:]) == 1 && !smudge_used
                    smudge_used = true
                    continue
                end
                rowsym = false
                break
            end
        end
        if rowsym && smudge_used
            return 0, row*100
            break
        end
    end

    for col in 1:m-1

        colsym = true
        maxsize = min(col, m-col)
        for (i, colrefl) in enumerate(col+1:col+maxsize)
            if p[:, col+1-i] != p[:, colrefl]
                colsym = false
                break
            end
        end
        if colsym
            return col, 0
            break
        end
    end
    0, 0
end

function solve(io)
    pattern = []
    colnum = 0
    rownum = 0
    for line in readlines(io)

        if length(line) > 0
            push!(pattern, line)
        else
            c,r = findreflection(pattern)
            colnum += c
            rownum += r
            pattern = []
        end
    end
    c,r = findreflection(pattern)
    colnum += c
    rownum += r

    colnum + rownum
end