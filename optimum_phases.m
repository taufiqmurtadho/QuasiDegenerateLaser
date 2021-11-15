function optimum_phases = optimum_phases(steadystate)
    function s = cost_function(phases)
        s = -SyncMeasure(steadystate, phases);
    end 
    num_of_phases = length(steadystate)-2;
    initial_guess = 2*pi*rand(1,num_of_phases);
    lb = zeros(1,num_of_phases);
    ub = 2*pi*ones(1,num_of_phases);
    optimum_phases = fmincon(@(x)cost_function(x),initial_guess,[],[],[],[],lb,ub);
end 