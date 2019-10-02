clc;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


syms F dF r x y;
syms rf rb d;
syms s(theta);
syms x1 x2 x3 x4 y1 y2 y3 y4;
syms h beta beta2 theta_D e;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  rise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = h*theta/beta-h/(2*pi)*sin(2*pi*theta/beta);
d = ((rb+rf)^2 - e^2)^(1/2);
F = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d+s)*sin(theta))^2 -rf^2;
dF = diff(F,'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x1 = simplify(S.x(1,1));
y1 = simplify(S.y(1,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  HIGH dwell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=h;
d = ((rb+rf)^2 - e^2)^(1/2);
F = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d+s)*sin(theta))^2 -rf^2;
dF = diff(F,'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x2 = simplify(S.x);
y2 = simplify(S.y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  fall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=h-(h*(theta-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(theta-theta_D)/(beta2)));
d = ((rb+rf)^2 - e^2)^(1/2);
F = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d+s)*sin(theta))^2 -rf^2;
dF = diff(F,'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x3 = simplify(S.x);
y3 = simplify(S.y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  LOW dwell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=0;
d = ((rb+rf)^2 - e^2)^(1/2);
F = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d+s)*sin(theta))^2 -rf^2;
dF = diff(F,'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x4 = simplify(S.x);
y4 = simplify(S.y);


