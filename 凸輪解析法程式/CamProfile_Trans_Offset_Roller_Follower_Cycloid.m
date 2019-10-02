clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          parameter input                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rb = 40;
e = 12;
rf = 10;
h = 20;

beta = 100/180*pi;
beta_2 = 110/180*pi;
theta_D = 190/180*pi;

for i = 1:1:3600
    theta(i) = i*2*pi/3600;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Rise: 0~100                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1: 1: 1000
    S(i) = h/pi*(pi*theta(i)/beta - 0.5*sin(2*pi*theta(i)/beta));
    L(i) = sqrt((rb + rf)^2 - e^2) + S(i);
    q(i) = h/pi*(pi/beta - pi/beta*cos(2*pi*theta(i)/beta));
    a(i) = h/pi*(2*pi^2/(beta^2)*sin(2*pi*theta(i)/beta));
    phi(i) = atan((q(i) - e)/L(i));
    
    X(i) = e*cos(theta(i) + pi/2) + L(i)*cos(theta(i)) + rf*cos(theta(i) + pi - phi(i));
    Y(i) = e*sin(theta(i) + pi/2) + L(i)*sin(theta(i)) + rf*sin(theta(i) + pi - phi(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         High Dwell: 100~190                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i= 1001: 1: 1900
    S(i) = h;
    L(i) = sqrt((rb + rf)^2 - e^2) + S(i);
    q(i) = 0;
    a(i) = 0;
    phi(i) = atan((q(i) - e)/L(i));
    
    X(i) = e*cos(theta(i) + pi/2) + L(i)*cos(theta(i)) + rf*cos(theta(i) + pi - phi(i));
    Y(i) = e*sin(theta(i) + pi/2) + L(i)*sin(theta(i)) + rf*sin(theta(i) + pi - phi(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Fall: 190~300                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i= 1900: 1: 3000
    S(i) = h - h/pi*(pi*(theta(i) - theta_D)/beta_2 - 0.5*sin(2*pi*(theta(i) - theta_D)/beta_2));
    L(i) = sqrt((rb + rf)^2 - e^2) + S(i);
    q(i) = - h/pi*(pi/beta_2 - pi/beta_2*cos(2*pi*(theta(i) - theta_D)/beta_2));
    a(i) = -h/pi*(2*pi^2/(beta_2^2)*sin(2*pi*(theta(i) - theta_D)/beta_2));
    phi(i) = atan((q(i) - e)/L(i));
    
    X(i) = e*cos(theta(i) + pi/2) + L(i)*cos(theta(i)) + rf*cos(theta(i) + pi - phi(i));
    Y(i) = e*sin(theta(i) + pi/2) + L(i)*sin(theta(i)) + rf*sin(theta(i) + pi - phi(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Low Dwell: 300~360                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i= 3000: 1: 3600
    S(i) = 0;
    L(i) = sqrt((rb + rf)^2 - e^2) + S(i);
    q(i) = 0;
    a(i) = 0;
    phi(i) = atan((q(i) - e)/L(i));
    
    X(i) = e*cos(theta(i) + pi/2) + L(i)*cos(theta(i)) + rf*cos(theta(i) + pi - phi(i));
    Y(i) = e*sin(theta(i) + pi/2) + L(i)*sin(theta(i)) + rf*sin(theta(i) + pi - phi(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Generate Contour Figure                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(theta/(2*pi)*360, S, 'LineWidth', 2);axis square
xlabel('\theta(deg)', 'fontname', 'Times New Roman', 'fontsize', 20);
ylabel('S(\theta)(mm)', 'fontname', 'Times New Roman', 'fontsize', 20);

figure;
plot(theta/(2*pi)*360, q, 'LineWidth', 2);axis square
xlabel('\theta(deg)', 'fontname', 'Times New Roman', 'fontsize', 20);
ylabel('V(\theta)(mm)', 'fontname', 'Times New Roman', 'fontsize', 20);

figure;
plot(theta/(2*pi)*360, a, 'LineWidth', 2);axis square
xlabel('\theta(deg)', 'fontname', 'Times New Roman', 'fontsize', 20);
ylabel('a(\theta)(mm)', 'fontname', 'Times New Roman', 'fontsize', 20);

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
plot(X, Y, 'LineWidth', 2);axis square
xlabel('X(mm)', 'fontname', 'Times New Roman', 'fontsize', 20);
ylabel('Y(mm)', 'fontname', 'Times New Roman', 'fontsize', 20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Generate Contour.scr                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%X = X';
%Y = Y';


for i = 1:1:360
    j = 10*(i - 1) + 1;
    XX(i) = X(j);
    YY(i) = Y(j);
end


fid = fopen('CamProfile_Trans_Offset_Roller_Follower_Cycloid.scr', 'w');
fprintf(fid,'spline ');
fprintf(fid,'%f,%f ', [XX; YY]);
fprintf(fid, 'close');
fclose(fid);
fclose('all');

