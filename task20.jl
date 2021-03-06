include("help.jl")
function count_hor_borders(r::Robot)::Int
    moves!(r, Sud)
    moves!(r, West)

    count = 0
    side = Ost

    while !isborder(r, Nord)
        move!(r, side)
        is_hor_border = false

        while !isborder(r, side)
            if isborder(r, Nord) && !is_hor_border
                count += 1
                is_hor_border = true
            elseif !isborder(r, Nord)
                is_hor_border = false
            end

            move!(r, side)
        end

        side = inverse(side)
        move!(r, Nord)
    end

    return count
end





