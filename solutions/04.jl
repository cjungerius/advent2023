function solve1(io)
    total = 0
    for line in eachline(io)
        matches = 0
        _, card = split(line,": ")
        l, r = split(card, " | ")
        winning = parse.(Int,split(l))
        have = parse.(Int,split(r))
        for n in have
            n in winning && (matches += 1)
        end
        matches > 0 && (total += 2^(matches-1))
    end
    total
end

function solve2(io)

    input = readlines(io)
    cardcount = ones(Int,length(input))

    for i in eachindex(input)
        matches = 0
        _, card = split(input[i],": ")
        l, r = split(card, " | ")
        winning = parse.(Int,split(l))
        have = parse.(Int,split(r))
        
        for n in have
            n in winning && (matches += 1)
        end
        
        if matches > 0
            cardcount[i+1:i+matches] .+= cardcount[i]
        end
    end
    sum(cardcount)
end


solve1("data/04in.txt")
solve2("data/04in.txt")