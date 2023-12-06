function race(time, distance)
    # How i solved it first: works just fine (~19ms for solve2)
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

function race_poly(time,distance)
    # find all solutions where x(t-x) > d:
    # in other words, where -x^2+tx-d > 0 or x^2 -tx + d < 0
    # concave, so find both intersects with 0 using discriminant rule
    discr = time^2-4*distance # b^2 - 4ac ((-b)^2 == b^2)
    sol1 = (time + sqrt(discr))/2
    sol2 = (time - sqrt(discr))/2
    return ceil(sol1) - floor(sol2) - 1 # all solutions BETWEEN the two intersects
end


function solve1(io)
    input = readlines(io)
    times = parse.(Int,split(input[1])[2:end])
    distances = parse.(Int,split(input[2])[2:end])

    total = ones(Int,length(times))
    for i in eachindex(times)
        total[i] = race_poly(times[i],distances[i])
    end
    *(total...)
end

function solve2(io)
    input = readlines(io)
    time = parse(Int,*(split(input[1])[2:end]...))
    distance = parse(Int,*(split(input[2])[2:end]...))
   
    race_poly(time,distance)
end

solve1("data/06in.txt")
solve2("data/06in.txt")