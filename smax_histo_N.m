counts  = 10000;
data = zeros(1,counts);
ref_ss = getSteadyState(7,1,3,0.1,0.1,2,0.2,py.numpy.identity(py.int(5)),0,0,0.05);
ref_smax = 0;
for i =1:10
    new_smax = MaxSyncMeasure1(ref_ss);
    if new_smax > ref_smax
        ref_smax = new_smax;
    end
end 
for i = 1:counts
    ss = getSteadyState(7,1,3,0.1,0.1,2,0.2,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(5)),0,0,0.05);
    data(i)=MaxSyncMeasure1(ss)/ref_smax;
end
histogram(data)
title('S_{max} Distribution (N = 5)')
xlabel('S_{max}/S_{ref}')
ylabel('Counts')

