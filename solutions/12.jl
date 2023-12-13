
function solvefast(io, parttwo=false)

    memo = Dict()

    function testgroups(str, groups::Vector{Int}, j=1, g_idx=0, counter=0, last=' ')

        return get!(memo, (j, counter, g_idx, last)) do
            for i in j:length(str)
                x = str[i]
                if x == '#' || last == '#'
                    last = ' '
                    counter == 0 && (g_idx += 1)
                    # if longer than current group: no match
                    g_idx > length(groups) && return 0
                    counter += 1
                    # if unaccounted for by groups: no match
                    counter > groups[g_idx] && return 0
                elseif x == '.' || last == '.'
                    last = ' '
                    # if cuts short current group: no match
                    0 < counter < groups[g_idx] && return 0
                    counter = 0
                elseif x == '?'
                    if g_idx > 0 && 0 < counter < groups[g_idx]
                        counter += 1
                    elseif g_idx > 0 && counter == groups[g_idx]
                        counter = 0
                    else
                        a = testgroups(str, groups, i, g_idx, counter, '#')
                        b = testgroups(str, groups, i, g_idx, counter, '.')
                        return a + b
                    end
                end
            end

            if counter == 0 && g_idx == length(groups) || counter == groups[end] && g_idx == length(groups)
                return 1
            else
                return 0
            end
        end
    end

    countsum = 0
    for (i, line) in enumerate(eachline(io))
        str, nums = split(line, " ")

        nums = parse.(Int, split(nums, ","))
        if parttwo
            str = (str * "?")^4 * str
            nums = repeat(nums, 5)
        end
        empty!(memo)
        countsum += testgroups(str, nums)
    end

    countsum
end
