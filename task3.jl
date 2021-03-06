include("help.jl")
function full_field_in_marks!(r::Robot) 
    num_vert = get_num_steps_movements!(r, Sud)
    num_hor = get_num_steps_movements!(r, West)
    #Мы в левом нижнем углу и помним наше число шагов

    side = Ost
    mark_row!(r,side) 
    putmarker!(r) 

    movements!(r,Sud)
    movements!(r, West)

    #Возвращение в первоначальную позицию
    movements!(r,Ost,num_hor)
    movements!(r,Nord,num_vert)
end

invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4)) 

function mark_row!(r::Robot,side::HorizonSide) #Движение змейкой
    while isborder(r,side) == false #По горизонтали
        putmarker!(r)
        move!(r,side)
    end
    if (isborder(r,Nord) == false) #По вертикали
        putmarker!(r)
        move!(r,Nord)
        side = invers(side::HorizonSide)
        mark_row!(r,side)
    end
end


function get_num_steps_movements!(r::Robot, side::HorizonSide) #пока нет стенки идем в направлении side и запоминаем кол-во шагов
    num_steps = 0
    while isborder(r, side) == false 
        move!(r,side)
        num_steps += 1
    end
    return num_steps
end

function movements!(r::Robot,side::HorizonSide) #Движение до стенки
    while isborder(r,side) == false
        move!(r,side)
    end
end
function movements!(r::Robot,side::HorizonSide,num_steps::Int) #возвращаемся на num_steps шагов
    for _ in 1:num_steps
        move!(r,side)
    end
end