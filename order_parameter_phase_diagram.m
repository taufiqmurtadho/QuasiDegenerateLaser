x_min = 1;
x_max = 5;
y_min = 0.02;
y_max = 0.08;
Nx = 50;
Ny = 50;
dx = (x_max-x_min)/Nx;
dy = (y_max - y_min)/Ny;
x = x_min:dx:x_max;
y = y_min:dy:y_max;
phase_diff_data = zeros(length(x),length(y));
for a = 1:length(x)
    for b = 1:length(y)
        ss = getSteadyState(5,1,3,0.1,0.1,x(a),0.2,py.numpy.identity(py.int(3)),0,0,y(b));
        opt_phases = optimum_phases(ss);
        smax = SyncMeasure(ss, opt_phases);
        for c=1:20
            new_opt_phases = optimum_phases(ss);
            new_smax = SyncMeasure(ss, new_opt_phases);
            if new_smax > smax
                smax = new_smax;
                opt_phases = new_opt_phases;
            end
        end
        order_parameter = 0;
        for d =1:length(opt_phases)
            for e = d+1:length(opt_phases)
                order_parameter = order_parameter + exp(1j*(opt_phases(d)-opt_phases(e)));
            end
        end
        order_parameter = abs(order_parameter);
        distinct_comb = length(opt_phases)*(length(opt_phases)-1)/2;
        phase_diff_data(b,a) = order_parameter/distinct_comb;
    end
end
%disp(phase_diff_data)
%figure;
pcolor(x, y, phase_diff_data);    
colorbar;
shading interp;