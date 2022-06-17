O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25 * 10^(-12);
data_per_ts = 32;
data_count = N * data_per_ts;

for i = 1:N-1
    for j = 1:data_per_ts
        if pattern1(i) == 1
            pattern2(i*data_per_ts+j) = sin(pi*(j/data_per_ts));
        else
            pattern2(i*data_per_ts+j) = pattern1(i);
        end
    end
end

eyediagram(pattern2.^2, 64)
ylabel('Amplitude')
ylim([-0.2, 1.2])