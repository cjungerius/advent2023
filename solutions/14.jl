function solve1(io)
    input = readlines(io)

    platform = fill(' ', length(input), length(input[1]))

    for i in 1:lastindex(input)
        for j in 1:lastindex(input[1])
            platform[i,j] = input[i][j]
        end
    end

    while true
        something_moved = false
        for i in 2:lastindex(platform,1)
            for j in 1:lastindex(platform,2)
                if platform[i,j] == 'O' && platform[i-1,j] == '.'
                    platform[i,j] = '.'
                    platform[i-1,j] = 'O'
                    something_moved = true
                end
            end
        end
        if !something_moved
            break
        end
    end

    north_load = 0

    for i in 1:lastindex(platform,1)
        for j in 1:lastindex(platform,2)
            if platform[i,j] == 'O'
                north_load += size(platform,1) - i + 1
            end
        end
    end

    north_load
end


function solve2(io,n=1)
    input = readlines(io)

    platform = fill(' ', length(input), length(input[1]))

    for i in 1:lastindex(input)
        for j in 1:lastindex(input[1])
            platform[i,j] = input[i][j]
        end
    end

    states = Dict()
    dir = 0
    cycle = 0
    jumped = false
    
    while cycle < n
        cycle += 1
        # move the Os up
        dir = 0
        while true
            something_moved = false
            for i in 2:lastindex(platform,1)
                for j in 1:lastindex(platform,2)
                    if platform[i,j] == 'O' && platform[i-1,j] == '.'
                        platform[i,j] = '.'
                        platform[i-1,j] = 'O'
                        something_moved = true
                    end
                end
            end
            if !something_moved
                break
            end
        end

        # move the Os left
        dir = 1
        while true
            something_moved = false
            for j in 2:lastindex(platform,2)
                for i in 1:lastindex(platform,1)
                    if platform[i,j] == 'O' && platform[i,j-1] == '.'
                        platform[i,j] = '.'
                        platform[i,j-1] = 'O'
                        something_moved = true
                    end
                end
            end
            if !something_moved
                break
            end
        end

        # move the Os down
        dir = 2
        while true
            something_moved = false
            for i in lastindex(platform,1)-1:-1:1
                for j in 1:lastindex(platform,2)
                    if platform[i,j] == 'O' && platform[i+1,j] == '.'
                        platform[i,j] = '.'
                        platform[i+1,j] = 'O'
                        something_moved = true
                    end
                end
            end
            if !something_moved
                break
            end
        end

        #move the Os right
        dir = 3
        while true
            something_moved = false
            for j in lastindex(platform,2)-1:-1:1
                for i in 1:lastindex(platform,1)
                    if platform[i,j] == 'O' && platform[i,j+1] == '.'
                        platform[i,j] = '.'
                        platform[i,j+1] = 'O'
                        something_moved = true
                    end
                end
            end
            if !something_moved
                break
            end
        end

        if haskey(states, (platform, dir)) && !jumped
            jumped = true
            prev = states[(platform,dir)]
            cycle_length = cycle - prev
            println("cycle $cycle seen before at $prev, cycle length $cycle_length")
            cycle += div(n-cycle, cycle_length) * cycle_length
            println("jumped to $cycle")
        else
            states[(copy(platform), dir)] = cycle
        end
    end

    north_load = 0

    for i in 1:lastindex(platform,1)
        for j in 1:lastindex(platform,2)
            if platform[i,j] == 'O'
                north_load += size(platform,1) - i + 1
            end
        end
    end

    north_load, cycle
end