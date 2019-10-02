clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms s theta ;
rb = 40;
rf = 10;
%%rb rf;
s = theta;
%%s = sin(theta); %% any function of s

[xf1, yf1, xf2, yf2] = Envelope_roller_function(s, theta, rb, rf); %%%run the function


for i = 1:1:360
    th(i) = i/180*pi;
end
XX = subs(xf1, theta, th);
X = double(XX);
YY = subs(yf1, theta, th);
Y = double(YY);
figure;
plot(X, Y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@@ text book answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms M N;
r = rb + rf + s;
M = r*sin(theta) - diff(s,'theta')*cos(theta);
N = r*cos(theta) - diff(s,'theta')*sin(theta);
xt = r*cos(theta) + rf/(1 + (M/N)^2)^(1/2);
yt = (xt*M + r*diff(s,'theta'))/N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% check whether the function is right
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms x y;
r = rb + rf + s;
F = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dF = diff(F,theta);
eqns = [F == 0, dF == 0];
S = solve(eqns, [x y]);
xcf1 = simplify(S.x(1,1));
ycf1 = simplify(S.y(1,1));
xcf2 = simplify(S.x(2,1));
ycf2 = simplify(S.y(2,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@@ check text book answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms FF dFF;
FF = (x - r*cos(theta))^2 + (y - r*sin(theta))^2 - rf^2;
dFF = 2*r*sin(theta)*(x-r*cos(theta))-2*r*cos(theta)*(y-r*sin(theta));
eqns2 = [FF == 0, dFF == 0];
S2 = solve(eqns2, [x y]);
xct1 = simplify(S2.x(1,1));
yct1 = simplify(S2.y(1,1));
xct2 = simplify(S2.x(2,1));
yct2 = simplify(S2.y(2,1));



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



 