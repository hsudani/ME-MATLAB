clc;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms x y t;
y = t^2 + 2*t + 1;
x = t+1;
eqns = [y == x];
S1 = solve(eqns, t);
syms a b theta;
F(a,b) = a^2 + b^2;
dF(a,b) = diff(a^2/2,a);
eqns2 = [F(a,b)==1 ,dF(a,b)==sin(theta)];
S2 = solve(eqns2, [a,b]);
