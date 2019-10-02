    
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Xse1 Xse2 solution of Envelope
%%% Xst1 Xst2 soluiton of textbook
%%% Xsc1 Xsc2 solution of calculating

% syms s theta rb rf e;
% s(theta) = sin(theta); %% any function of s
% [xf1(theta), yf1(theta), xf2(theta), yf2(theta)] = Envelope_roller_offset_function(s, theta, rb, rf, e); %%%run the function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@@ text book answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% syms M N d;
% d = ((rb+rf)^2 - e^2)^(1/2);
% U = (d+s)*sin(theta)-(e+diff(s,theta))*cos(theta);
% V = (d+s)*cos(theta)+(e+diff(s,theta))*sin(theta);
% xt1 = e*sin(theta)+(d+s)*cos(theta)+rf/(1 + (U/V)^2)^(1/2);
% xt2 = e*sin(theta)+(d+s)*cos(theta)-rf/(1 + (U/V)^2)^(1/2);
% yt1 = (xt1*U + (d+s)*diff(s,'theta'))/V;
% yt2 = (xt2*U + (d+s)*diff(s,'theta'))/V;
% 

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% clear;
% clc;
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              parameter input                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rb = 40; 
rf = 10;
h = 20; 
beta = 100 / 180 * pi;
beta2 = 110 / 180 * pi;
theta_D = (190 / 180) * pi;
e = 12;

for i = 1 : 1 : 360
    theta(i)=i*2*pi/360;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  envelope  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms s t ;
%%% rb rf e;
%%% rise
s(t) = h*t/beta-h/(2*pi)*sin(2*pi*t/beta); %% any function of s
[xf1(t), yf1(t), xf2(t), yf2(t)] = Envelope_roller_offset_function(s, t, rb, rf, e); %%%run the function
for i=1:100
    xF1(i) = xf1(theta(i));
    XF1(i) = double(xF1(i));
    xF2(i) = xf2(theta(i));
    XF2(i) = double(xF2(i));
    yF1(i) = yf1(theta(i));
    YF1(i) = double(yF1(i));
    YF2(i) = yf2(theta(i)); 
    YF2(i) = double(yf2(i)); 
end
%%%% fall
s(t) = h-(h*(t-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(t-theta_D)/(beta2))); %% any function of s
[xf1(t), yf1(t), xf2(t), yf2(t)] = Envelope_roller_offset_function(s, t, rb, rf, e); %%%run the function
for i=191:300
    xF1(i) = xf1(theta(i));
    XF1(i) = double(xF1(i));
    xF2(i) = xf2(theta(i));
    XF2(i) = double(xF2(i));
    yF1(i) = yf1(theta(i));
    YF1(i) = double(yF1(i));
    yF2(i) = yf2(theta(i)); 
    YF2(i) = double(yF2(i)); 
end
%%% high dwell
s(t) = h; %% any function of s
[xf1(t), yf1(t), xf2(t), yf2(t)] = Envelope_roller_offset_function(s, t, rb, rf, e); %%%run the function
for i=101:190
    xF1(i) = xf1(theta(i));
    XF1(i) = double(xF1(i));
    xF2(i) = xf2(theta(i));
    XF2(i) = double(xF2(i));
    yF1(i) = yf1(theta(i));
    YF1(i) = double(yF1(i));
    yF2(i) = yf2(theta(i)); 
    YF2(i) = double(yF2(i)); 
end
%%% low dwell
s(t) = 0; %% any function of s
[xf1(t), yf1(t), xf2(t), yf2(t)] = Envelope_roller_offset_function(s, t, rb, rf, e); %%%run the function
for i=301:360
    xF1(i) = (xf1(theta(i)));
    XF1(i) = double(xF1((i)));
    xF2(i) = (xf2(theta(i)));
    XF2(i) = double(xF2((i)));
    yF1(i) = (yf1(theta(i)));
    YF1(i) = double(yF1((i)));
    yF2(i) = (yf2(theta(i))); 
    YF2(i) = double(yF2((i))); 
end

