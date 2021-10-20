filename = 'P_dist_N13_Counts10000_Engine.mat';
counts = 10000;
power_data = zeros(1,counts);
for i = 1:counts
    ss = getSteadyState(15,1,3,0.1,0.1,2,0.2,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(13)),0,0,0.05);
    power_data(i) = getpower(ss,1,3,0,0.05);
end
save(filename, 'power_data')