clc;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


syms F dF r x y;
syms rf rb d;
syms s(theta);
% syms x1 x2 x3 x4 y1 y2 y3 y4;
syms x11 x12 x21 x22 x31 x32 x41 x42 y11 y12 y21 y22 y31 y32 y41 y42;
syms h beta beta2 theta_D e;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  rise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s = h*theta/beta-h/(2*pi)*sin(2*pi*theta/beta);
s = sin(theta);
[x11,y11, x12, y12] = Envelope_roller_offset_function(s, theta, rb, rf, e);

d = [(rb+rf)^2 - e^2]^(1/2);
U = (d+s)*sin(theta) - (e+diff(s,'theta'))*cos(theta);
V = (d+s)*cos(theta) + (e+diff(s,'theta'))*sin(theta);

x41 = e*sin(theta) + (d+s)*cos(theta)+rf/(1+(U/V)^2)^(1/2);
x42 = e*sin(theta) + (d+s)*cos(theta)-rf/(1+(U/V)^2)^(1/2);
y41 = (x41*U + (d+s)*diff(s,'theta'))/V;
y42 = (x42*U + (d+s)*diff(s,'theta'))/V;
