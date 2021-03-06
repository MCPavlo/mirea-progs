using HorizonSideRobots
export HorizonSide, HorizonSideRobots, Nord, Ost, Robot, Sud, West, isborder, ismarker, move!, putmarker!, save, show, show!, sitcreate, sitedit, sitedit!, temperature
next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) ###Разварот
function putmarkers!(r::Robot, side::HorizonSide)   ###МаркеровОчка пока нет стеки
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
function moves!(r::Robot, side::HorizonSide) ###счетчик 
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
function moves!(r::Robot,side::HorizonSide,num_steps::Int) #Обратно
    for _ in 1:numsteps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end
function movements!(r::Robot,side::HorizonSide,num_steps::Int) #Обратно2
    for _ in 1:num_steps
        move!(r,side)
    end
end

function movements!(r::Robot,side::HorizonSide) #Движение до стенки
    while isborder(r,side) == false
        move!(r,side)
    end
end
function moves!(r::Robot,side::HorizonSide)
    while move_if_possible!(r,side)
       
    end
end

movements!(r::Robot, side::HorizonSide) = while isborder(r,side)==false move!(r,side) end 

function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps += 1    
    end
    return num_steps
end

function through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while isborder(r,angle[1])==false || isborder(r,angle[2]) # Робот - не в юго-западном углу
        push!(num_steps, movements!(r, angle[2]))
        push!(num_steps, movements!(r, angle[1]))
    end
    return num_steps
end

function movements!(r,sides,num_steps::Vector{Int})
    for (i,n) in enumerate(num_steps)
        movements!(r, sides[mod(i-1, length(sides))+1], n)
    end
end

function through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while isborder(r,angle[1])==false || isborder(r,angle[2]) # Робот - не в юго-западном углу
        push!(num_steps, movements!(r, angle[2]))
        push!(num_steps, movements!(r, angle[1]))
    end
    return num_steps
end
function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next(direct_side)
    reverse_side = reverse(orthogonal_side)
    num_steps=0
    while isborder(r,direct_side) == true
        if isborder(r, orthogonal_side) == false
            move(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # direct_side
    if isborder(r,direct_side) == false
        while isborder(r,reverse_side) == true
            move!(r,direct_side)
        end
        result = true
    else
        result = false
    end
    move!(r,reverse_side)
    return result
end
function moves!(r::Robot,side::HorizonSide)
    possible, _ = move_if_possible!(r,side)
    while possible
        possible, _ = move_if_possible!(r,side)
    end
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next(direct_side)
    reverse_side = inverse(orthogonal_side)
    num_steps=0
    while isborder(r, direct_side) == true
        if !isborder(r, orthogonal_side)
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # direct_side
    if isborder(r,direct_side) == false
        move!(r,direct_side)
        if num_steps > 0
            while isborder(r,reverse_side) == true
                move!(r,direct_side)
            end
        end
        result = true
    else
        result = false
    end
    
    for _ in 1:num_steps
        move!(r, reverse_side)
    end

    return result
end
