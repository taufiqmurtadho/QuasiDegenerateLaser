function S = SyncMeasure(steadystate, phases)
    if length(phases) ~= length(steadystate)-2
        print("WARNING: The number of phases does not match steady-state dimension")
    end
    S = 0;
    for x = 1:length(phases)
        S = S + real(steadystate(2,x+2)*exp(1i*phases(x)));
    end
    for x = 3:length(steadystate)
        for y = x+1:length(steadystate)
            S = S + real(steadystate(x,y)*exp(1i*(phases(x-2)-phases(y-2))));
        end 
    end 
end