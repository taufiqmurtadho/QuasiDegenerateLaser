%counts1  = 10000;
counts2 = 20000;
%smax_data1 = zeros(1,counts1);
smax_data2 = zeros(1,counts2);
%filename1 = 'smax_dist_N13_Counts10000_Refrigerator.mat';
filename2 = 'smax_dist_N10_Counts20000_Engine.mat';
%for i = 1:counts1
%    ss = getSteadyState(15,1,3,0.1,0.1,2,0.2,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(13)),0,0,0.05);
%    smax_data1(i)=MaxSyncMeasure1(ss);
%end
for i = 1:counts2
    ss = getSteadyState(12,1,3,0.1,0.1,2,0.2,py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(10)),0,0,0.05);
    smax_data2(i)=MaxSyncMeasure1(ss);
end
%save(filename1, 'smax_data1');
save(filename2, 'smax_data2');
%edges = linspace(0.03,0.06,40);
%histogram(smax_data1, edges,'EdgeAlpha',0.1, 'FaceAlpha',0.4,'Normalization', 'probability')
%hold on;
%histogram(smax_data2, edges,'EdgeAlpha',0.1, 'FaceAlpha',0.4, 'FaceColor','r', 'Normalization', 'probability')
%title('S_{max} Distribution (N = 5, Refrigerator)')
%xlabel('S_{max}')
%ylabel('Probability')
%legend({'Counts = 10,000', 'Counts = 20,000'})