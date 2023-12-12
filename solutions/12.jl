function stepthroughstring(pattern, str)

    if match(pattern, str) === nothing
        return 0
    end

    i = findfirst("?", str)

    if i === nothing
        return 1
    else
        return stepthroughstring(pattern, replace(str, "?" => "#", count = 1)) + stepthroughstring(pattern, replace(str, "?" => ".", count = 1))
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

function testgroups(str, groups::Vector{Int})

    #count('#',str) > sum(groups) && return 0
    #count('#',str) + count('?',str) < sum(groups) && return 0

    counter = 0
    g_idx = 0

    for (i, x) in enumerate(str)
        if x == '#'
            counter == 0 && (g_idx += 1)
            # if longer than current group: no match
            g_idx > length(groups) && return 0
            counter += 1
            # if unaccounted for by groups: no match
            counter > groups[g_idx] && return 0
        elseif x == '.'
            # if cuts short current group: no match
            0 < counter < groups[g_idx] && return 0
            counter = 0
        elseif x == '?'
            if g_idx > 0 && 0 < counter < groups[g_idx]
                counter += 1
            elseif g_idx > 0 && counter == groups[g_idx]
                counter = 0
            else
                return testgroups(str[1:i-1] * "#" * str[i+1:end], groups) + testgroups(str[1:i-1] * "." * str[i+1:end], groups)
            end
        end
    end

    if counter == 0 && g_idx == length(groups) || counter == groups[end] && g_idx == length(groups)
        return 1
    else
        return 0
    end
end

function solve(io, parttwo = false)

    countsum = 0
    for line in eachline(io)
        str, nums = split(line, " ")
        nums = parse.(Int, split(nums, ","))
        countsum += testmatches(str, nums)
    end

    countsum
end




function solvefast(io,parttwo=false)

    countsum = 0
    for (i,line) in enumerate(eachline(io))
        str, nums = split(line, " ")

        nums = parse.(Int, split(nums, ","))
        if parttwo
            str = (str * "?")^4 * str
            nums = repeat(nums, 5)
        end
        countsum += testgroups(str, nums)
        println("Line $i done!")
    end

    countsum
end
