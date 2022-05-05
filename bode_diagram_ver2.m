clear;clc;

fs = 44.1e3;
samples = [1,5*fs-1];
[u,fs] = audioread('chirp.wav',samples);
[y,fs] = audioread('chirp_out.wav',samples);

[Suy,f] = cpsd(u,y,[],[],[],fs);
[Suu,f] = cpsd(u,u,[],[],[],fs);
data = Suy./Suu;
absdata = abs(data);
theta = angle(data);

yg = 20*log10(absdata);
semilogx(f,yg)
xlim([20 20000])
ylim([-30 20])
title('Frequency Responcse')
xlabel('Hz')
ylabel('dB')
grid on
savefig('frequency_responcse.fig');
close

thetaplus = unwrap(theta);
yg = thetaplus/pi;
semilogx(f,yg)
xlim([20 20000])
ylim([-4 4])
title('Phase')
xlabel('Hz')
ylabel('Phase / \pi')
grid on
savefig('phase.fig');
close