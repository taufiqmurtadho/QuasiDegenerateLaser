%Loading data for engine

%Power
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

%Smax
smax_N3_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N3_Counts10000_Engine.mat')));
smax_N4_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N4_Counts10000_Engine.mat')));
smax_N5_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N5_Counts10000_Engine.mat')));
smax_N6_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N6_Counts10000_Engine.mat')));
smax_N7_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N7_Counts10000_Engine.mat')));
smax_N8_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N8_Counts10000_Engine.mat')));
smax_N9_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N9_Counts10000_Engine.mat')));
smax_N10_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N10_Counts10000_Engine.mat')));
smax_N11_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N11_Counts10000_Engine.mat')));
smax_N12_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N12_Counts10000_Engine.mat')));
smax_N13_Engine = cell2mat(struct2cell(load('Data/Smax/smax_dist_N13_Counts10000_Engine.mat')));

%Calculating the mean
P_mean_data = [mean(P_N3_Engine),
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

Smax_mean_data = 0.2*[mean(smax_N3_Engine),
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

%Compute the ratio
ratio = Smax_mean_data./P_mean_data;

%Plotting ratio with N
N = linspace(3,13,11);
scatter(N,ratio,'filled','red')
title('2\lambda\omega_{21}<S_{max}>/<P_{ss}> vs N (Engine)')
ylabel('2\lambda\omega_{21}<S_{max}>/<P_{ss}>')
xlabel('N')