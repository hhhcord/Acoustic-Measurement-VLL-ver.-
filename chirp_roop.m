clear;clc;

fs = 44.1e3;
f1 = 20;
f2 = 20e3;
T = 5;

dBF = -4;
A = 10^(dBF/20);

len = T*fs;

for index = 1:len-1
    data(index) = A*sin((2*pi*f1*T)/(log(f2/f1))*(exp((index/(T*fs))*log(f2/f1))-1));
    all_data(index) = data(index);
end

for index = len:2*len-2
    all_data(index) = data(index-len+1);
end

audiowrite('chirp_roop.wav', all_data, fs);