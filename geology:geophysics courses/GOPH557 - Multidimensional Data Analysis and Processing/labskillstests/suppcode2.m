 
dt=.002;%time sample size
nsmo=10;%number of points in spectral smoother
s2n=5;
[r,t]=reflec(2,dt);%synthetic reflectivity
[w,tw]=wavemin(dt,30,.2);%minimum phase wavelet
s=convm(r,w);%seismic trace is the convolution of r and w
noise=rnoise(s,s2n);
s=s+noise;
%%
figure(1);
plot(t,s);hold on;
legend('Trace (Before Filtering)')
% title('Trace');
% xlabel('Time (s)');
% ylabel('Amplitude');
% prepfig;
% set(gcf,'position',[100 100 1000 400]);
% axis([0 1 -0.02 0.02]);
%% compare specinv to spectrum of trace
[S,f]=fftrl(s,t);
figure(2)
%Aref=max(abs(S));
plot(f,real(todb(S)));hold on;
legend('Trace spectrum')
title('Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([0 250 -80 0]);
prepfig;
set(gcf,'position',[100 100 1000 400]);

%% band pass filtering
fmin=[0 10];
fmax=[20 30];
s_f=filtf(s,t,fmin,fmax);
figure(1);
plot(t,s_f,'red');hold on;
legend('Trace (Before Filtering)','Trace (After Filtering)')
title('Trace');
xlabel('Time (s)');
ylabel('Amplitude');
prepfig;
set(gcf,'position',[100 100 1000 400]);
axis([0 1 -0.02 0.02]);
%%
[S_f,f]=fftrl(s_f,t);
figure(2)
%Aref=max(abs(S));
plot(f,real(todb(S_f)),'red')
legend('Spectrum (Before Filtering)','Spectrum (After Filtering)')
title('Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
prepfig;
set(gcf,'position',[100 100 1000 400]);
