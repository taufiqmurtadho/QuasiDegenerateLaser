smax_data = zeros(1,28);
filename = 'smax_vs_N_engine.mat';
for n = 3:30
    ss = getSteadyState(n+2,1,3,0.1,0.1,2,0.2,py.numpy.identity(py.int(n)),0,0,0.05);
    smax = 0;
    for i = 1:10
        new_smax = MaxSyncMeasure1(ss);
        if new_smax > smax
            smax = new_smax;
        end
    end
    smax_data(n-2)=smax;
end
save(filename, 'smax_data')
N = linspace(3,30,28);
scatter(N, smax_data,'filled', 'red')
title('S_{max} vs N (Engine)')
xlabel('N')
ylabel('S_{max}')