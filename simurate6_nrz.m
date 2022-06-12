O = 5;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25;
data_per_ts = 32;
data_count = N * data_per_ts;

for i = 1:N-1
    for j = 1:data_per_ts
        if pattern1(i+1) == pattern1(i)
             pattern2(i*data_per_ts+j) = pattern1(i);
        else
            if pattern1(i) == 1
                pattern2(i*data_per_ts+j) = cos((pi/2)*(j/data_per_ts));
            else
                pattern2(i*data_per_ts+j) = cos(-((pi/2)*(1-j/data_per_ts)));
            end
        end
    end
end

y = fft(pattern2);
power = fftshift(10 * log10(abs(y) / data_count));

freq_diff = (0:data_count-1) ./ data_per_ts - (N/2);

plot(freq_diff, power)