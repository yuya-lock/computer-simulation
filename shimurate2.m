O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25;
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

time_length = N * (ts * 10^(-12));
tmp = time_length/4064;
t = (0:4063)*(tmp);
plot(t, pattern2)
ylim([-0.2, 1.2])
xlabel('時間 [s]')