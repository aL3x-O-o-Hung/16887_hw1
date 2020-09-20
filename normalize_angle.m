function lines=normalize_angle(lines)
for i=1:size(lines,1)
    angle=lines(i,5);
    if angle<0
        angle=angle+2*pi;
    end
    if 0<=angle && pi>angle
        lines(i,5)=angle;
        continue
    else
        lines(i,5)=angle-pi;
    end
end
