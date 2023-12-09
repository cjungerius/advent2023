function solve(io)

    nextvals = Int[]
    prevvals = Int[]

    for line in eachline(io)
        obs = parse.(Int,split(line))
        
        starts = Int[obs[1]]
        ends = Int[obs[end]]

        while !all(==(0),obs)            
            obs = diff(obs)
            push!(starts,obs[1])
            push!(ends,obs[end])
        end

        push!(prevvals,foldr(-,starts))
        push!(nextvals, sum(ends))
    end
    sum(nextvals), sum(prevvals)
end

partone, parttwo = solve("data/09in.txt")
