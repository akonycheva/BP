function fp_with_motor(m0, m1, g, L, Kt, Ke, R, Lm, r, B, V, lin)

% Main script for phase portraits and time evolution plots of crane systems
global m0 m1 L g Kt Ke R Lm r B V
AA = [0 1; -1 0];

tspan = [0 2]; % Time span
if lin == 0
% Function for nonlinear crane without motor
 
% --- Nonlinear Crane with Motor ---
% Phase portrait for position (x1 vs. x2)
figure;
hold on;
for i = -10:2:10
    for j = -10:2:10
        x0 = [i; j; 0; 0; 0]; % Initial conditions for x1, x2, x3, x4, x5
        [t, x] = ode45(@xder_nonlinear_with_motor, tspan, x0);
        plot(x(:,1), x(:,2), 'b');
    end
end
title('Fázový portrét nelineárneho žeriava s motorom - poloha');
xlabel('x_1 (m)');
ylabel('x_2 (m/s)');
grid on;

% Phase portrait for angle (x3 vs. x4)
figure;
hold on;
for i = -10:1:10
    for j = -10:1:10
        x0 = [0; 0; i; j; 0]; % Initial conditions for x1, x2, x3, x4, x5
        [t, x] = ode45(@xder_nonlinear_with_motor, tspan, x0);
        plot(x(:,3), x(:,4), 'b');
    end
end
title('Fázový portrét nelineárneho žeriava s motorom - uhol');
xlabel('x_3 (rad)');
ylabel('x_4 (rad/s)');
grid on;

% Time evolution for nonlinear crane with motor
figure;
x0 = [5; 5; 0; 0; 0]; % Initial condition IC 1
[t, x] = ode45(@xder_nonlinear_with_motor, tspan, x0);
subplot(5, 1, 1);
plot(t, x(:,1));
title('x_1');
xlabel('Čas (s)');
ylabel('x_1 (m)');
grid on;

subplot(5, 1, 2);
plot(t, x(:,2));
title('x_2');
xlabel('Čas (s)');
ylabel('x_2 (m/s)');
grid on;

subplot(5, 1, 3);
plot(t, x(:,3));
title('x_3');
xlabel('Čas (s)');
ylabel('x_3 (rad)');
grid on;

subplot(5, 1, 4);
plot(t, x(:,4));
title('x_4');
xlabel('Čas (s)');
ylabel('x_4 (rad/s)');
grid on;

subplot(5, 1, 5);
plot(t, x(:,5));
title('x_5');
xlabel('Čas (s)');
ylabel('x_5 (A)');
grid on;
sgtitle('Časový priebeh nelineárneho žeriava s motorom');


else

% --- New Linearized Crane with Motor ---
% Phase portrait for position (x1 vs. x2)
figure;
hold on;
for i = -10:2:10
    for j = -10:2:10
        x0 = [i; j; 0; 0; 0]; % Initial conditions for x1, x2, x3, x4, x5
        [t, x] = ode45(@xder_linearized_with_motor_new, tspan, x0);
        plot(x(:,1), x(:,2), 'b');
    end
end
title('Fázový portrét linearizovaného žeriava s motorom - poloha');
xlabel('x_1 (m)');
ylabel('x_2 (m/s)');
grid on;

% Phase portrait for angle (x3 vs. x4)
figure;
hold on;
for i = -3:1:3
    for j = -3:1:3
        x0 = [0; 0; i; j; 0]; % Initial conditions for x1, x2, x3, x4, x5
        [t, x] = ode45(@xder_linearized_with_motor_new, tspan, x0);
        plot(x(:,3), x(:,4), 'b');
    end
end
title('Fázový portrét linearizovaného žeriava s motorom - uhol');
xlabel('x_3 (rad)');
ylabel('x_4 (rad/s)');
grid on;

% Time evolution for new linearized crane with motor
figure;
x0 = [5; 5; 0; 0; 0]; % Initial condition IC 1
[t, x] = ode45(@xder_linearized_with_motor_new, tspan, x0);
subplot(5, 1, 1);
plot(t, x(:,1));
title('x_1');
xlabel('Čas (s)');
ylabel('x_1 (m)');
grid on;

subplot(5, 1, 2);
plot(t, x(:,2));
title('x_2');
xlabel('Čas (s)');
ylabel('x_2 (m/s)');
grid on;

subplot(5, 1, 3);
plot(t, x(:,3));
title('x_3');
xlabel('Čas (s)');
ylabel('x_3 (rad)');
grid on;

subplot(5, 1, 4);
plot(t, x(:,4));
title('x_4');
xlabel('Čas (s)');
ylabel('x_4 (rad/s)');
grid on;

subplot(5, 1, 5);
plot(t, x(:,5));
title('x_5');
xlabel('Čas (s)');
ylabel('x_5 (A)');
grid on;
sgtitle('Časový priebeh linearizovaného žeriava s motorom');
end

% Function for new linearized crane with motor
function xder = xder_linearized_with_motor_new(t, x)

    eps = 1e-6; % Small regularization term
    
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
    
    % Linearized differential equations
  
    
    dx1dt = x2;
    dx2dt = ((Kt * x5 / r) - (B*x2 / r^2) + m1*L*x4^2*x3 + g*m1*x3)/m0;
    dx3dt = x4;
    dx4dt = ((Kt * x5 / r) - (B*x2 / r^2) + m1* L *x4^2*x3 + g*(m0+m1)*x3)/(m1*L - (m0+m1)*L);
    dx5dt = (V - R * x5 - Ke * (x2 / r)) / Lm;
    
    xder = [dx1dt; dx2dt; dx3dt; dx4dt; dx5dt];
end
function xder = xder_nonlinear_with_motor(t, x)

    eps = 1e-6; % Small regularization term
    
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4); x5 = x(5);
    
    % Differential equations
    dx1dt = x2;
    dx2dt = ((Kt * x5 / r) - (B*x2 / r^2) + m1* L*x4^2 *sin(x3) + g * m1 * sin(x3) * cos(x3))/(m0+m1*(1 - cos(x3)^2));
    dx3dt = x4;
    dx4dt = (((Kt * x5 / r) - (B*x2 / r^2))* cos(x3) + m1*L*x4^2*sin(x3)*cos(x3)+g*(m0+m1)*sin(x3))/(m1*L*cos(x3)^2 - (m0+m1)*L);
    dx5dt = (V - R * x5 - Ke * (x2 / r)) / Lm;
    
    xder = [dx1dt; dx2dt; dx3dt; dx4dt; dx5dt];
end
end