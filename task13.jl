include("help.jl")
function mark_kross_x(r::Robot)
    for side in ((Nord,Ost),(Sud,Ost),(Sud,West),(Nord,West))
        while (isborder(r,side[1])==false && isborder(r,side[2])==false)
            move!(r,side[1])
            move!(r,side[2])
            putmarker!(r)
        end
        while (ismarker(r)==true)
            move!(r, inverse(side[1]))
            move!(r, inverse(side[2]))
        end
    end
    putmarker!(r)
end