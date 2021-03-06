include("help.jl")
function mark_angles(r)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West) == false # Робот - не в юго-западном углу
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end
    #Робот - в юго-западном углу и в num_steps - закодирован пройденный путь
    for side in (Nord,Ost,Sud,West)
        movements!(r,side)
        putmarker!(r)
    end
    # Маркеры поставлены и Робот - в юго-западном углу

    for (i,n) in enumerate(num_steps) 
        side = isodd(i) ? Ost : Nord 
        movements!(r,side,n)
    end
    # Робот - в исходном положении
end