figure;
hold on
plot(abs(XF1),abs(YF1));
plot(abs(XF2),abs(YF2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Rise:0~100                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1000
    S(i) = h*theta(i)/beta-h/(2*pi)*sin(2*pi*theta(i)/beta);
    L(i) = sqrt((rb+rf)^2-e^2)+S(i);
    q(i) = h/beta-h/beta*cos(2*pi*theta(i)/beta);
    a(i) = 2*pi*h/(beta^2)*sin(2*pi*theta(i)/beta);
    phi(i) = atan((q(i)-e)/L(i));
    O2Ex(i) = e*cos(theta(i)+pi/2);
    O2Ey(i) = e*sin(theta(i)+pi/2);
    ECx(i) = L(i)*cos(theta(i));
    ECy(i) = L(i)*sin(theta(i));
    CAx(i) = rf*cos(theta(i)+pi-phi(i));
    CAy(i) = rf*sin(theta(i)+pi-phi(i));
    
    X(i) = O2Ex(i) + ECx(i) + CAx(i);
    Y(i) = O2Ey(i) + ECy(i) + CAy(i);
    
    XF1(i) = xf1(theta(i));
    XF2(i) = xf2(theta(i));
    YF1(i) = yf1(theta(i));
    YF2(i) = yf2(theta(i));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Fall¡G190~300                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1901:3000
    S(i)=h-(h*(theta(i)-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(theta(i)-theta_D)/(beta2)));
    q(i)=-((h/(beta2)-h/(beta2)*cos(2*pi*(theta(i)-theta_D)/(beta2))));
    a(i)=-2*pi*h/((beta2)^2)*sin(2*pi*(theta(i)-theta_D)/(beta2));
    L(i) = sqrt((rb+rf)^2-e^2)+S(i);
    phi(i) = atan((q(i)-e)/L(i));
    O2Ex(i) = e*cos(theta(i)+pi/2);
    O2Ey(i) = e*sin(theta(i)+pi/2);
    ECx(i) = L(i)*cos(theta(i));
    ECy(i) = L(i)*sin(theta(i));
    CAx(i) = rf*cos(theta(i)+pi-phi(i));
    CAy(i) = rf*sin(theta(i)+pi-phi(i));
    
    X(i) = O2Ex(i) + ECx(i) + CAx(i);
    Y(i) = O2Ey(i) + ECy(i) + CAy(i);
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           High Dwell¡G100~190                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1001:1900
    S(i)=h;
    L(i) = sqrt((rb+rf)^2-e^2)+S(i);
    q(i)=0;
    a(i)=0;
    phi(i) = atan((q(i)-e)/L(i));
    O2Ex(i) = e*cos(theta(i)+pi/2);
    O2Ey(i) = e*sin(theta(i)+pi/2);
    ECx(i) = L(i)*cos(theta(i));
    ECy(i) = L(i)*sin(theta(i));
    CAx(i) = rf*cos(theta(i)+pi-phi(i));
    CAy(i) = rf*sin(theta(i)+pi-phi(i));
    
    X(i) = O2Ex(i) + ECx(i) + CAx(i);
    Y(i) = O2Ey(i) + ECy(i) + CAy(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Low Dwell¡G 300~360                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=3001:3600
    S(i)=0;
    L(i) = sqrt((rb+rf)^2-e^2)+S(i);
    q(i)=0;
    a(i)=0;
    phi(i) = atan((q(i)-e)/L(i));
    O2Ex(i) = e*cos(theta(i)+pi/2);
    O2Ey(i) = e*sin(theta(i)+pi/2);
    ECx(i) = L(i)*cos(theta(i));
    ECy(i) = L(i)*sin(theta(i));
    CAx(i) = rf*cos(theta(i)+pi-phi(i));
    CAy(i) = rf*sin(theta(i)+pi-phi(i));
    
    X(i) = O2Ex(i) + ECx(i) + CAx(i);
    Y(i) = O2Ey(i) + ECy(i) + CAy(i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Generate contour figure                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figute;
plot(XF1,YF1);
plot(XF2,YF2);
    
figure;
hold on 
plot([4,4],[-8,0],'LineWidth',2)
plot([-4,-4],[-8,0],'LineWidth',2)
plot([-8,8],[-8,-8],'LineWidth',2)
plot([-8,-4],[-11,-8],'LineWidth',2)
plot([-4,0],[-11,-8],'LineWidth',2)
plot([0,4],[-11,-8],'LineWidth',2)
plot([4,8],[-11,-8],'LineWidth',2)
plot(4.*cos(0 : 0.01 : 2*pi) , 4.*sin( 0: 0.01 : 2*pi),'LineWidth',2);
plot(2.5.*cos(0 : 0.01 : 2*pi) , 2.5.*sin( 0: 0.01 : 2*pi),'LineWidth',2);

plot(X,Y,'LineWidth',2);axis square
xlabel('X','fontname','Times New Roman','fontsize',20');
ylabel('Y','fontname','Times New Roman','fontsize',20');
title('cam profiles','fontname','Times New Roman','fontsize',20');

