
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

for i = 1 : 1 : 3600
    theta(i)=i*2*pi/3600;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Rise¡G0~100                                %
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Generate contour.scr                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = X';
Y = Y';

fid = fopen('CamProfile_Trans_Flat_Face_Cycloid.scr','w');
fprintf(fid,'spline ');
fprintf(fid,'%f,%f ', [X; Y]);
fclose(fid);
