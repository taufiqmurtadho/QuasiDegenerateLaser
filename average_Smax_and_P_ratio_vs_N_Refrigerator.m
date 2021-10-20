%Loading data for Refrigerator

%Power
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

%Smax
smax_N3_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N3_Counts10000_Refrigerator.mat')));
smax_N4_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N4_Counts10000_Refrigerator.mat')));
smax_N5_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N5_Counts10000_Refrigerator.mat')));
smax_N6_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N6_Counts10000_Refrigerator.mat')));
smax_N7_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N7_Counts10000_Refrigerator.mat')));
smax_N8_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N8_Counts10000_Refrigerator.mat')));
smax_N9_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N9_Counts10000_Refrigerator.mat')));
smax_N10_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N10_Counts10000_Refrigerator.mat')));
smax_N11_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N11_Counts10000_Refrigerator.mat')));
smax_N12_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N12_Counts10000_Refrigerator.mat')));
smax_N13_Refrigerator = cell2mat(struct2cell(load('Data/Smax/smax_dist_N13_Counts10000_Refrigerator.mat')));

%Calculating the mean
P_mean_data = [mean(P_N3_Refrigerator),
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

Smax_mean_data = 0.2*[mean(smax_N3_Refrigerator),
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

%Compute the ratio
ratio = Smax_mean_data./P_mean_data;

%Plotting ratio with N
N = linspace(3,13,11);
scatter(N,ratio,'filled','red')
title('2\lambda\omega_{21}<S_{max}>/<P_{ss}> vs N (Refrigerator)')
ylabel('2\lambda\omega_{21}<S_{max}>/<P_{ss}>')
xlabel('N')