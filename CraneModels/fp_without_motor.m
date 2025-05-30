function fp_without_motor(m0, m1, L, g, u, lin)

% Main script for phase portraits and time evolution plots of crane systems
AA = [0 1; -1 0];
global m0 m1 L g u
tspan = [0 2]; % Time span
if lin == 0
% --- Nonlinear Crane without Motor ---
% Phase portrait for position (x1 vs. x2)
figure;
hold on;
for i = -15:2:15
    for j = -15:2:15
        x0 = [i; j; 0; 0]; % Initial conditions for x1 and x2, x3 and x4 set to 0
        [t, x] = ode45(@phase_portraits, tspan, x0);
        plot(x(:,1), x(:,2), 'b');
    end
end
title('Fázový portrét nelineárneho žeriava bez motora - poloha');
xlabel('x_1 (m)');
ylabel('x_2 (m/s)');
grid on;

% Phase portrait for angle (x3 vs. x4)
figure;
hold on;
for i = -7:1:7
    for j = -7:1:7
        x0 = [0; 0; i; j]; % Initial conditions for x3 and x4, x1 and x2 set to 0
        [t, x] = ode45(@phase_portraits, tspan, x0);
        plot(x(:,3), x(:,4), 'b');
    end
end
title('Fázový portrét nelineárneho žeriava bez motora - uhol');
xlabel('x_3 (rad)');
ylabel('x_4 (rad/s)');
grid on;

% Time evolution for nonlinear crane without motor
figure;
x0 = [5; 5; 0; 0]; % Initial condition IC 1
[t, x] = ode45(@phase_portraits, tspan, x0);
subplot(4, 1, 1);
plot(t, x(:,1));
title('x_1');
xlabel('Čas (s)');
ylabel('x_1 (m)');
grid on;

subplot(4, 1, 2);
plot(t, x(:,2));
title('x_2');
xlabel('Čas (s)');
ylabel('x_2 (m/s)');
grid on;

subplot(4, 1, 3);
plot(t, x(:,3));
title('x_3');
xlabel('Čas (s)');
ylabel('x_3 (rad)');
grid on;

subplot(4, 1, 4);
plot(t, x(:,4));
title('x_4');
xlabel('Čas (s)');
ylabel('x_4 (rad/s)');
grid on;
sgtitle('Časový priebeh nelineárneho žeriava bez motora');


else
% --- Linearized Crane without Motor ---
% Phase portrait for position (x1 vs. x2)
figure;
hold on;
for i = -10:2:10
    for j = -10:2:10
        x0 = [i; j; 0; 0]; % Initial conditions for x1 and x2, x3 and x4 set to 0
        [t, x] = ode45(@xder_linearized, tspan, x0);
        plot(x(:,1), x(:,2), 'b');
    end
end
title('Fázový portrét linearizovaného žeriava bez motora - poloha');
xlabel('x_1 (m)');
ylabel('x_2 (m/s)');
grid on;

% Phase portrait for angle (x3 vs. x4)
figure;
hold on;
for i = -3:1:3
    for j = -3:1:3
        x0 = [0; 0; i; j]; % Initial conditions for x3 and x4, x1 and x2 set to 0
        [t, x] = ode45(@xder_linearized, tspan, x0);
        plot(x(:,3), x(:,4), 'b');
    end
end
title('Fázový portrét linearizovaného žeriava bez motora - uhol');
xlabel('x_3 (rad)');
ylabel('x_4 (rad/s)');
grid on;

% Time evolution for linearized crane with motor
figure;
x0 = [5; 5; 0; 0]; % Initial condition IC 1
[t, x] = ode45(@xder_linearized, tspan, x0);
subplot(4, 1, 1);
plot(t, x(:,1));
title('x_1');
xlabel('Čas (s)');
ylabel('x_1 (m)');
grid on;

subplot(4, 1, 2);
plot(t, x(:,2));
title('x_2');
xlabel('Čas (s)');
ylabel('x_2 (m/s)');
grid on;

subplot(4, 1, 3);
plot(t, x(:,3));
title('x_3');
xlabel('Čas (s)');
ylabel('x_3 (rad)');
grid on;

subplot(4, 1, 4);
plot(t, x(:,4));
title('x_4');
xlabel('Čas (s)');
ylabel('x_4 (rad/s)');
grid on;
sgtitle('Časový priebeh linearizovaného žeriava bez motora');
end
% --- Function Definitions ---

% Function for nonlinear crane without motor
function xder = phase_portraits(t, x)
    AA = [0 1; -1 0]; 
    eps = 1e-6; % Small regularization term
    
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
    
    % Differential equations with regularization
    denom1 = m0 + m1 * (1 - cos(x3)^2) + eps;
    denom2 = m1 * L * cos(x3)^2 - (m0 + m1) * L + eps;
    
    dx1dt = x2;
    dx2dt = (u + m1 * L * x4^2 * sin(x3) + g * m1 * sin(x3) * cos(x3)) / denom1;
    dx3dt = x4;
    dx4dt = (u * cos(x3) + m1 * L * x4^2 * sin(x3) * cos(x3) + g * (m0 + m1) * sin(x3)) / denom2;
    
    xder = [dx1dt; dx2dt; dx3dt; dx4dt];
end

% Function for linearized crane without motor
function xder = xder_linearized(t, x)
    eps = 1e-6; % Small regularization term
    
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
    
    % Linearized differential equations
    denom1 = m0 + eps;
    denom2 = m1 * L - (m0 + m1) * L + eps;
    
    dx1dt = x2;
    dx2dt = (u + m1 * L * x4^2 * x3 + g * m1 * x3) / denom1;
    dx3dt = x4;
    dx4dt = (u + m1 * L * x4^2 * x3 + g * (m0 + m1) * x3) / denom2;
    
    xder = [dx1dt; dx2dt; dx3dt; dx4dt];
end

end