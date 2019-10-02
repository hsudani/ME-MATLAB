clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms s theta rb rf e;
s(theta) = sin(theta); %% any function of s
[xf1(theta), yf1(theta), xf2(theta), yf2(theta)] = Envelope_roller_offset_function(s, theta, rb, rf, e); %%%run the function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@@ text book answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms M N d;
d = ((rb+rf)^2 - e^2)^(1/2);
U = (d+s)*sin(theta)-(e+diff(s,theta))*cos(theta);
V = (d+s)*cos(theta)+(e+diff(s,theta))*sin(theta);
xt1 = e*sin(theta)+(d+s)*cos(theta)+rf/(1 + (U/V)^2)^(1/2);
xt2 = e*sin(theta)+(d+s)*cos(theta)-rf/(1 + (U/V)^2)^(1/2);
yt1 = (xt1*U + (d+s)*diff(s,'theta'))/V;
yt2 = (xt2*U + (d+s)*diff(s,'theta'))/V;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% check whether the function is right
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms x y;
d = ((rb+rf)^2 - e^2)^(1/2);
F = (x - e*sin(theta) - (d+s)*cos(theta))^2 + (y + e*cos(theta) - (d + s)*sin(theta))^2 - rf^2;
dF = diff(F,'theta');
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
xcf1 = simplify(S.x(1,1));
ycf1 = simplify(S.y(1,1));
xcf2 = simplify(S.x(2,1));
ycf2 = simplify(S.y(2,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@@ draw the cam profile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% t = linspace(0,2*pi,500);
% 
% xdraw = subs(x, rb, 40);
% xdraw = subs(x, rf, 10);
% xdraw = subs(x, theta, t);
% 
% ydraw = subs(y, rb, 40);
% ydraw = subs(y, rf, 10);
% ydraw = subs(y, theta, t);
% 
% figure
% plot(xdraw,ydraw);



 