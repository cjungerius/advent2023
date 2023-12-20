function solve(io, part2=false)
    instructions = Tuple{String, Int}[]
    for line in eachline(io)
        if !part2
            dir, len, _ = split(line, " ")
            push!(instructions, (dir, parse(Int, len)))
        else
            _, _, code = split(line, " ")
            len = parse(Int, code[3:end-2],base=16)
            dir = code[end-1] == "0" ? "R" : code[end-1] == "1" ? "D" : code[end-1] == "2" ? "L" : "U"   
            push!(instructions, (dir, len))
        end
    end

    x = 0
    y = 0
    trenches = Set()

    for (dir, len) in instructions
        dx, dy = dir == "U" ? (0, 1) : dir == "D" ? (0, -1) : dir == "L" ? (-1, 0) : (1, 0)
        for _ in 1:len
            x += dx
            y += dy
            push!(trenches, (x, y))
        end
    end

    x_low = minimum(x for (x, y) in trenches)
    x_max = maximum(x for (x, y) in trenches)
    y_low = minimum(y for (x, y) in trenches)
    y_max = maximum(y for (x, y) in trenches)
    
    dug::BigInt = 0
    for i in x_low:x_max
        crossings = 0
        for j in y_low:y_max
            if (i, j) in trenches
                if (i-1, j) in trenches
                    crossings += 1
                end
                dug += 1
            elseif crossings % 2 == 1
                dug += 1
            end
        end
    end
    dug
end