%Loading data for Refrigerator
smax_N3_Refrigerator = cell2mat(struct2cell(load('smax_dist_N3_Counts10000_Refrigerator.mat')));
smax_N4_Refrigerator = cell2mat(struct2cell(load('smax_dist_N4_Counts10000_Refrigerator.mat')));
smax_N5_Refrigerator = cell2mat(struct2cell(load('smax_dist_N5_Counts10000_Refrigerator.mat')));
smax_N6_Refrigerator = cell2mat(struct2cell(load('smax_dist_N6_Counts10000_Refrigerator.mat')));
smax_N7_Refrigerator = cell2mat(struct2cell(load('smax_dist_N7_Counts10000_Refrigerator.mat')));
smax_N8_Refrigerator = cell2mat(struct2cell(load('smax_dist_N8_Counts10000_Refrigerator.mat')));
smax_N9_Refrigerator = cell2mat(struct2cell(load('smax_dist_N9_Counts10000_Refrigerator.mat')));
smax_N10_Refrigerator = cell2mat(struct2cell(load('smax_dist_N10_Counts10000_Refrigerator.mat')));
smax_N11_Refrigerator = cell2mat(struct2cell(load('smax_dist_N11_Counts10000_Refrigerator.mat')));
smax_N12_Refrigerator = cell2mat(struct2cell(load('smax_dist_N12_Counts10000_Refrigerator.mat')));
smax_N13_Refrigerator = cell2mat(struct2cell(load('smax_dist_N13_Counts10000_Refrigerator.mat')));

%Mean
mean_data = [mean(smax_N3_Refrigerator),
mean(smax_N4_Refrigerator),
mean(smax_N5_Refrigerator),
mean(smax_N6_Refrigerator),
mean(smax_N7_Refrigerator),
mean(smax_N8_Refrigerator),
mean(smax_N9_Refrigerator),
mean(smax_N10_Refrigerator),
mean(smax_N11_Refrigerator),
mean(smax_N12_Refrigerator),
mean(smax_N13_Refrigerator)];

%Median
median_data = [mean(smax_N3_Refrigerator),
median(smax_N4_Refrigerator),
median(smax_N5_Refrigerator),
median(smax_N6_Refrigerator),
median(smax_N7_Refrigerator),
median(smax_N8_Refrigerator),
median(smax_N9_Refrigerator),
median(smax_N10_Refrigerator),
median(smax_N11_Refrigerator),
median(smax_N12_Refrigerator),
median(smax_N13_Refrigerator)];

%Standard Deviation
std_data = [std(smax_N3_Refrigerator),
std(smax_N4_Refrigerator),
std(smax_N5_Refrigerator),
std(smax_N6_Refrigerator),
std(smax_N7_Refrigerator),
std(smax_N8_Refrigerator),
std(smax_N9_Refrigerator),
std(smax_N10_Refrigerator),
std(smax_N11_Refrigerator),
std(smax_N12_Refrigerator),
std(smax_N13_Refrigerator)];


N = linspace(3,13,11);
scatter(N, mean_data,70,'x','black')
hold on;
scatter(N, median_data,'red')
title('Mean and Median of S_{max} vs N (Refrigerator)')
xlabel('N')
ylabel('\deltaS_{max}')
legend({'Average', 'Median'},'Location', 'northwest')
hold off;