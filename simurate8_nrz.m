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

center_wavelength = 1550 * 10 ^ (-9);
c = 3 * 10 ^ 8;
d = 20 * 10 ^ (-7);
l = 3 * 10 ^ 3;

b2 = -((d * center_wavelength ^ 2) / (2 * pi * c));
center_freq = c / center_wavelength;
time_min = ts / data_per_ts;
freq = (0:data_count-1) * (1 / time_min / data_count) + center_freq;
freq(data_count/2+1:data_count) = freq(data_count/2+1:data_count) - (data_count * (1 / time_min / data_count));
freq_diff = freq - center_freq;
phase_diff = -(b2 * l * (2 * pi * (freq - center_freq)) .^ 2) / 2;

y = fft(pattern2);
power = y .* exp(-j * (phase_diff));
pattern3 = ifft(power);

time_max = N * ts;
t = (0:data_count-1) * (time_max / data_count);
plot(t, pattern3)
ylim([0, 1.5])