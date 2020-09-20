function angle=angle_average(angles)
summ=angles(1);
for i=2:size(angles,2)
    temp=summ/(i-1);
    if abs(temp-angles(i))<=pi/2
        summ=summ+angles(i);
    else
        if temp>pi/2
            summ=summ+angles(i)+pi;
        else
            summ=summ+angles(i)-pi;
        end
    end
end
angle=summ/size(angles,2);
if angle<0
    angle=angle+2*pi;
end
if angle>=pi
    angle=angle-pi;
end
end