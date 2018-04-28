% GOPH 557 Multidimensional Data Analysis and Processing
% F-K Transform
clear
clc

%%
%make a single linear event with positive time dip
dt=.004;t=(0:250)*dt;dx=2;x=(-250:250)*dx;
seis=zeros(length(t),length(x));
seis=event_dip(seis,t,x,[0 .2],[0 500],1);
seis=event_dip(seis,t,x,[0 .4],[0 500],1);

seisf=filtf(seis,t,[0 0],[60 10]);
figure;
imagesc(x,t,seis)
title('Unfiltered event')
[fks,f,k]=fktran(seis,t,x);
figure;
imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum before filter')
figure;
imagesc(x,t,seisf)
title('Filtered event')
[fks,f,k]=fktran(seisf,t,x);
figure;
imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum  after filter')

%%
%make a many events with the same time dip
dt=.004;t=(0:250)*dt;dx=10;x=(-100:100)*dx;
seis=zeros(length(t),length(x));
delt=[.01 .2];delx=[0 1000];
seis=event_dip(seis,t,x,delt,delx,1);
seisf=filtf(seis,t,[0 0],[60 10]);
figure;
imagesc(x,t,seisf)
[fks,f,k]=fktran(seisf,t,x);
figure;
imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, single event')
%add other events with the same dip
seis=event_dip(seis,t,x,delt,delx-200,1);
seis=event_dip(seis,t,x,delt+.3,delx-300,1);
seis=event_dip(seis,t,x,delt+.5,delx-500,1);
seis=event_dip(seis,t,x,delt+.1,delx-1000,1);
seisf=filtf(seis,t,[0 0],[60 10]);
figure;
imagesc(x,t,seisf)
[fks,f,k]=fktran(seisf,t,x);
figure;
imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, many events')
%%
close all
%make a single linear event with positive time dip
dt=.004;t=(0:250)*dt;dx=10;x=(-100:100)*dx;
seis=zeros(length(t),length(x));
seis=event_dip(seis,t,x,[.01 .2],[0 1000],1);
seisf=filtf(seis,t,[0 0],[60 10]);
figure;imagesc(x,t,seis)
title('Unfiltered event')
[fks,f,k]=fktran(seis,t,x);
figure;imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum before filter')
figure;imagesc(x,t,seisf)
title('Filtered event')
[fks,f,k]=fktran(seisf,t,x);
figure;imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum  after filter')
%%
%add in the corresponsing event with negative time dip
seis=event_dip(seis,t,x,[.01 .2],[0 -1000],1);
seisf=filtf(seis,t,[0 0],[60 10]);
figure;imagesc(x,t,seisf)
[fks,f,k]=fktran(seisf,t,x);
figure;imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum')
%%
close all
%put in some much steeper (slower) events
%we diliberately make events with different slopes left and right
seis=event_dip(seis,t,x,[.01 .8],[0 1000],1);
seis=event_dip(seis,t,x,[.01 1],[0 -1000],1);
seisf=filtf(seis,t,[0 0],[60 10]);
figure;imagesc(x,t,seisf)
[fks,f,k]=fktran(seisf,t,x);
figure;imagesc(k,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum')
%% 
%resample in x by selecting every other trace
seisf2=seisf(:,1:2:end);
x2=x(1:2:end);
figure;imagesc(x2,t,seisf2)
[fks,f,k2]=fktran(seisf2,t,x2);
figure;imagesc(k2,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, every 2nd trace')
%% 
%filter the previous back to 20 Hz
seisf2f=filtf(seisf2,t,[0 0],[20 5]);
figure;imagesc(x2,t,seisf2f)
[fks,f,k2]=fktran(seisf2f,t,x2);
figure;imagesc(k2,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, every 2nd trace, 0-20Hz')
%% 
%highpass filter above 30 hz
seisf2fh=filtf(seisf2,t,[30 5],[0 0]);
figure;imagesc(x2,t,seisf2fh)
[fks,f,k2]=fktran(seisf2fh,t,x2);
figure;imagesc(k2,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, every 2nd trace, 30 Hz and above')
%% 
%resample in x by selecting every third trace
seisf3=seisf(:,1:3:end);
x3=x(1:3:end);
figure;imagesc(x3,t,seisf3)
[fks,f,k3]=fktran(seisf3,t,x3);
figure;imagesc(k3,f,abs(fks));
xlabel('Wavenumber k_x (m^{-1})');ylabel('Frequency (Hz)');
title('FK spectrum, every 3rd trace')