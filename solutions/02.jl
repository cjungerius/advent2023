function solve1(io)

    possible = 0

    colordict = Dict(
        "red" => 12,
        "green" => 13,
        "blue" => 14
    )

    for line in eachline(io)
        invalid = false
        id, game = split(line, ": ")
        for turn in split(game, "; ")
            invalid && break
            for draw in split(turn, ", ")
                invalid && break
                num, col = split(draw, " ")
                if parse(Int, num) > colordict[col]
                    invalid = true
                    break
                end
            end
        end
        if !invalid
            _, idval = split(id, " ")
            possible += parse(Int, idval)
        end
    end
    possible
end


function solve2(io)
    power = 0

    colordict = Dict(
        "red" => 0,
        "green" => 0,
        "blue" => 0
    )


    for line in eachline(io)

        colordict["red"] = 0
        colordict["green"] = 0
        colordict["blue"] = 0

        id, game = split(line, ": ")
        for turn in split(game, "; ")
            for draw in split(turn, ", ")
                num, col = split(draw, " ")
                colordict[col] = max(colordict[col], parse(Int, num))
            end
        end
        power += colordict["red"] * colordict["green"] * colordict["blue"]
    end
    power
end

solve1("data/01in.txt")
solve2("data/01in.txt")