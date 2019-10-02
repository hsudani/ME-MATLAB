function [x1,y1, x2, y2] = Envelope_roller_function(s, theta, rb, rf)
syms F dF x y;
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x1 = simplify(expand((S.x(1,1))));
y1 = simplify(expand((S.y(1,1))));
x2 = simplify(expand((S.x(2,1))));
y2 = simplify(expand((S.y(2,1))));


% syms x y rb rf theta s(theta) r;




