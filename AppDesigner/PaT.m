function PaT(m, c, k, u, alpha, metoda)
InitC = [1, 0]; 
Tspan = [0, 100];

if metoda == 1
%casove priebehy x1(t) a x2(t) 
plot_time_response('Nelinearna Pruzina a Tlmic', @(t, x) nonlinear(t, x, m, c, k, alpha, u), InitC, Tspan);
else
plot_time_response('Linearna Pruzina a Tlmic', @(t, x) linear(t, x, m, c, k, alpha, u), InitC, Tspan);
end

%Parametre pre vytvaranie fazovych portretov 
x_range = [-20, 20];  % diapazon pre x1
x_step = 10;        % krok pre x1
y_range = [-20, 20];    % diapazon pre x2
y_step = 10;         % krok pre x2
if metoda == 1
%Fazove portrety Nelinearneho Modelu
figure('Name', 'Fazovy portret Nelinearna Pruzina a Tlmic ')
phase_portrait(@(t, x) nonlinear(t, x, m, c, k, alpha, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Nelinearna Pruzina a Tlmic (u = %0.2f)', u));
else
%Fazove portrety Linearneho Modelu
figure('Name', 'Fazovy portret Linearna Pruzina a Tlmic')
phase_portrait(@(t, x) linear(t, x, m, c, k, alpha, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Linearna Pruzina a Tlmic (u = %0.2f)', u));
end
function xder = linear(t, x, m, c, k, alpha, u)
	A = [0, 1; -k/m, -c/m];
	B = [0; 1/m];
	
	if isrow(x)
		x = x';
	end

	xder = A*x + B*u;
end

function xder = nonlinear(t, x, m, c, k, alpha, u)
    xder = [x(2); (1/m) * (u - c*x(2) - k*x(1) - alpha*x(1)^3)];
end
end