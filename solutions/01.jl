function solve(io)
    total = 0
    for line in eachline(io)
        lineval = ""
        for c in line
            isnumeric(c) && (lineval *= c)
        end
        total += parse(Int, lineval[1] * lineval[end])
    end
    total
end

function solve2(io)
    total = 0

    numberdict = Dict(
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9"
    )

    for line in eachline(io)
        lineval = ""
        matches = findall(r"(?|[1-9]|zero|one|two|three|four|five|six|seven|eight|nine)", line, overlap=true)
        for m in matches
            length(m) == 1 ? lineval *= line[m] : lineval *= numberdict[line[m]]
        end
        total += parse(Int, lineval[1] * lineval[end])
    end
    total
end

solve1("data/01in.txt")
solve2("data/01in.txt")