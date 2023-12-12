
function solvefast(io,parttwo=false)

    memo = Dict([])

    function testgroups(str, groups::Vector{Int}, g_idx=0, counter=0)

    if haskey(memo, (str,counter,g_idx)) 
        return memo[(str,counter,g_idx)]
    end

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
                a = testgroups("#" * str[i+1:end], groups, g_idx, counter)
                memo[("#" * str[i+1:end], counter, g_idx)] = a
                b = testgroups("." * str[i+1:end], groups, g_idx, counter)
                memo[("." * str[i+1:end], counter, g_idx)] = b
                return a+b
            end
        end
    end

    if counter == 0 && g_idx == length(groups) || counter == groups[end] && g_idx == length(groups)
        return 1
    else
        return 0
    end
end

    countsum = 0
    for (i,line) in enumerate(eachline(io))
        str, nums = split(line, " ")

        nums = parse.(Int, split(nums, ","))
        if parttwo
            str = (str * "?")^4 * str
            nums = repeat(nums, 5)
        end
        memo = Dict([])
        countsum += testgroups(str, nums)
    end

    countsum
end
