fs = 8000;
t = 0:1/fs:1-1/fs;
x = 0.5*sin(2*%pi*440*t) + 0.3*sin(2*%pi*880*t);
noise = 0.4*grand(1, length(t), "nor", 0, 1);
xn = x + noise;

N_filt = 20;
b = ones(1, N_filt) / N_filt;
xf = convol(b, xn);
xf = xf(1:length(xn));

scf(0);
clf();

subplot(3,2,1);
plot(t(1:400), x(1:400));
title("Original Signal (440 Hz + 880 Hz)");
xlabel("Time (s)");
ylabel("Amplitude");

subplot(3,2,2);
X_spec = abs(fft(x));
N_pts = length(X_spec);
freq = (0:N_pts-1) * fs / N_pts;
half = floor(N_pts/2);
plot(freq(1:half), X_spec(1:half));
title("Spectrum of Original");
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(3,2,3);
plot(t(1:400), xn(1:400));
title("Noisy Signal");
xlabel("Time (s)");
ylabel("Amplitude");

subplot(3,2,4);
Xn_spec = abs(fft(xn));
plot(freq(1:half), Xn_spec(1:half));
title("Spectrum of Noisy Signal");
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(3,2,5);
plot(t(1:400), xf(1:400));
title("Filtered Signal (Moving Average)");
xlabel("Time (s)");
ylabel("Amplitude");

subplot(3,2,6);
Xf_spec = abs(fft(xf));
plot(freq(1:half), Xf_spec(1:half));
title("Spectrum of Filtered Signal");
xlabel("Frequency (Hz)");
ylabel("Magnitude");

savewave("original_audio.wav", x, fs);
savewave("noisy_audio.wav", xn, fs);
savewave("filtered_audio.wav", xf, fs);
