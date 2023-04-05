clear;
clc;
close all; 

%% Calculate system output 
m = 10;
b = 0.3;
k = 1.5;
u = @(t) 10*sin(3*t) + 5;
odefun = @(t,y) [y(2); (-b*y(2) - k*y(1) + u(t))/m];

t= 0:1e-4:10;

[t,y] = ode45(odefun,t,[0,0]);

Y = y(:,1);
figure()
plot(t,Y)
ylabel('y')
xlabel('t')
title('System output for t=[0,10]s')
grid on;
hold on;
%% Calculate system parameters using Least Squares Method
denominator = [1,4,2]; %Ë(s) = s^2 + 4s + 2
sys = tf([-1,0],denominator); 
F(:,1) = lsim(sys,Y,t);
sys = tf(-1,denominator);
F(:,2) = lsim(sys,Y,t);
sys = tf(1,denominator);
F(:,3) = lsim(sys,u(t),t);

theta = Y'*F/(F'*F);

% calculate m,b,k parameters 
m1 = 1/theta(3);
b1 = (theta(1) + 4)*m1;
k1 = (theta(2) + 2)*m1;

%calculate the new system output using the new parameters
odefun = @(t,y) [y(2); (-b1*y(2) - k1*y(1) + u(t))/m1];

[t,y] = ode45(odefun,t,[0,0]);
Y_bar = y(:,1);
plot(t,Y_bar);
hold off;
legend('Y','Y_{bar}');

%plot the deviation y - y_bar
e = Y - Y_bar;
figure()
plot(t,e)
ylabel('e')
xlabel('t')
title('e = y - y_{bar}')
grid on;



