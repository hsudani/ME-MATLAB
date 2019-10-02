clc;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


syms X Y x y r m n t l;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F = [x^2 + (y-c)^2]^2 - [x^2 - (y-c)^2]*b^2;
% [x;y] == inv([cos(t) -sin(t); sin(t) cos(t)])*[[X;Y] - [-r * cos(t);0]];
x = r*(cos(t))^2 + (X*cos(t)) + (Y*sin(t));
y = (Y*cos(t)) - (X*sin(t)) - r*cos(t)*sin(t);

F = l*x + m*y + n;
dF = diff(F,'t');


eqns = [F == 0, dF == 0];
S = solve(eqns, [X Y]);
x1 = simplify(S.X);
y1 = simplify(S.Y);
x1 = subs(x1, r, 8);
x1 = subs(x1, l, 1);
x1 = subs(x1, m, 2);
x1 = subs(x1, n, -3);

y1 = subs(y1, r, 8);
y1 = subs(y1, l, 1);
y1 = subs(y1, m, 2);
y1 = subs(y1, n, -3);

Z = -[n*l*cos(t) - m*n*sin(t) + 2*l^2*r*cos(t) - l^2*r*(cos(t))^3+ m^2*r*(cos(t))^3 - l*m*r*sin(t) + 2*l*m*r*(cos(t))^2*sin(t)]/(l^2+m^2);
T = -[m*n*cos(t) + n*l*sin(t) - m^2*r*sin(t) + 2*l*m*r*cos(t) %+ l^2*r*(cos(t))^2*sin(t) + m^2*r*(cos(t))^2*sin(t) - 2*l*m*r*(cos(t))^3]/(l^2+m^2);
%%%%%%%
Z = subs(Z, r, 8);
Z = subs(Z, l, 1);
Z = subs(Z, m, 2);
Z = subs(Z, n, -3);

T = subs(T, r, 8);
T = subs(T, l, 1);
T = subs(T, m, 2);
T = subs(T, n, -3);

theta = linspace(0,2*pi,500);
x2 = subs(x1, t, theta);
y2 = subs(y1, t, theta);
Z = subs(Z, t, theta);
T = subs(T, t, theta);
figure
plot(x2,y2);
figure
plot(Z,T);


