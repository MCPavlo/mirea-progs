include("help.jl")
function stairs!(r) #Главная функция
    movements!(r,Sud)
    movements!(r,West)
    #Мы в левом нижнем углу

    
    side = Ost
    num_hor = moves!(r,side) 
    movements!(r,West) 
    mark_up!(r,num_hor) 
end

function mark_up!(r::Robot,size::Int)
    i = 0
    while (1 <= size) 
        for _ in 1:size 
            move!(r,Ost)
            putmarker!(r)
        end
        if (isborder(r,West) == false) 
            movements!(r,West)
            putmarker!(r)
        end
        if (isborder(r,Nord) == false) 
        move!(r,Nord)
        size = size - 1
        else
            break
        end
    end
end