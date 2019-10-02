
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              parameter input                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rb = 40; 
h = 24; 
beta = 120 / 180 * pi;
beta2 = 130 / 180 * pi;
theta_D = (170 / 180) * pi;

for i = 1 : 1 : 3600        %一度分成十格，換算成弧度
    theta(i)=i*2*pi/3600;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Rise：0~120                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1200    
    S(i)=h*theta(i)/beta-h/(2*pi)*sin(2*pi*theta(i)/beta);  %擺線的公式
    L(i)=rb+S(i);
    q(i)=h/beta-h/beta*cos(2*pi*theta(i)/beta);
    a(i)=2*pi*h/(beta^2)*sin(2*pi*theta(i)/beta);
    X(i)=L(i)*cos(theta(i))-q(i)*sin(theta(i));
    Y(i)=L(i)*sin(theta(i))+q(i)*cos(theta(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Fall：190~310                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1701:3000
    S(i)=h-(h*(theta(i)-theta_D)/(beta2)-h/(2*pi)*sin(2*pi*(theta(i)-theta_D)/(beta2)));
    L(i)=rb+S(i);
    q(i)=-((h/(beta2)-h/(beta2)*cos(2*pi*(theta(i)-theta_D)/(beta2))));
    a(i)=-2*pi*h/((beta2)^2)*sin(2*pi*(theta(i)-theta_D)/(beta2));
    X(i)=L(i)*cos(theta(i))-q(i)*sin(theta(i));
    Y(i)=L(i)*sin(theta(i))+q(i)*cos(theta(i));
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             High Dwell：120~190                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1201:1700
    S(i)=h;
    L(i)=rb+S(i);
    q(i)=0;
    a(i)=0;
    X(i)=L(i)*cos(theta(i))-q(i)*sin(theta(i));
    Y(i)=L(i)*sin(theta(i))+q(i)*cos(theta(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Low Dwell： 300~360                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=3001:3600
    S(i)=0;
    L(i)=rb+S(i);
    q(i)=0;
    a(i)=0;
    X(i)=L(i)*cos(theta(i))-q(i)*sin(theta(i));
    Y(i)=L(i)*sin(theta(i))+q(i)*cos(theta(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Generate contour figure                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(theta/(2*pi)*360,S,'LineWidth',2);   %畫圖，把theta換回角度
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
%{
figure;   好像是我自己複製的?反正不重要
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
%}

figure;
hold on   %畫地桿的那個符號
plot([4,4],[-8,0],'LineWidth',2)
plot([-4,-4],[-8,0],'LineWidth',2)
plot([-8,8],[-8,-8],'LineWidth',2)
plot([-8,-4],[-11,-8],'LineWidth',2)
plot([-4,0],[-11,-8],'LineWidth',2)
plot([0,4],[-11,-8],'LineWidth',2)
plot([4,8],[-11,-8],'LineWidth',2)
plot(4.*cos(0 : 0.01 : 2*pi) , 4.*sin( 0: 0.01 : 2*pi),'LineWidth',2);
plot(2.5.*cos(0 : 0.01 : 2*pi) , 2.5.*sin( 0: 0.01 : 2*pi),'LineWidth',2);
plot(X,Y,'LineWidth',2);axis square   %畫輪廓
xlabel('X','fontname','Times New Roman','fontsize',20');
ylabel('Y','fontname','Times New Roman','fontsize',20');
title('cam profiles','fontname','Times New Roman','fontsize',20');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Generate contour.scr                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = X';  %矩陣行列互換
Y = Y';

%這裡其實沒辦法畫到3600個點。autocad可以但是inventor會爆掉，試著自己取點看看?

fid = fopen('CamProfile_Trans_Flat_Face_Cycloid.scr','w'); %開檔
fprintf(fid,'spline '); %寫檔
fprintf(fid,'%f,%f ', [X; Y]);
fclose(fid); %關檔
