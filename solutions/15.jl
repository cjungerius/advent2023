function gethash(str)
    h = 0
    for c in str
        h += Int(c)
        h *= 17
        h = rem(h, 256)
    end
    h
end

function solve1(io)
    commands = readline(io)
    hashsum = sum(gethash.(split(commands,",")))
    hashsum
end

function solve2(io)
    commands = readline(io)
    boxes = [[] for i in 1:256]
    for command in split(commands,",")
        label = findfirst(r"[a-z]+",command)
        box = gethash(command[label])+1
        if command[label[end]+1] == '-'
            i = findfirst(==(command[label]),boxes[box])
            !isnothing(i) && deleteat!(boxes[box],i:i+1)
        elseif command[label[end]+1] == '='
            i = findfirst(==(command[label]), boxes[box])
            if isnothing(i)
                push!(boxes[box],command[label], parse(Int,command[length(label)+2:end]))
            else
                boxes[box][i+1] = parse(Int, command[length(label)+2:end])
            end
        end
    end

    focus = 0

    for (i,box) in enumerate(boxes)
        filter!(x -> typeof(x)==Int,box)
        for (j, n) in enumerate(box)
            focus += i*j*n
        end
    end
    
    focus
end