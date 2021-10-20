%Loading data for engine
P_N3_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N3_Counts10000_Engine.mat')));
P_N4_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N4_Counts10000_Engine.mat')));
P_N5_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N5_Counts10000_Engine.mat')));
P_N6_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N6_Counts10000_Engine.mat')));
P_N7_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N7_Counts10000_Engine.mat')));
P_N8_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N8_Counts10000_Engine.mat')));
P_N9_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N9_Counts10000_Engine.mat')));
P_N10_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N10_Counts10000_Engine.mat')));
P_N11_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N11_Counts10000_Engine.mat')));
P_N12_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N12_Counts10000_Engine.mat')));
P_N13_Engine = cell2mat(struct2cell(load('Data/Power/P_dist_N13_Counts10000_Engine.mat')));

%Mean
mean_data = [mean(P_N3_Engine),
mean(P_N4_Engine),
mean(P_N5_Engine),
mean(P_N6_Engine),
mean(P_N7_Engine),
mean(P_N8_Engine),
mean(P_N9_Engine),
mean(P_N10_Engine),
mean(P_N11_Engine),
mean(P_N12_Engine),
mean(P_N13_Engine)];

%Median
median_data = [mean(P_N3_Engine),
median(P_N4_Engine),
median(P_N5_Engine),
median(P_N6_Engine),
median(P_N7_Engine),
median(P_N8_Engine),
median(P_N9_Engine),
median(P_N10_Engine),
median(P_N11_Engine),
median(P_N12_Engine),
median(P_N13_Engine)];

%Standard Deviation
std_data = [std(P_N3_Engine),
std(P_N4_Engine),
std(P_N5_Engine),
std(P_N6_Engine),
std(P_N7_Engine),
std(P_N8_Engine),
std(P_N9_Engine),
std(P_N10_Engine),
std(P_N11_Engine),
std(P_N12_Engine),
std(P_N13_Engine)];

%Plotting the data
N = linspace(3,13,11);
scatter(N, mean_data,70,'x','black')
hold on;
scatter(N, median_data, 30,'red')
%scatter(N, std_data, '^','blue')
%title('Standard Deviation of P_{ss} vs N (Engine)')
title('Mean and Median of P_{ss} vs N (Engine)')
xlabel('N')
%ylabel('\delta P_{ss}')
ylabel('P_{ss}')
legend({'Average', 'Median'})
hold off;