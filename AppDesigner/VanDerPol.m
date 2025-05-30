function VanDerPol(u, metoda)

init = [1, 1];
Tspan = [0, 10];
if metoda == 1
plot_time_response('Nelinearny Van der Polov oscilator', @(t, x) nonlinear(t, x, u), init, Tspan);
else
plot_time_response('Linearne Van der Polov oscilator', @(t, x) linear(t, x, u), init, Tspan);
end
 
x_range = [-5, 5];   
x_step = 1;             
y_range = [-5, 5];    
y_step = 1;             
if metoda == 1
%Fazove portrety Nelinearneho Modelu
figure('Name', 'Fazovy portret Nelinearneho Van der Polov oscilatora')
phase_portrait(@(t, x) nonlinear(t, x, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Nelinearny Van der Polov oscilator (u = %0.2f)', u));
else
%Fazove portrety Linearneho Modelu
figure('Name', 'Fazovy portret Linearneho Van der Polov oscilatora')
phase_portrait(@(t, x) linear(t, x, u), Tspan, x_range, x_step, y_range, y_step);
grid on;
xline(0, 'r');
yline(0, 'r');
xlabel('x(t)');
ylabel('x''(t)');
title(sprintf('Fazovy portret Linearny Van der Polov oscilator (u = %0.2f)', u));
end
function xder = linear(t, x, u)
	%Linearizovane okolo rovnovazneho stavu [0 0]
	A = [0, 1; -1, 1];
	B = [0; 1];
	
	if isrow(x)
		x = x';
	end

	xder = A*x + B*u;
end

function xder = nonlinear(t, x, u)
    xder = [x(2); u + (1 - x(1)^2) * x(2) - x(1)];
end
end