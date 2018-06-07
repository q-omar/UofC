clc
%lab skills 1
%% channel model/velocity model (demoafdshotgather) (question 1) 
dx=5; %5m model 
xmax=3000; zmax=1500; vhigh=4000; vlow=1500; zchannel=zmax/2;
wchannel=10*dx; hchannel=5*dx; vchannel=2000; nlayers=9;
[vel,x,z]=channelmodel(dx,xmax,zmax,vhigh,vlow,zchannel,wchannel,hchannel,vchannel,nlayers);
imagesc(x,z,vel);colorbar;
title('Figure 1: 5m channel model')
xlabel('distance (m)')
ylabel('depth (m)')
prepfig;

%% ricker (demoafdshotgather)
fdom=30; dt=0.004; tmax=1.5; dtstep=0.001;
[w,tw]=ricker(dt,fdom);
xrec=(0:10:xmax);
[zos,seis,t]=afd_explode(dx,dtstep,dt,tmax,vel,xrec,zeros(size(xrec)),w,tw,2);
plotimage(zos,t,xrec)
title('Figure 2: Zero-offset section');
xlabel('Distance (m)');
ylabel('Time (s)'); prepfig;

%% add noise
s2n=2; 
zosn=zos;
for k=1:size(zos,2)
    tmp=zosn(:,k);
    n=rnoise(tmp,s2n);
    zosn(:,k)=tmp+n;
end
plotimage(zosn,t,xrec)
title('Figure 3: Noisy zero-offset section');
xlabel('Distance (m)');
ylabel('Time (s)'); prepfig;

%% fk spectra
[fkzos,f,k]=fktran(zos,t,xrec);
[fkzosn,f,k]=fktran(zosn,t,xrec);
plotimage(abs(fkzos),f,k); title('Figure 4: amplitude spectra of ZOS'); 
xlabel('Wavenumber k (m^-1)'); ylabel('Frequency (Hz)'); prepfig;
plotimage(abs(fkzosn),f,k); title('Figure 5: amplitude spectra of noisy ZOS'); 
xlabel('Wavenumber k (m^-1)'); ylabel('Frequency (Hz)'); prepfig;

%% 
%
%%
%%trace mixing (question 2) 
zosnm=conv2(zosn, ones(1,9)/9,'same');
plotimage(zosn,t,xrec); title('Figure 6: Noisy zero-offset section'); 
xlabel('Distance (m)');
ylabel('Time (s)'); prepfig;
plotimage(zosnm,t,xrec); title('Figure 7: noisy ZOS after trace mixing'); 
xlabel('Distance (m)');
ylabel('Time (s)'); prepfig;

%% fk
[fkzosnm,f,k]=fktran(zosnm,t,xrec);
plotimage(abs(fkzosnm),f,k); title('Figure 9: amplitude spectra of noisy ZOS after trace mixing');
xlabel('Wavenumber k (m^-1)'); ylabel('Frequency (Hz)'); prepfig;
plotimage(abs(fkzosn),f,k); title('Figure 8: amplitude spectra of noisy ZOS'); 
xlabel('Wavenumber k (m^-1)'); ylabel('Frequency (Hz)'); prepfig;

%% average
fkaven=mean(abs(fkzosn)); fkavenm=mean(abs(fkzosnm));
figure; 
plot(k,fkaven,'b',k,fkavenm,'r');
title('Figure 10: Average spectra'); xlabel('wavenumber (m^-1)'); 
legend('noisy trace','mixed trace'); prepfig;
