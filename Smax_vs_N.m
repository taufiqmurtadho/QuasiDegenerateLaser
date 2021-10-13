smax_data = zeros(1,28);
for n = 3:30
    ss = getSteadyState(n+2,1,3,0.1,0.1,2,0.2,py.numpy.identity(py.int(n)),0,0,0.05);
    smax_data(n-2)=MaxSyncMeasure1(ss);
end
N = linspace(3,30,28);
scatter(N, smax_data,'filled')
title('S_{max} vs N')
xlabel('N')
ylabel('S_{max}')