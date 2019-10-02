function [x1,y1, x2, y2] = Envelope_roller_offset_function(s, theta, rb, rf, e)
syms F dF x y d;
d = ((rb+rf)^2 - e^2)^(1/2);
F(theta) = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d + s)*sin(theta))^2 - rf^2;
dF(theta) = diff(F(theta),'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x1(theta) = simplify(expand(S.x(1,1)));
y1(theta) = simplify(expand(S.y(1,1)));
x2(theta) = simplify(expand(S.x(2,1)));
y2(theta) = simplify(expand(S.y(2,1)));





