clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



rb = 40; rf = 10; e = 12; h = 20; d = ((rb+rf)^2-e^2)^(1/2);
beta = 100 / 180 * pi;
beta2 = 110 / 180 * pi;
theta_D = (190 / 180) * pi;

for i = 1 : 1 : 3600
    theta(i)=i*2*pi/3600;
end
for i=1:1000
    s(i) = h*theta(i)/beta-h/(2*pi)*sin(2*pi*theta(i)/beta);
end
for i=1001:1900
    s(i)=h;
end
 for i=1901:3000
    s(i)=h-(h*(theta(i)-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(theta(i)-theta_D)/(beta2)));
 end
 for i=3001:3600
    s(i)=0;
 end


Figure
plot (x,y1);
 