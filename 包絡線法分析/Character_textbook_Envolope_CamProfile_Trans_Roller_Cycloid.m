clc;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% syms F(x, y, r, s, theta); 
% syms dF(x, y, r, s, theta); 
syms F dF r x y;
syms F1 dF1 xs ys;
syms rf rb;
syms s(theta);
syms x1 x2 x3 x4 y1 y2 y3 y4;
syms h beta beta2 theta_D e;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  rise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = h*theta/beta-h/(2*pi)*sin(2*pi*theta/beta);
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x1 = simplify(S.x);
y1 = simplify(S.y);

F1 = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF1 = diff(F,theta);
eqns1 = [F1 == 0, dF1 == 0];
S = solve(eqns1, [x y]);
xs = simplify(S.x);
ys = simplify(S.y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  HIGH dwell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=h;
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x2 = simplify(S.x);
y2 = simplify(S.y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  fall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=h-(h*(theta-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(theta-theta_D)/(beta2)));
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x3 = simplify(S.x);
y3 = simplify(S.y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  HIGH dwell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=0;
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
x4 = simplify(S.x);
y4 = simplify(S.y);

% r = rb + rf + s;
% F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
% dF = diff(F, theta);
% eqns = [F == 0, dF == 0];
% S = solve(eqns, [x y]);
% 
% syms a b M N;
% a = r*cos(theta) ;
