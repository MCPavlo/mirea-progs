include("help.jl")
STEP = 0

function frame_perimetr!(r::Robot)
    path = leftDown(r) 

    putmarker!(r)
    putmarkers!(r, Nord)
    putmarker!(r)
    putmarkers!(r, Ost)
    putmarker!(r)
    putmarkers!(r, Sud)
    putmarker!(r)
    putmarkers!(r, West)
    leftDown!(r, path) 
end

function leftDown(r::Robot)
    path = []
    while isborder(r, West) == false || isborder(r, Sud) == false
          if isborder(r, West) == false
                move!(r, West)
                push!(path, true)
          else
                move!(r, Sud)
                push!(path, false)
          end
    end
    
    return reverse!(path)
end


function leftDown!(r::Robot, path)
    for i in path
          if i move!(r, Ost)
          else move!(r, Nord)
          end
    end
end


