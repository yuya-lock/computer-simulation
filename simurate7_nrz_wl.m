O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25 * 10^(-12);
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

y = fft(pattern2.^2);
power = fftshift(10 * log10(abs(y) / data_count));

center_wavelength = 1550;
c = 3 * 10 ^ 8;
center_freq = c / center_wavelength;
time_min = ts / data_per_ts;
freq_diff = ((0:data_count-1) - data_count/2) * (1 / time_min / data_count) * 10 ^ (-9);
freq = freq_diff + center_freq;
wavelength = c ./ freq;

plot(wavelength, power)
ylim([-60, 0])
xlabel('波長 [nm]')