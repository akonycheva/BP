% Funkcia na kreslenie fazovych portretov nelinearneho matematickeho kyvadla s trajektóriami
% Vstupy:
%   g - gravitacna konstanta (m/s^2)
%   l - dlzka kyvadla (m)
%   u - vonkajsi moment (N*m)
%   metoda - boolean (0: linearizacia v bodoch rovnovahy, 1: plny fazovy portret)
% Vystup: fazove portrety s trajektóriami a popismi v slovencine
metoda = 1;
g = 1;
u = 1;
l = 1;
m = 2; %hmotnosť
b = 0.5; %koeficient trenia

InitC = [1, 1];
Tspan = [0, 50];

plot_time_response('Nelinearne kyvadlo', @(t, x) nonlinear(t, x, l, m, b, u), InitC, Tspan); 

plot_time_response('Linearne kyvadlo', @(t, x) linear(t, x, l, m, b, u), InitC, Tspan);


%Parametre pre vytvaranie fazovych portretov 
x_range = [-pi, pi];  % diapazon pre x1
x_step = pi/4;        % krok pre x1
y_range = [-2, 2];    % diapazon pre x2
y_step = 0.7;         % krok pre x2

%Fazove portrety Nelinearneho Modelu
figure('Name', 'Fazovy portret Nelinearneho kyvadla')
phase_portrait(@(t, x) nonlinear(t, x, l, m, b, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Nelinearne kyvadlo (u = %0.2f)', u));

%Fazove portrety Linearneho Modelu
figure('Name', 'Fazovy portret Linearneho kyvadla')
phase_portrait(@(t, x) linear(t, x, l, m, b, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Linearne kyvadlo (u = %0.2f)', u));


function xder = linear(t, x, l, m, b, u)
	g = 9.81;
	if isrow(x)
		x = x';
	end
	A = [0, 1; -g/l, -b/m];
	B = [0; 1/m*l];

	xder = A*x + B*u;
end

function xder = nonlinear(t, x, l, m, b, u)
    g = 9.81;
    xder = [x(2); (-b/m * x(2) - g/l* sin(x(1)) + u) / (m * l)];
end
