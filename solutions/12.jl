function stepthroughstring(pattern, str)

    if match(pattern, str) === nothing
        return 0
    end

    i = findfirst("?", str)

    if i === nothing
        return 1
    else
        return sum(stepthroughstring(pattern, replace(str, "?" => "#", count = 1)) + stepthroughstring(pattern, replace(str, "?" => ".", count = 1)))
    end
end

function testmatches(str, groups::Vector{Int})

    p = raw"^[\.\?]*"
    e = groups[end]
    for g in groups[1:end-1]
        p *= raw"[#\?]" * "{$g}" * raw"[\.\?]+"
    end
    p *= raw"[#\?]" * "{$e}" * raw"[\.\?]*$"

    pattern = Regex(p)

    stepthroughstring(pattern, str)
end

function solve(io, parttwo = false)

    countsum = 0
    for line in eachline(io)
        str, nums = split(line, " ")
        nums = parse.(Int, split(nums, ","))
        if parttwo
            str = (str * "?")^4 * str
            nums = repeat(nums, 5)
        end
        countsum += testmatches(str, nums)
    end

    countsum
end
