%GOPH 557 
%Safian Omar Qureshi
%ID 10086638
%Lab Skills 1

%% Question 1
% Creating channel model 

dx=5; 
xmax=3000; %simply inputting variables given 
zmax=1500; 
vhigh=4000; 
vlow=1500; 
zchannel=zmax/2;
wchannel=10*dx; 
hchannel=5*dx; 
vchannel=2000; 
nlayers=9;
[vel,xrec,z] = channelmodel(dx,xmax,zmax,vhigh,vlow,zchannel,wchannel,hchannel,vchannel,nlayers); %creating model

imagesc(xrec,z,vel); %using imagesc function here to plot figure 
colorbar;
title('Figure 1 - 5 meter model')
xlabel('x distance (m)')
ylabel('z distance (m)')
%% Creating 30Hz Ricker wavelet to produce 0-offset section (zos) 

dt=0.004; 
spacing=0.001;
tmax=1.5; 
hertz=30; 
xrec=(0:10:xmax);

[w,tw] = ricker(dt,hertz); %creating wavelet 
[zos,seis,t] = afd_explode(dx,spacing,dt,tmax,vel,xrec,zeros(size(xrec)),w,tw,2); %producing section

plotimage(zos,t,xrec)
colormap('gray')
title('Figure 2 - 0-offset section');
xlabel('distance (m)');
ylabel('time (s)');

%% Creating noisy 0-offset section (zosn)

s2n=2; 

zosn=zos;
for k=1:size(zos,2)
    tmp=zosn(:,k);
    n=rnoise(tmp,s2n);
    zosn(:,k)=tmp+n;
end

plotimage(zosn,t,xrec)
colormap('gray')
title('Figure 3 - 0-offset section (noisy)');
xlabel('distance (m)');
ylabel('time (s)');

%% Creating fk spectra of 0-offset section (no noise and noisy) 

[fkzos,f,k] = fktran(zos,t,xrec); %fk spectra no noise
[fkzosn,f,k] = fktran(zosn,t,xrec); %fk spectra noisy

plotimage(abs(fkzos),f,k); 
title('Figure 4 - amplitude spectra of 0-offset section (no noise)'); 
xlabel('wavenumber k (m^-1)'); 
ylabel('frequency (hz)');

plotimage(abs(fkzosn),f,k); 
title('Figure 5 - amplitude spectra of 0-offset section (noisy)'); 
xlabel('wavenumber k (m^-1)'); 
ylabel('frequency (hz)'); 



%% Question 2
% trace mixing 

zosnm=conv2(zosn, ones(1,9)/9,'same'); %using command given 

plotimage(zosn,t,xrec); %this plotimage function is taking identical parameters as one in line 54
title('Figure 6 - 0-offset section (noisy)'); 
xlabel('distance (m)');
ylabel('time (s)'); 

plotimage(zosnm,t,xrec); 
title('Figure 7 - 0-offset section (noisy) trace mixing'); 
xlabel('distance (m)');
ylabel('time (s)'); 

%% Creating fk spectra of 0-offset section (with and without trace mixing) 

[fkzosnm,f,k] = fktran(zosnm,t,xrec);

plotimage(abs(fkzosn),f,k); %this plotimage function is taking identical parameters as one in line 69
title('Figure 8 - amplitude spectra of 0-offset section (noisy)'); 
xlabel('wavenumber k (m^-1)'); 
ylabel('frequency (hz)')

plotimage(abs(fkzosnm),f,k); 
title('Figure 9 - amplitude spectra of 0-offset section (noisy) trace mixing');
xlabel('wavenumber k (m^-1)'); 
ylabel('frequency (hz)'); 


%% Creating average spectra 
fkaven=mean(abs(fkzosn)); %noisy, non mixed
fkavenm=mean(abs(fkzosnm)); %noisy, trace mixed 

figure; 
plot(k,fkaven,'b',k,fkavenm,'r');
title('Figure 10 - average spectra'); 
xlabel('wavenumber k (m^-1)'); 
legend('noisy trace','trace mixing');

