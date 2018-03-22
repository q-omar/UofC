%% AMAT 415 Assignment 3 
% Safian Omar Qureshi
% ID 10086638

%% Question 3(a)

N = 64;
a = 200;
n = linspace(0,63,64);
tn = n/N;
Xn = exp((-a)*(tn - 0.5).^2);


figure;
plot(tn,Xn);
xlabel('tn')
ylabel('Xn')
title('Xn vs tn')

%%
DFTXn = fft(Xn);
imDFTXn = imag(DFTXn);

figure;
plot(tn,DFTXn);
xlabel('tn')
ylabel('DFTXn')
title('DFTXn vs tn')

figure;
plot(tn,imDFTXn);
xlabel('tn')
ylabel('imDFTXn')
title('imDFTXn vs tn')

%% Question 3(b)

shiftDFTXn = fftshift(DFTXn);
shiftimDFTXn = fftshift(imDFTXn);

figure;
plot(tn,shiftDFTXn);
xlabel('tn')
ylabel('Shifted DFTXn')
title('Shifted DFTXn vs tn')

figure;
plot(tn,shiftimDFTXn);
xlabel('tn');
ylabel('Shifted imDFTXn');
title('Shifted imDFTXn vs tn');

%% Question 3(c)

DubXn = exp((-2*a)*(tn - 0.5).^2);
HafXn = exp((-0.5*a)*(tn - 0.5).^2);

figure;
plot(tn,DubXn);
xlabel('tn')
ylabel('Double a Xn')
title('Double a Xn vs tn')

figure;
plot(tn,HafXn);
xlabel('tn')
ylabel('Half a Xn')
title('Half a Xn vs tn')
%%

DFTDubXn = fft(DubXn);
DFTHafXn = fft(HafXn);
IMG_DFTDubXn = imag(DFTDubXn);
IMG_DFTHafXn = imag(DFTHafXn);

shiftDFTDubXn = fftshift(DFTDubXn);
shiftDFTHafXn = fftshift(DFTHafXn);
IMG_shift_DFTDubXn = fftshift(IMG_DFTDubXn);
IMG_shift_DFTHafXn = fftshift(IMG_DFTHafXn);

figure;
plot(tn, shiftDFTDubXn);
xlabel('tn')
ylabel('Shifted Double a DFTXn')
title('Shifted Double a DFTXn vs tn')

figure;
plot(tn, shiftDFTHafXn);
xlabel('tn')
ylabel('Shifted Half a DFTXn')
title('Shifted Half a DFTXn vs tn')

figure;
plot(tn, IMG_shift_DFTDubXn);
xlabel('tn')
ylabel('Imaginary Shifted Double a DFTXn')
title('Imaginary Shifted Double a DFTXn vs tn')

figure;
plot(tn, IMG_shift_DFTHafXn);
xlabel('tn')
ylabel('Imaginary Shifted Half a DFTXn')
title('Imaginary Shifted Half a DFTXn vs tn')
%% Question 3(d)

alternating_row = (-1).^[0:63];
alternatingDFTXn = (alternating_row).*(DFTXn);
inv_alternatingDFTXn = ifft(alternatingDFTXn);


figure;
plot(tn, inv_alternatingDFTXn);
xlabel('tn')
ylabel('Inverse DFT of Xn multiplied by [1,-1,...')
title('Inverse DFT of Xn multiplied by [1,-1,...] vs tn')
 
