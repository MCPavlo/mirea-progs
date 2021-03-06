include("help.jl")
function perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)

    for side in (Nord, Ost, Sud, West)
        putmarkers!(r, side)
    end 

    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
end
