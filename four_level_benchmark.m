%Smax vs p in four-level engine
p = linspace(-1,0.99,40);
smax_data = zeros(1,length(p));
for i = 1:length(p)
    ss = getSteadyState(4,1,3,0.1,0.1,2,0.2,py.N_Level_Engine_v2.pmatrix_2by2(p(i)),0,0,0.05);
    smax = 0;
    for j = 1:50
        new_smax = MaxSyncMeasure1(ss);
        if new_smax>smax
            smax = new_smax;
        end
    end
    smax_data(i)=smax;
end
scatter(p,smax_data,'filled')
ylim([0,0.1])
title('S_{max} vs p (Engine)')
xlabel('p')
ylabel('S_{max}')   
