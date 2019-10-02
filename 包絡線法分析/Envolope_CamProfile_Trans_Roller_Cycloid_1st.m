clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rb = 40;
rf = 10;
syms s(theta);  
beta = pi;
h = 20;
% d = ((rb+rf)^2 - e^2)^(1/2);
s(theta) = h*theta/beta-h/(2*pi)*sin(2*pi*theta/beta); %% any function of s
%s = theta;
r = rb + rf + s;
[x11(theta), y11(theta), x12(theta), y12(theta)] = Envelope_roller_function(s, theta, rb, rf);
%[x21, y21, x22, y22] = Envelope_roller_function(s, theta, rb, rf);

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


BBB = linspace(1,3600,3600);

for i=3001:3600

    error[i] =  X(i)-
end
