clear;
clc;
close all; 

a = 1.5;
b = 2;

u = @(t)(3*cos(2*t));
t= 0:0.01:60;

%% Find optimal gamma 
g = [1,5,10,20,30];
am = 6;

for i = 1:length(g)
odefun = @(t,x) [-a*x(1)+b*u(t);
                g(i)*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(4);
                g(i)*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(5);
                -am*x(4)+x(1);
                -am*x(5)+u(t);
                -am*x(6) + x(2)*x(6) + x(3)*u(t)];
[t,x] = ode45(odefun,t,[0,0,0,0,0,0]);

x_real = x(:,1);
x_pred = x(:,6);
e = x_pred - x_real;

figure()
plot(t,e)
xticks(0:5:60)
grid on;
title(['e = x - $\hat{x}$ for gamma=', num2str(g(i))],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
ylabel('e = x - $\hat{x}$','interpreter','latex','FontSize',15);
end

%% Find optimal am
g = 20;
am = [1,2,5];

for i = 1:length(am)
odefun = @(t,x) [-a*x(1)+b*u(t);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(4);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(5);
                -am(i)*x(4)+x(1);
                -am(i)*x(5)+u(t);
                -am(i)*x(6) + x(2)*x(6) + x(3)*u(t)];
[t,x] = ode45(odefun,t,[0,0,0,0,0,0]);

a_pred = am(i) - x(:,2);
b_pred = x(:,3);

subplot(3,1,i)
hold on
plot(t,a_pred);
plot(t,b_pred,'-r');
yline(1.5,'--b');
yline(2,'--r');
hold off;
grid on;
xticks(0:5:60)
title(['$\hat{a}$ and $\hat{b}$ for $a_{m}$=', num2str(am(i))],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$\hat{a}$','$\hat{b}$','$a_{real}$','$b_{real}$','interpreter','latex');
end
% saveas(gcf, "g=" + g + "_am=1,2,5.pdf");

%% Estimate parameters using the gradient method
g = 20;
am = 2;

odefun = @(t,x) [-a*x(1)+b*u(t);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(4);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(5);
                -am*x(4)+x(1);
                -am*x(5)+u(t);
                -am*x(6) + x(2)*x(6) + x(3)*u(t)];
[t,x] = ode45(odefun,t,[0,0,0,0,0,0]);

a_pred = am - x(:,2);
b_pred = x(:,3);
x_real = x(:,1);
x_pred = x(:,6);
e = x_real - x_pred;

% plot x and the prediction of x using the gradient method
figure()
hold on;
plot(t,x_real);
plot(t,x_pred);
hold off;
grid on;
xticks(0:5:60)
title(['Plot of $x$ and $\hat{x}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x$','$\hat{x}$','interpreter','latex');
%saveas(gcf, "g=" + g + "_am=" + am + "_1.pdf");

% plot a and b and their predictions
figure()
hold on
plot(t,a_pred);
plot(t,b_pred,'-r');
yline(1.5,'--b');
yline(2,'--r');
hold off;
grid on;
xticks(0:5:60)
title(['$\hat{a}$ and $\hat{b}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$\hat{a}$','$\hat{b}$','$a_{real}$','$b_{real}$','interpreter','latex');
%saveas(gcf, "g=" + g + "_am=" + am + "_2.pdf");

%plot e = x - x_pred
figure()
plot(t,e)
xticks(0:5:60)
grid on;
title(['e = x - $\hat{x}$'],'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
ylabel('e = x - $\hat{x}$','interpreter','latex','FontSize',15);
%saveas(gcf, "g=" + g + "_am=" + am + "_3.pdf");

