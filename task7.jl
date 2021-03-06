include("help.jl")
  function chess!(r::Robot)
    num_hor = moves!(r,West)
    num_vert = moves!(r,Sud)
   #Левый нижний угол
   side = Ost
   if ((num_hor % 2) == 0) #если слево расстояние четна
       if ((num_vert % 2) == 0) # если вертикаль четна
           putmarks2!(r,side)
       else # если вертикаль не четна
           putmarks1!(r,side)
       end
   else
       putmarks1!(r,side)
   end
   #алгоритм - выполнен
   movements!(r,West)
   movements!(r,Sud)
   movements!(r,Ost,num_hor)
   movements!(r,Nord,num_vert)
end
function putmarks1!(r::Robot,side::HorizonSide)
   movements!(r,inverse(side))
   move!(r,side)
   while isborder(r,side) == false        
       putmarker!(r)
       for _ in 1:2
           if (isborder(r,side) == false)
               move!(r,side)
           else
               if (isborder(r,Nord) == fasle)
                   move!(r,Nord)
                   side = inverse(side)
                   move!(r,side)
               end
           end
       end
   end
   putmarker!(r)
   if (isborder(r,Nord) == false)
       move!(r,Nord)
       putmarks2!(r,Ost)
   end
end
function putmarks2!(r::Robot,side::HorizonSide)
   movements!(r,inverse(side))
   while isborder(r,side) == false
       putmarker!(r)
       for _ in 1:2
           if (isborder(r, side) == false)
               move!(r,side)
           else
               if (isborder(r,Nord) == false)
                   move!(r,Nord)
                   side = inverse(side)
               end
           end
       end
   end
end
