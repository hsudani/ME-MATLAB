clear;
clc;

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
theta= linspace(0,2*pi,360);
for i = 1:1:360
    theta(i) = double(i/180*pi);
end
%%% traditional way

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Rise¡G0~100                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:100
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
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Fall¡G190~300                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=191:300
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

for i=101:190
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

for i=301:360
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

figure;
plot(theta/(2*pi)*360,S,'LineWidth',2);
xlabel('\theta(deg)','fontname','Times New Roman','fontsize',20');
ylabel('S(\theta)(mm)','fontname','Times New Roman','fontsize',20');

figure;
plot(theta/(2*pi)*360,q,'LineWidth',2);
xlabel('\theta(deg)','fontname','Times New Roman','fontsize',20');
ylabel('V(mm/sec)','fontname','Times New Roman','fontsize',20');

figure;
plot(theta/(2*pi)*360,a,'LineWidth',2);
xlabel('\theta(deg)','fontname','Times New Roman','fontsize',20');
ylabel('a(m/sec^2)','fontname','Times New Roman','fontsize',20');

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Envelope method

XE1 = linspace(0,0,360);
YE1 = linspace(0,0,360);
XE2 = linspace(0,0,360);
YE2 = linspace(0,0,360);

syms se(th) ;
% % % for i = 1 : 1 : 360
% % %     theta(i)=i*2*pi/360;
% % % end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Envelope High Dwell¡G100~190               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se(th) = h;
[xf1(th), yf1(th), xf2(th), yf2(th)] = Envelope_roller_offset_function(se, th, rb, rf, e); %%%run the function
% X1 = double(subs(xf1, theta, th));
% Y1 = double(subs(yf1, theta, th));
% X2 = double(subs(xf2, theta, th));
% Y2= double(subs(yf2, theta, th));

for i=101:190
    
    XE1(i) = double(xf1(theta(i)));
    YE1(i) = double(yf1(theta(i)));
    XE2(i) = double(xf2(theta(i)));
    YE2(i) = double(yf2(theta(i)));
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Envelope Low Dwell¡G100~190                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se(th) = 0;
[xf1(th), yf1(th), xf2(th), yf2(th)] = Envelope_roller_offset_function(se, th, rb, rf, e); %%%run the function
% X1 = double(subs(xf1, theta, th));
% Y1 = double(subs(yf1, theta, th));
% X2 = double(subs(xf2, theta, th));
% Y2= double(subs(yf2, theta, th));

for i=301:360
    
    XE1(i) = double(xf1(theta(i)));
    YE1(i) = double(yf1(theta(i)));
    XE2(i) = double(xf2(theta(i)));
    YE2(i) = double(yf2(theta(i)));
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Envelope Rise¡G0~100                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

se(th) = h*th/beta-h/(2*pi)*sin(2*pi*th/beta);
[xf1(th), yf1(th), xf2(th), yf2(th)] = Envelope_roller_offset_function(se, th, rb, rf, e); %%%run the function
% X1 = double(subs(xf1, theta, th));
% Y1 = double(subs(yf1, theta, th));
% X2 = double(subs(xf2, theta, th));
% Y2= double(subs(yf2, theta, th));

for i=1:100
    XE1(i) = double(xf1(theta(i)));
    YE1(i) = double(yf1(theta(i)));
    XE2(i) = double(xf2(theta(i)));
    YE2(i) = double(yf2(theta(i)));
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Envelope Fall¡G190~300                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se(th) = h-(h*(th-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(th-theta_D)/(beta2)));
[xf1(th), yf1(th), xf2(th), yf2(th)] = Envelope_roller_offset_function(se, th, rb, rf, e); %%%run the function
% X1 = double(subs(xf1, theta, th));
% Y1 = double(subs(yf1, theta, th));
% X2 = double(subs(xf2, theta, th));
% Y2= double(subs(yf2, theta, th));

for i=191:300
    XE1(i) = double(xf1(theta(i)));
    YE1(i) = double(yf1(theta(i)));
    XE2(i) = double(xf2(theta(i)));
    YE2(i) = double(yf2(theta(i)));
        
end


figure;
hold on
plot(abs(XE1), abs(YE1));
plot(abs(XE2), abs(YE2));
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms SS(WOW)
rb = 40;
rf = 10;
SS(WOW) = (WOW);
[XXXA(WOW), YYYA(WOW), XXXS(WOW), YYYS(WOW)] = Envelope_roller_offset_function(SS, WOW, rb, rf,e ); %%%run the function
XXA = linspace(0,0,360);
YYA = linspace(0,0,360);
XXS = linspace(0,0,360);
YYS = linspace(0,0,360);
for i=1:360
%     XXA(i) = double(XXXA(theta(i)));
%     YYA(i) = double(YYYA(theta(i)));
%     XXS(i) = double(XXXS(theta(i)));
%     YYS(i) = double(YYYS(theta(i)));
%     XXA(i) = (XXXA(theta(i)));
%     YYA(i) = (YYYA(theta(i)));
%     XXS(i) = (XXXS(theta(i)));
%     YYS(i) = (YYYS(theta(i)));
    XXA(i) = (XXXA(theta(i)));
    YYA(i) = (YYYA(theta(i)));
    XXS(i) = (XXXS(theta(i)));
    YYS(i) = (YYYS(theta(i)));
        
end
syms F dF x y d ;
s(th) = h*th/beta-h/(2*pi)*sin(2*pi*th/beta);
d = ((rb+rf)^2 - e^2)^(1/2);
F(th) = (x - e*sin(th) - (d+s)*cos(th))^2 + (y + e*cos(th) - (d + s)*sin(th))^2 - rf^2;
dF(th) = diff(F(th),'th');
eqns = [F == 0, dF == 0];
SSS = solve(eqns, [x y]);
xxx1(th) = simplify(expand(SSS.x(1,1)));
yyy1(th) = simplify(expand(SSS.y(1,1)));
xxx2(th) = simplify(expand(SSS.x(2,1)));
yyy2(th) = simplify(expand(SSS.y(2,1)));

for i=1:360
    xx1(i) = (xxx1(theta(i)));
    yy1(i) = (yyy1(theta(i)));
    xx2(i) = (xxx2(theta(i)));
    yy2(i) = (yyy2(theta(i)));
        
end