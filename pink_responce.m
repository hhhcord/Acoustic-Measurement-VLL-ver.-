clear;clc;

fs = 44.1e3;
samples = [1,5*fs-1];
clear pn fs;
[pn,fs] = audioread('pink_out.wav',samples);

flims = [20 20e3];
bpo = 3;
opts = {'FrequencyLimits',flims,'BandsPerOctave',bpo};

poctave(pn,fs,opts{:});
savefig('data.fig');

hfig = open('data.fig');
ax = hfig.Children;
x = ax.Children.XData;
y = ax.Children.YData;

xHz = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];

meany = y;
[pks,locs] = findpeaks(meany);

threshold = mean(pks);
[pksh,locsh] = findpeaks(meany,'MinPeakHeight',threshold);

plot(meany);
hold on;
plot(locsh,meany(locsh),'ro');
hold off;
savefig('result.fig');

meanpksl = (sum(pks)-sum(pksh))/(numel(pks)-numel(pksh));
maxpksh = maxk(pksh,3);

for index = 1:numel(locsh)
    if pksh(index)==maxpksh(1)
        a = index;
    elseif pksh(index)==maxpksh(2)
        b = index;
    elseif pksh(index)==maxpksh(3)
        c = index;
    end
end

if isempty(a)==0
    disp(xHz(locsh(a)));
    disp('Hz');
    disp(pksh(a)-meanpksl);
    disp('dB減衰');
end
if isempty(b)==0
    disp(xHz(locsh(b)));
    disp('Hz');
    disp(pksh(b)-meanpksl);
    disp('dB減衰');
end
if isempty(c)==0
    disp(xHz(locsh(c)));
    disp('Hz');
    disp(pksh(c)-meanpksl);
    disp('dB減衰');
end