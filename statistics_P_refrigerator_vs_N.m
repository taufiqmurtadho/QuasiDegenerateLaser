%Loading data for Refrigerator
P_N3_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N3_Counts10000_Refrigerator.mat'))));
P_N4_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N4_Counts10000_Refrigerator.mat'))));
P_N5_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N5_Counts10000_Refrigerator.mat'))));
P_N6_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N6_Counts10000_Refrigerator.mat'))));
P_N7_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N7_Counts10000_Refrigerator.mat'))));
P_N8_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N8_Counts10000_Refrigerator.mat'))));
P_N9_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N9_Counts10000_Refrigerator.mat'))));
P_N10_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N10_Counts10000_Refrigerator.mat'))));
P_N11_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N11_Counts10000_Refrigerator.mat'))));
P_N12_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N12_Counts10000_Refrigerator.mat'))));
P_N13_Refrigerator = abs(cell2mat(struct2cell(load('Data/Power/P_dist_N13_Counts10000_Refrigerator.mat'))));

%Mean
mean_data = [mean(P_N3_Refrigerator),
mean(P_N4_Refrigerator),
mean(P_N5_Refrigerator),
mean(P_N6_Refrigerator),
mean(P_N7_Refrigerator),
mean(P_N8_Refrigerator),
mean(P_N9_Refrigerator),
mean(P_N10_Refrigerator),
mean(P_N11_Refrigerator),
mean(P_N12_Refrigerator),
mean(P_N13_Refrigerator)];

%Median
median_data = [mean(P_N3_Refrigerator),
median(P_N4_Refrigerator),
median(P_N5_Refrigerator),
median(P_N6_Refrigerator),
median(P_N7_Refrigerator),
median(P_N8_Refrigerator),
median(P_N9_Refrigerator),
median(P_N10_Refrigerator),
median(P_N11_Refrigerator),
median(P_N12_Refrigerator),
median(P_N13_Refrigerator)];

%Standard Deviation
std_data = [std(P_N3_Refrigerator),
std(P_N4_Refrigerator),
std(P_N5_Refrigerator),
std(P_N6_Refrigerator),
std(P_N7_Refrigerator),
std(P_N8_Refrigerator),
std(P_N9_Refrigerator),
std(P_N10_Refrigerator),
std(P_N11_Refrigerator),
std(P_N12_Refrigerator),
std(P_N13_Refrigerator)];


N = linspace(3,13,11);
%scatter(N, mean_data,70,'x','black')
%hold on;
%scatter(N, median_data, 30,'red')
scatter(N, std_data, '^','blue')
%title('Mean and Median of P_{ss} vs N (Refrigerator)')
title('Standard Deviation of P_{ss} vs N (Refrigerator)')
xlabel('N')
%ylabel('P_{ss}')
ylabel('\delta P_{ss}')
%legend({'Average', 'Median'})
%hold off;