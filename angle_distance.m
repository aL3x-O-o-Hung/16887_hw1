function d=angle_distance(theta1,theta2)
d=abs(theta1-theta2);
if d>pi/2
    d=pi-d;
end
end