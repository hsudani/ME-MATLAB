clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rb = 40;
rf = 10;
syms s(theta);  
% d = ((rb+rf)^2 - e^2)^(1/2);
s = theta;
r = rb + rf + s;
[x11(theta), y11(theta), x12(theta), y12(theta)] = Envelope_roller_function(s, theta, rb, rf);
[x21, y21, x22, y22] = Envelope_roller_function(s, theta, rb, rf);

%plot

for i = 1:1:360
    th(i) = i/180*pi;
    XX(i) = x11(th(i));
    X(i) = double(XX(i));
    YY(i) = y11(th(i));
    Y(i) = double(YY(i));
end


figure;
plot(X, Y);
 