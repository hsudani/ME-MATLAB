clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rb = 40;
rf = 10;
syms s(theta);
% d = ((rb+rf)^2 - e^2)^(1/2);
s(theta) = theta;
r(theta) = rb + rf + s;

di(theta) = diff(s,'theta');
M(theta) = r(theta)*sin(theta) - di(theta)*cos(theta);
N(theta) = r(theta)*cos(theta) + di(theta)*sin(theta);
x21(theta) = r(theta)*cos(theta) + rf/(1 + (M(theta)/N(theta))^2)^(1/2);
y21(theta) = (x21(theta)*M(theta) + r(theta)*di(theta))/N(theta);
x22(theta) = r*cos(theta) - rf/(1 + (M/N)^2)^(1/2);
y22(theta) = (x22*M + r*di(theta))/N;

for i = 1:1:360
    th(i) = i/180*pi;
    XX(i) = x21(th(i));
    X(i) = double(XX(i));
    YY(i) = y21(th(i));
    Y(i) = double(YY(i));
    
    XX2(i) = x22(th(i));
    X2(i) = double(XX2(i));
    YY2(i) = y22(th(i));
    Y2(i) = double(YY2(i));
end

figure;
hold on
plot(X, Y);
plot(X2, Y2);
 