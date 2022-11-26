%% Tarea 9  Armando Cabrales

clear all;
close all;

[x,fs] = audioread('voice_mpx_44.wav');
x_sound = audioplayer(x, fs);

fx = fftshift(fft(x));
afx = abs(fx);
afx_sound = audioplayer(afx, fs);

plot(afx);
xlim([0 258858]);


%play(x_sound);
%% primer filtro
b1 = fir1(60, 0.1, 'low', hamming(61));

figure
plot(b1);

figure
plot(abs(freqz(b1, 1, 500)))

y1 = filter(b1, 1, x);

% frecuencia no desplazada
figure
plot(abs(fftshift(fft(y1))))
title('Frecuencia no desplazada');
xlim([0 258858]);

y1_sound = audioplayer(y1, fs);
%play(y1_sound);

%% segundo filtro
b2 = fir1(60, 0.7, 'high', hamming(61));
y2 = filter(b2, 1, x);

% frecuencia mas desplazada
figure
plot(abs(fftshift(fft(y2))))
title('Frecuencia más desplazada');
xlim([0 258858]);

y2_sound = audioplayer(y2, fs);
%play(y2_sound);

%% tercer filtro

b3 = fir1(60, [0.45 0.65], 'bandpass', hamming(61));
y3 = filter(b3, 1, x);

figure
plot(abs(freqz(b3, 1, 500)))

% segunda frecuencia mas desplazada
figure
plot(abs(fftshift(fft(y3))))
title('Segunda frecuencia más desplazada');
xlim([0 258858]);

y3_sound = audioplayer(y3, fs);
%play(y3_sound);

%% cuarto filtro

b4 = fir1(60, [0.2 0.4], 'bandpass', hamming(61));
y4 = filter(b4, 1, x);

figure
plot(abs(freqz(b4, 1, 500)))

% segunda frecuencia menos desplazada
figure
plot(abs(fftshift(fft(y4))))
title('Segunda frecuencia menos desplazada');
xlim([0 258858]);

y4_sound = audioplayer(y4, fs);
%play(y4_sound);

%% desplazar señales desplazadas

t2=0:1/fs:(length(y2)-1)/fs;
t3=0:1/fs:(length(y3)-1)/fs;
t4=0:1/fs:(length(y4)-1)/fs;

y2 = y2.';
y3 = y3.';
y4 = y4.';

dez4 = cos(2*pi*6800*t4);
dez3 = cos(2*pi*12500*t3);
dez2 = cos(2*pi*18500*t2);

s_dezplazada2 = y2.*dez2;
s_dezplazada3 = y3.*dez3;
s_dezplazada4 = y4.*dez4;

figure
plot(abs(fftshift(fft(s_dezplazada2))))

figure
plot(abs(fftshift(fft(s_dezplazada3))))

figure
plot(abs(fftshift(fft(s_dezplazada4))))

y_dez_sound = audioplayer(s_dezplazada2, fs);
%y_dez_sound = audioplayer(s_dezplazada3, fs);
%y_dez_sound = audioplayer(s_dezplazada4, fs);
play(y_dez_sound);
