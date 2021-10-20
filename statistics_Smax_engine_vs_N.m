%Loading data for engine
smax_N3_Engine = cell2mat(struct2cell(load('smax_dist_N3_Counts10000_Engine.mat')));
smax_N4_Engine = cell2mat(struct2cell(load('smax_dist_N4_Counts10000_Engine.mat')));
smax_N5_Engine = cell2mat(struct2cell(load('smax_dist_N5_Counts10000_Engine.mat')));
smax_N6_Engine = cell2mat(struct2cell(load('smax_dist_N6_Counts10000_Engine.mat')));
smax_N7_Engine = cell2mat(struct2cell(load('smax_dist_N7_Counts10000_Engine.mat')));
smax_N8_Engine = cell2mat(struct2cell(load('smax_dist_N8_Counts10000_Engine.mat')));
smax_N9_Engine = cell2mat(struct2cell(load('smax_dist_N9_Counts10000_Engine.mat')));
smax_N10_Engine = cell2mat(struct2cell(load('smax_dist_N10_Counts10000_Engine.mat')));
smax_N11_Engine = cell2mat(struct2cell(load('smax_dist_N11_Counts10000_Engine.mat')));
smax_N12_Engine = cell2mat(struct2cell(load('smax_dist_N12_Counts10000_Engine.mat')));
smax_N13_Engine = cell2mat(struct2cell(load('smax_dist_N13_Counts10000_Engine.mat')));

%Mean
mean_data = [mean(smax_N3_Engine),
mean(smax_N4_Engine),
mean(smax_N5_Engine),
mean(smax_N6_Engine),
mean(smax_N7_Engine),
mean(smax_N8_Engine),
mean(smax_N9_Engine),
mean(smax_N10_Engine),
mean(smax_N11_Engine),
mean(smax_N12_Engine),
mean(smax_N13_Engine)];

%Median
median_data = [mean(smax_N3_Engine),
median(smax_N4_Engine),
median(smax_N5_Engine),
median(smax_N6_Engine),
median(smax_N7_Engine),
median(smax_N8_Engine),
median(smax_N9_Engine),
median(smax_N10_Engine),
median(smax_N11_Engine),
median(smax_N12_Engine),
median(smax_N13_Engine)];

%Standard Deviation
std_data = [std(smax_N3_Engine),
std(smax_N4_Engine),
std(smax_N5_Engine),
std(smax_N6_Engine),
std(smax_N7_Engine),
std(smax_N8_Engine),
std(smax_N9_Engine),
std(smax_N10_Engine),
std(smax_N11_Engine),
std(smax_N12_Engine),
std(smax_N13_Engine)];


N = linspace(3,13,11);
%scatter(N, mean_data,70,'x','black')
%hold on;
%scatter(N, median_data, 30,'red')
scatter(N, std_data, '^','blue')
title('Standard Deviation of S_{max} vs N (Engine)')
xlabel('N')
ylabel('\deltaS_{max}')
%legend({'Average', 'Median'})
%hold off;