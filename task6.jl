include("help.jl")
function thecallofthemountain(r::Robot)
    steps_up = moves!(r,Nord) #вверх
    steps_left = moves!(r,West) #влево
    steps_down = moves!(r,Sud) #вниз 
    


    #Робот - в юго-западном углу и в num_steps - закодирован пройденный путь
    side = Nord
    snake!(r,side) #Двигаемся змейкой

   moves!(r,West)
   moves!(r,Sud)

   movements!(r,Nord, steps_down)
   movements!(r,Ost,steps_left)
   movements!(r,Sud,steps_up)
   # Робот - в исходном положении
end

function snake!(r::Robot, side::HorizonSide)
    fl = false
    while (isborder(r,side) == false) #Если сверху или снизу нет стенки идем туда
        if (isborder(r,Ost)==true) #Если справа стенка
            fl = true
            break
        else #Если стенки нет
            move!(r,side)
        end
    end
    if (fl == false)
        move!(r,Ost)
        side = invers(side)
        snake!(r,side) #Рекурсия
    else
        
        side = Ost
        for way in (Nord, Ost, Sud, West)
            while isborder(r, side) == true && ismarker(r) == false
                putmarker!(r)
                move!(r,way)
            end
            putmarker!(r)
            move!(r,side)
            side = HorizonSide(mod(Int(side) - 1,4))
        end
        putmarker!(r)
    end
end