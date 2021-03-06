include("help.jl")
function find_passage(r::Robot)
    side=Ost
    door_locator!(r,side)
end


inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))
function door_locator!(r::Robot,side::HorizonSide)
    n = 1
    while (isborder(r,Nord) == true)
    m = 0
            while (m != n)
                move!(r,side)
                m+=1 
            end
            n+=1
            side = invers(side)
    end
    
end

