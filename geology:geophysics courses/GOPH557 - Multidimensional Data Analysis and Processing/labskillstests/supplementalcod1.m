%% make velocity models
clear;
clc

dx10=10;%spatial grid size (same in x and z)

        xmax=3000;%length of model
        zmax=1500;%depth of model
        [vel10,x10,z10]=channelmodel(dx10,xmax,zmax);%make a velocity model
figure
imagesc(x10,z10,vel10);colorbar;%plot the 10 m velocity model
title('10m velocity model')
%% make a shot record at 10m
snap1=zeros(size(vel10));%snap1 is the wavefield before the source goes off
snap2=snap1;
%put souce at xmax/3, z=0
ixs=round(xmax/(3*dx10))+1;
snap2(5,ixs)=1;%snap2 is zero except at the source location
%make a shot record with the 5 point Laplacian
dtstep=.001;
dt=.004;
tmax=1.5;
fdom=20;%dominant frequency of wavelet
tmaxw=.4;%wavelet length
[w,tw]=wavemin(dt,fdom,tmaxw);%make a minimum phase wavelet
laplacian=1;
[shotrecord1,seis,t]=afd_shotrec(dx10,dtstep,dt,tmax,vel10,snap1,snap2,x10,zeros(size(x10)),w,tw,laplacian);
laplacian=2;
[shotrecord2,seis,t]=afd_shotrec(dx10,dtstep,dt,tmax,vel10,snap1,snap2,x10,zeros(size(x10)),w,tw,laplacian);
figure;
subplot(1,2,1)
imagesc(x10,t,shotrecord1)
caxis([-0.01 0.01]);
title('5 point Laplacian, dx=10')
%do over but with 9 point Laplacian
subplot(1,2,2)
imagesc(x10,t,shotrecord2)
caxis([-0.01 0.01]);
title('9 point Laplacian, dx=10')
prepfig
set(gcf,'position',[100 100 800 800])
colormap('gray');
