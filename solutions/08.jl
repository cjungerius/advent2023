function solve1(io)
    input = readlines(io)
    leftright = input[1]

    steps = Dict{String, Tuple{String, String}}()

    for line in input[3:end]
        matches = findall(r"[A-Z]+", line)
        k, v1, v2 = [line[m] for m in matches]
        steps[k] = (v1, v2)
    end

    loc = "AAA"
    n = 0

    while loc != "ZZZ"
        for lr in leftright
            loc = lr == 'L' ? steps[loc][1] : steps[loc][2]
            n += 1
            if loc == "ZZZ" break end
        end
    end
    n
end

function solve2(io)
    input = readlines(io)
    leftright = input[1]

    steps = Dict{String, Tuple{String, String}}()

    locs = String[]

    for line in input[3:end]
        matches = findall(r"[A-Z]+", line)
        k, v1, v2 = [line[m] for m in matches]
        steps[k] = (v1, v2)
        if k[end] == 'A' push!(locs,k) end

    end

    ns = Int[]


    for loc in locs
        n=0
        while loc[end] != 'Z'
            for lr in leftright
                loc = lr == 'L' ? steps[loc][1]  : steps[loc][2]
                n += 1
                if loc[end] =='Z' break end
            end
        end
        push!(ns,n)
    end
    lcm(ns)
end