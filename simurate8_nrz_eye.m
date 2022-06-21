O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

ts = 25 * 10 ^ (-12);
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

d = 20;
center_wavelength = 1550 * 10 ^ (-9);
c = 3 * 10 ^ 8;
l = 3 * 10 ^ 3;
time_max = N * ts;

y = fftshift(fft(pattern2));
b2 = d * center_wavelength ^ 2 / (2 * pi * c);
for i = 1:N-1
    for j = 1:data_per_ts
        freq_diff = (i * data_per_ts + j - data_count / 2) * (1 / (time_max / data_count)) / data_count;
        phase_diff = b2 * l * (2 * pi * freq_diff) ^ 2 / 2 * 10 ^ (-6);
        y(i*data_per_ts+j) = y(i*data_per_ts+j) * exp(-1i * phase_diff); 
    end
end

pattern3 = abs(ifft(y));
eyediagram(pattern3.^2, 64)
ylabel('Amplitude')
ylim([-1.5, 1.5])