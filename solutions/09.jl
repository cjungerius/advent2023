function solve(io)

    nextvals = Int[]
    prevvals = Int[]

    for line in eachline(io)
        obs = parse.(Int,split(line))
        
        starts = Int[]
        ends = Int[]

        while !all(==(0),obs)            
            push!(starts,obs[1])
            push!(ends,obs[end])
            obs = diff(obs)
        end

        push!(prevvals,foldr(-,starts))
        push!(nextvals, sum(ends))
    end
    sum(nextvals), sum(prevvals)
end

partone, parttwo = solve("data/09in.txt")
