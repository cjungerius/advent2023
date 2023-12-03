function solve1(io)
    m = readlines(io)
    l = length(m[1])
    partnum = 0
    above, adjacent, below = (false, false, false)
    for i in eachindex(m)
        nums = findall(r"([0-9]+)",m[i])
        for n in nums
            above, adjacent, below = (false, false, false)
            leftbound = n[1] > 1 ? n[1] - 1 : n[1]
            rightbound = n[end] < l ? n[end] + 1 : n[end]

            i > 1 && (above = match(r"([^0-9\.])",m[i-1][leftbound:rightbound]) !== nothing)
            adjacent = match(r"([^0-9\.])",m[i][leftbound:rightbound]) !== nothing
            i < length(m) && (below = match(r"([^0-9\.])",m[i+1][leftbound:rightbound]) !== nothing)
            
            any([above,adjacent,below]) && (partnum += parse(Int,m[i][n]))
        end
    end
    partnum
end


function solve2(io)
    m = readlines(io)
    gearratios = 0
    for i in eachindex(m)
        gears = findall("*",m[i])
        for g in gears

            all_above = findall(r"([0-9]+)",m[i-1])
            all_adjacent = findall(r"([0-9]+)",m[i])
            all_below = findall(r"([0-9]+)",m[i+1])

            nums_above = filter(x -> g[1] in x || g[1]-1 in x || g[1]+1 in x, all_above)
            nums_adjacent = filter(x -> g[1]-1 in x || g[1]+1 in x, all_adjacent)
            nums_below = filter(x -> g[1] in x || g[1]-1 in x || g[1]+1 in x, all_below)
            
            if length(nums_above) + length(nums_adjacent) + length(nums_below) == 2
                y = vcat(
                    map(x -> parse(Int,m[i-1][x]), nums_above),
                    map(x -> parse(Int,m[i][x]), nums_adjacent),
                    map(x -> parse(Int,m[i+1][x]), nums_below)
                )
                gearratios += y[1]*y[2]
            end
        end
    end
    gearratios
end

solve1("data/03in.txt")
solve2("data/03in.txt")
