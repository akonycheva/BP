function phase_portrait(func, Tspan, x_range, x_step, y_range, y_step)
    % x_range: rozsah počiatočných hodnôt pre x1 [min, max]
    % x_step: krok pre x1
    % y_range: rozsah počiatočných hodnôt pre x2 [min, max]
    % y_step: krok pre x2
    
    hold on;
    for x1 = x_range(1):x_step:x_range(2)
        for x2 = y_range(1):y_step:y_range(2)
            init_conditions = [x1, x2];
            [t, x] = ode45(func, Tspan, init_conditions);
            plot(x(:, 1), x(:, 2), '-blue');
        end
    end
    hold off;
end

