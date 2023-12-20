using DataStructures

function solve(io)

    dirdict = Dict([
        0 => (0, 1)
        1 => (1, 0)
        2 => (0, -1)
        3 => (-1, 0)
    ])

    input = [parse.(Int, split(line,"")) for line in readlines(io)]

    visited = Set{Tuple{Int,Int,Int, Int}}()

    queue = PriorityQueue{Tuple{Int, Int, Int, Int, Int}, Int}()
    push!(queue, (0, 1, 1, 0, 1) => 0)
    push!(queue, (0, 1, 1, 1, 1) => 0)
    push!(visited, (1, 1, 0, 1))
    push!(visited, (1, 1, 1, 1))

    while !isempty(queue)
        (heat, x, y, dir, steps) = dequeue!(queue)        

        # where am i now based on x y and direction
        next_x, next_y = (x, y) .+ dirdict[dir]

        # check if in bounds
        if next_x < 1 || next_x > length(input) || next_y < 1 || next_y > length(input[1])
            continue
        end
        
        # check if visited before
        if (next_x, next_y, dir, steps) in visited
            continue
        else
            push!(visited, (next_x, next_y, dir, steps))
        end
        
        # what did it cost to get here
        new_heat = heat + input[next_x][next_y]        

        # check if we are at the end
        if next_x == length(input) && next_y == length(input[1])
            return new_heat
        end

        # add all possible next steps
        for next_dir in 0:3
            next_len = next_dir == dir ? steps + 1 : 1
            next_len > 3 && continue
            (dir + 2) % 4 == next_dir && continue
            push!(queue, (new_heat, next_x, next_y, next_dir, next_len) => new_heat)
        end
    end
    
    return -1
end

function solve2(io)

    dirdict = Dict([
        0 => (0, 1)
        1 => (1, 0)
        2 => (0, -1)
        3 => (-1, 0)
    ])

    input = [parse.(Int, split(line,"")) for line in readlines(io)]

    visited = Set{Tuple{Int,Int,Int, Int}}()

    queue = PriorityQueue{Tuple{Int, Int, Int, Int, Int}, Int}()
    push!(queue, (0, 1, 1, 0, 1) => 0)
    push!(queue, (0, 1, 1, 1, 1) => 0)
    push!(visited, (1, 1, 0, 1))
    push!(visited, (1, 1, 1, 1))

    while !isempty(queue)
        (heat, x, y, dir, steps) = dequeue!(queue)        

        # where am i now based on x y and direction
        next_x, next_y = (x, y) .+ dirdict[dir]

        # check if in bounds
        if next_x < 1 || next_x > length(input) || next_y < 1 || next_y > length(input[1])
            continue
        end
        
        # check if visited before
        if (next_x, next_y, dir, steps) in visited
            continue
        else
            push!(visited, (next_x, next_y, dir, steps))
        end
        
        # what did it cost to get here
        new_heat = heat + input[next_x][next_y]        

        # check if we are at the end
        if next_x == length(input) && next_y == length(input[1])
            return new_heat
        end

        # add all possible next steps
        # if we have taken fewer than 4 steps, we can only go straight:
        if steps < 4
            push!(queue, (new_heat, next_x, next_y, dir, steps + 1) => new_heat)
        # if we have taken 10 steps, we can only turn:
        elseif steps == 10
            for next_dir in 0:3
                next_dir == dir && continue
                (dir + 2) % 4 == next_dir && continue
                push!(queue, (new_heat, next_x, next_y, next_dir, 1) => new_heat)
            end
        else
            # otherwise, we can go straight or turn:
            for next_dir in 0:3
                next_len = next_dir == dir ? steps + 1 : 1
                (dir + 2) % 4 == next_dir && continue
                push!(queue, (new_heat, next_x, next_y, next_dir, next_len) => new_heat)
            end
        end
    end
    
    return -1
end