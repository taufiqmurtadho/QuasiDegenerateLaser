Nmax =10;
sample = 1000;
largest_smax = zeros(1,Nmax);
for n = 3:Nmax
    smax = 0;
    for i =1:sample
        ss = getSteadyState(n+2, 1,3,0.1,0.1,2,0.2, py.N_Level_Engine_v2.uniform_correlation_matrix(py.int(n)),0,0,0.05);
        new_smax = MaxSyncMeasure1(ss);
        if new_smax>smax
            smax = new_smax;
        end
    end
    largest_smax(n-2) = smax;
end
print(largest_smax)
          