clear
clc
M = 16;
Np=128;
Ncp=16;
SNR0=10000000000;
h=[0.06, 0.72, 0.54, 0.36, 0.18, 0.114, 0.078, 0.054, 0.033, 0.018, 0.012];
[bitsN,demapBin,demapBin0,an,xn,Xifft,Xc,Yc,Yc2,Y,Yfft,Hfft,Xfft,xn_hat,an_hat]=ChaineOFDM(SNR0,Np,h,Ncp, M);

