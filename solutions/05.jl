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
