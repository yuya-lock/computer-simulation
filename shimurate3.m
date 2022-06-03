O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 400;
data_per_ts = 32;

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

eyediagram(pattern2 .^ 2, 64)
ylabel('Amplitude')
ylim([-0.2, 1.2])