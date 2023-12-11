function solve1(io)

    input = readlines(io)
    output = zeros(Int, length(input), length(input[1]))

    ssearch = findfirst.('S', input)
    prevcol = filter(!isnothing, ssearch)[1]
    prevrow = findfirst(!isnothing, ssearch)

    row = 0
    col = 0
    firstdir = ""
    lastdir = ""

    if input[prevrow-1][prevcol] in ['I', '7', 'F']
        row, col = (prevrow - 1, prevcol)
        firstdir = "up"
    elseif input[prevrow+1][prevcol] in ['I', 'L', 'J']
        row, col = (prevrow + 1, prevcol)
        firstdir = "down"
    elseif input[prevrow][prevcol+1] in ['-', 'J', '7']
        row, col = (prevrow, prevcol + 1)
        firstdir = "right"
    end

    nextrow = 0
    nextcol = 0
    n = 0

    while true
        nextrow = row
        nextcol = col
        output[row, col] = 1
        n += 1
        if input[row][col] == '|'
            prevrow < row ? nextrow += 1 : nextrow -= 1
        elseif input[row][col] == '-'
            prevcol < col ? nextcol += 1 : nextcol -= 1
        elseif input[row][col] == 'L'
            prevrow < row ? nextcol += 1 : nextrow -= 1
        elseif input[row][col] == 'J'
            prevrow < row ? nextcol -= 1 : nextrow -= 1
        elseif input[row][col] == '7'
            prevcol < col ? nextrow += 1 : nextcol -= 1
        elseif input[row][col] == 'F'
            prevcol > col ? nextrow += 1 : nextcol += 1
        elseif input[row][col] == 'S'
            if prevrow > row
                lastdir = "up"
            elseif prevrow < row
                lastdir = "down"
            elseif prevcol > col
                lastdir = "left"
            elseif prevcol < col
                lastdir = "right"
            end
            break
        end
        prevrow, prevcol = (row, col)
        row, col = (nextrow, nextcol)
    end

    (floor(n / 2), output, firstdir, lastdir)
end

function solve2(io)

    _, pipemap, firstdir, lastdir = solve1(io)

    crossing = 0
    insidearea = 0
    sconvert = ' '

    # if firstdir is up or down and lastdir is up or down, then convert 'S' to '|'
    if (firstdir in ["up", "down"]) && (lastdir in ["up", "down"])
        sconvert = '|'
    elseif (firstdir in ["left", "right"]) && (lastdir in ["left", "right"])
        sconvert = '-'
    elseif (firstdir == "up" && lastdir == "left") || (firstdir == "right" && lastdir == "down")
        sconvert = 'L'
    elseif (firstdir == "up" && lastdir == "right") || (firstdir == "left" && lastdir == "down")
        sconvert = 'J'
    elseif (firstdir == "down" && lastdir == "left") || (firstdir == "right" && lastdir == "up")
        sconvert = 'F'
    elseif (firstdir == "down" && lastdir == "right") || (firstdir == "left" && lastdir == "up")
        sconvert = '7'
    end

    for (line_index, line) in enumerate(eachline(io))
        crossing = 0
        for (char_index, c) in enumerate(line)
            # Access corresponding element in pipemap
            if pipemap[line_index, char_index] == 1

                if c == 'S'
                    c = sconvert
                end

                if c in ['|','L','J']
                    crossing += 1
                end
            else
                insidearea += crossing % 2
            end
        end
    end

    insidearea
end