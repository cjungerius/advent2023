function solve1(io)

    input = readlines(io)
    seeds = parse.(Int,split(input[1])[2:end])

    mapsets = []
    maps = []
    for line in input[3:end]

        if length(line) == 0
            push!(mapsets,maps)
            maps = []
        elseif !isnumeric(line[1])
            continue
        else
            push!(maps,parse.(Int,split(line)))        
        end
    end
    # don't forget the last mapset!
    push!(mapsets,maps)

    for i in eachindex(seeds)
        for mapset in mapsets
            for map in mapset
                tgt, src, r = map
                if seeds[i] in src:src+r-1
                    seeds[i] += tgt - src
                    break
                end
            end
        end
    end

    minimum(seeds)
end

function solve2(io)

    input = readlines(io)
    seedranges = parse.(Int,split(input[1])[2:end])
    current_set = []
    for i in 1:2:length(seedranges)
        push!(current_set,seedranges[i]:seedranges[i]+seedranges[i+1]-1)
    end

    mapsets = []
    maps = []
    for line in input[3:end]

        if length(line) == 0
            push!(mapsets,maps)
            maps = []
        elseif !isnumeric(line[1])
            continue
        else
            push!(maps,parse.(Int,split(line)))        
        end
    end
    # don't forget the last mapset!
    push!(mapsets,maps)

    for mapset in mapsets
        next_set = []
        for seedrange in current_set

            any_overlaps = false

            for map in mapset
                maprange = map[2]:map[2]+map[3]-1
                overlap = intersect(maprange,seedrange)

                if length(overlap) > 0

                    any_overlaps = true

                    new_seed = overlap[1] + (map[1] - map[2]):overlap[end] + (map[1] - map[2])
                    push!(next_set, new_seed)
                    
                    if overlap[1] > seedrange[1]
                        leftovers_left = seedrange[1]:overlap[1]-1
                        push!(current_set, leftovers_left)
                    end

                    if overlap[end] < seedrange[end]
                        leftovers_right = overlap[end]+1:seedrange[end]
                        push!(current_set, leftovers_right)
                    end

                end

            end

            if !any_overlaps
                push!(next_set,seedrange)
            end
        end
        current_set = next_set
    end

    minimum(current_set)[1]
end

function solve2fast(io)

    function fastintersect(x::Vector{Int},y::Vector{Int})
        return Int[max(x[1],y[1]), min(x[2],y[2])]
    end

    input = readlines(io)
    seedranges = parse.(Int,split(input[1])[2:end])
    current_set = Set([])
    for i in 1:2:length(seedranges)
        push!(current_set,[seedranges[i],seedranges[i]+seedranges[i+1]-1])
    end

    mapsets = []
    maps = []
    for line in input[3:end]

        if length(line) == 0
            push!(mapsets,maps)
            maps = []
        elseif !isnumeric(line[1])
            continue
        else
            vals = parse.(Int,split(line))
            push!(maps,[vals[2],vals[2]+vals[3]-1,vals[1]-vals[2]])        
        end
    end
    # don't forget the last mapset!
    push!(mapsets,maps)

    overlap = Int[0,0]

    for mapset in mapsets
        next_set = Set([])
        while !isempty(current_set)
            seedrange = pop!(current_set)

            any_overlaps = false

            for map in mapset

                overlap = fastintersect(map[1:2],seedrange)

                if overlap[2] > overlap[1]

                    any_overlaps = true

                    new_seed = [overlap[1] + map[3], overlap[2] + map[3]]
                    push!(next_set, new_seed)
                    
                    if overlap[1] > seedrange[1]
                        leftovers_left = [seedrange[1],overlap[1]-1]
                        push!(current_set, leftovers_left)
                    end

                    if overlap[2] < seedrange[2]
                        leftovers_right = [overlap[2]+1,seedrange[2]]
                        push!(current_set, leftovers_right)
                    end

                end

            end

            if !any_overlaps
                push!(next_set,seedrange)
            end
        end
        current_set = next_set
    end

    minimum(current_set)[1]
end

solve1("data/05in.txt")
solve2fast("data/05in.txt")