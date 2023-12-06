function race(time, distance)
    wins = 0
    peaked = false
    for t in time:-1:1
        d = t * (time-t)
        if d > distance
            peaked = true
            wins += 1
        else
            peaked ? break : continue
        end
    end
    wins
end

function solve1(io)

    input = readlines(io)
    times = parse.(Int,split(input[1])[2:end])
    distances = parse.(Int,split(input[2])[2:end])

    total = ones(Int,length(times))
    for i in eachindex(times)
        total[i] = race(times[i],distances[i])
    end
    *(total...)
end

function solve2(io)
    input = readlines(io)
    time = parse(Int,*(split(input[1])[2:end]...))
    distance = parse(Int,*(split(input[2])[2:end]...))
   
    race(time,distance)
end
