using DataStructures

function gridsearch(input, starting_loc=(1,1,0))
    lightgrid = fill(false,length(input),length(input[1]))

    dir_dict = Dict(0 => (0,1),1 => (1,0),2 => (0,-1),3 => (-1,0))

    locs_to_check = Stack{Tuple{Int,Int,Int}}()
    visited = Set{Tuple{Int,Int,Int}}()
    push!(locs_to_check,starting_loc)

    while !isempty(locs_to_check)
        current_loc = pop!(locs_to_check)
        if current_loc[1] < 1 || current_loc[1] > length(input) || current_loc[2] < 1 || current_loc[2] > length(input[1])
            continue
        end

        if current_loc in visited
            continue
        end

        push!(visited,current_loc)

        lightgrid[current_loc[1],current_loc[2]] = true

        dir = current_loc[3]
        current_item = input[current_loc[1]][current_loc[2]]

        if current_item == '.'
            push!(locs_to_check,(current_loc[1]+dir_dict[dir][1],current_loc[2]+dir_dict[dir][2],dir))
        elseif current_item == '/'
            if dir == 0 || dir == 2
                dir = mod(dir-1, 4)
            else
                dir = mod(dir+1, 4)
            end
            push!(locs_to_check,(current_loc[1]+dir_dict[dir][1],current_loc[2]+dir_dict[dir][2],dir))
        elseif current_item == '\\'
            if dir == 0 || dir == 2
                dir = mod(dir+1, 4)
            else
                dir = mod(dir-1, 4)
            end
            push!(locs_to_check,(current_loc[1]+dir_dict[dir][1],current_loc[2]+dir_dict[dir][2],dir))
        elseif current_item == '|'
            if dir == 1 || dir == 3
                push!(locs_to_check,(current_loc[1]+dir_dict[dir][1],current_loc[2]+dir_dict[dir][2],dir))
            else
                push!(locs_to_check,(current_loc[1]+dir_dict[mod(dir+1,4)][1],current_loc[2]+dir_dict[mod(dir+1,4)][2],mod(dir+1,4)))
                push!(locs_to_check,(current_loc[1]+dir_dict[mod(dir-1,4)][1],current_loc[2]+dir_dict[mod(dir-1,4)][2],mod(dir-1,4)))
            end
        elseif current_item == '-'
            if dir == 0 || dir == 2
                push!(locs_to_check,(current_loc[1]+dir_dict[dir][1],current_loc[2]+dir_dict[dir][2],dir))
            else
                push!(locs_to_check,(current_loc[1]+dir_dict[mod(dir+1,4)][1],current_loc[2]+dir_dict[mod(dir+1,4)][2],mod(dir+1,4)))
                push!(locs_to_check,(current_loc[1]+dir_dict[mod(dir-1,4)][1],current_loc[2]+dir_dict[mod(dir-1,4)][2],mod(dir-1,4)))
            end
        end
    end
    sum(lightgrid)
end

function solve1(io)
    input = readlines(io)
    gridsearch(input)    
end

function solve2(io)

    input = readlines(io)
    result = 0
    for i in 1:length(input)
        leftattempt = gridsearch(input, (i,1,0))
        downattempt = gridsearch(input, (1,i,1))
        rightattempt = gridsearch(input, (i,length(input[1]),2))
        downattempt = gridsearch(input, (length(input),i,3))
        result = max(result, leftattempt, downattempt, rightattempt, downattempt)
    end
    result
end