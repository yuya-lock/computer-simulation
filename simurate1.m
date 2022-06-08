O = 7;
N = 2^O-1;
pattern1 = prbs(O,N);

plot(pattern1)
axis([0, 125, -0.2, 1.2])