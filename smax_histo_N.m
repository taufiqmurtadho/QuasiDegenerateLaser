counts1  = 10000;
counts2 = 20000;
smax_data1 = zeros(1,counts1);
smax_data2 = zeros(1,counts2);
filename1 = 'smax_dist_N5_Counts10000_Refrigerator.mat';
filename2 = 'smax_dist_N5_Counts20000_Refrigerator.mat';
for i = 1:counts1
    ss = getSteadyState(7,1,3,0.1,0.1,2,1.5,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(5)),0,0,0.05);
    smax = 0;
    for j=1:10
        new_smax = MaxSyncMeasure1(ss);
        if new_smax > smax
            smax = new_smax;
        end
    end
    smax_data1(i) = smax;
end
for i = 1:counts2
    ss = getSteadyState(7,1,3,0.1,0.1,2,1.5,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(5)),0,0,0.05);
    smax =0;
    for j=1:10
        new_smax = MaxSyncMeasure1(ss);
        if new_smax > smax
            smax = new_smax;
        end
    end
    smax_data2(i) = smax;
end
save(filename1, 'smax_data1');
save(filename2, 'smax_data2');
edges = linspace(0.03,0.06,40);
histogram(smax_data1, edges,'EdgeAlpha',0.1, 'FaceAlpha',0.75,'Normalization', 'probability')
hold on;
histogram(smax_data2, edges,'EdgeAlpha',0.1, 'FaceAlpha',0.75, 'FaceColor','r', 'Normalization', 'probability')
title('S_{max} Distribution (N = 5, Refrigerator)')
xlabel('S_{max}')
ylabel('Probability')
legend({'Counts = 20,000', 'Counts = 40,000'})