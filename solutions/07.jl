using StatsBase

function handrate(hand)
    jcount = count(==(1), hand)
    cardcounts = sort!(counts(hand, 2:14), rev=true)

    if jcount + cardcounts[1] == 5
        #five of a kind
        return 6
    elseif jcount + cardcounts[1] == 4
        #four of a kind
        return 5
    elseif jcount + cardcounts[1] == 3 && cardcounts[2] == 2
        #full house
        return 4
    elseif jcount + cardcounts[1] == 3
        #three of a kind
        return 3
    elseif cardcounts[1] == 2 && cardcounts[2] == 2
        #two pair
        return 2
        #one pair
    elseif jcount + cardcounts[1] == 2
        return 1
    else
        #high card
        return 0
    end
end

function cardsort(hand1, hand2)

    val1 = handrate(hand1)
    val2 = handrate(hand2)
    if val1 != val2
        return val1 < val2
    else
        #same type: rate by card starting from the left
        for i in eachindex(hand1)
            if hand1[i] == hand2[i]
                continue
            else
                #println(hand1[i], " ", hand2[i])
                return hand1[i] < hand2[i]
            end
        end
    end
    return false
end

function solve(io; joker=false)

    hands = []
    bids = Int[]

    handdict = Dict{Char,Int}([
        'T' => 10,
        'J' => joker ? 1 : 11,
        'Q' => 12,
        'K' => 13,
        'A' => 14
    ])

    for line in eachline(io)
        h, b = split(line)

        hand = zeros(Int, 5)
        for i in eachindex(h)
            if isnumeric(h[i])
                hand[i] = parse(Int, h[i])
            else
                hand[i] = handdict[h[i]]
            end
        end
        bid = parse(Int, b)

        push!(hands, hand)
        push!(bids, bid)
    end
    ranks = sortperm(hands, lt=cardsort)

    total = 0
    for i in eachindex(bids)
        total += bids[ranks[i]] * i
    end

    total
end

part1 = solve("data/07in.txt")
part2 = solve("data/07in.txt"; joker=true)