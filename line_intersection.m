function [x,y]=line_intersection(k1,k2,b1,b2)
x=(b2-b1)/(k1-k2);
y=k1*x+b1;
end