clc;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms F x y e theta d s rf rb dF;

F = (x - e*sin(theta) - (d + s)*cos(theta))^2 + (y + e*cos(theta) - (d + s)*sin(theta))^2 -rf^2;
d = ((rb + rf)^2 -e^2)^(1/2);
dF = diff(F,theta);

for i = 1 : 1 : 3600
    theta2(i)=i*2*pi/3600;
end

eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);

