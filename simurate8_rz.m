O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25;
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

center_wavelength = 1550 * 10 ^ (-9);
c = 3 * 10 ^ 8;
d = 20 * 10 ^ (-6);
l = 3 * 10 ^ 3;

b2 = -((d * center_wavelength ^ 2) / (2 * pi * c));
center_freq = c / center_wavelength;
freq = (0:data_count-1) ./ data_per_ts .* 10 ^ 9 + center_freq;
freq(data_count/2+1:data_count) = freq(data_count/2+1:data_count) - N * 10 ^ 9;
freq_diff = freq - center_freq;
phase_diff = -(b2 * l * (2 * pi * (freq - center_freq)) .^ 2) / 2;

y = fft(pattern2);
power = y .* exp(-j * (phase_diff));
pattern3 = ifft(power);

time_max = N * (ts * 10 ^ (-12));
t = (0:data_count-1) * (time_max / data_count);
plot(t, pattern3)
ylim([0, 1.5])
