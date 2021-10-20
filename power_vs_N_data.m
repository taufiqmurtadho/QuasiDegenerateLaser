power_data = zeros(1,28);
filename = 'power_vs_N_engine.mat';
for n = 3:30
    ss = getSteadyState(n+2,1,3,0.1,0.1,2,0.2,py.numpy.identity(py.int(n)),0,0,0.05);
    power_data(n-2) = getpower(ss,1,3,0,0.05);
end
save(filename, 'power_data')