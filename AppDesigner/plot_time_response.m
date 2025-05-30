function plot_time_response(system_name, func, init_conditions, time_span)
    % system_name: Názov systému (pre názov grafu)
    % func: Funkcia systému (nelineárna alebo lineárna)

    % Integrácia pomocou ode45 a runge kutta
    [t_ode45, x_ode45] = ode45(func, time_span, init_conditions); 

    % Vytvorenie grafu pre x1(t)
    figure;
    hold on
    plot(t_ode45, x_ode45(:, 1), '-red', 'DisplayName', 'x_1', 'LineWidth', 1);
    plot(t_ode45, x_ode45(:, 2), '-blue', 'DisplayName', 'x_2', 'LineWidth', 1);

    legend;
    grid on;
 
end

