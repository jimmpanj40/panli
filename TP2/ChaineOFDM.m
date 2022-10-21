function [bitsN,demapBin,demapBin0,an,xn,Xifft,Xc,Yc,Yc2,Y,Yfft,Hfft,Xfft,xn_hat,an_hat] = ChaineOFDM(SNR0,Np,h,Ncp, M)
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
bitsN=genBin(2*Np);
an=mappingGray(M,bitsN,mGray,mComplex);
xn=[0 an 0 fliplr(conj(an))];
Xifft=ifft(xn,Np);
Xc=[Xifft Xifft(1:Ncp)];
Yc=filter(h,1,Xc);
Yc2=canalAWGN(Yc,(M - 1)./(3*log2(M)*SNR0));
Y=Yc2(1:Np-Ncp);
Yfft=fft(Y,Np);
Hfft=fft(h,Np);
Xfft=Yfft./Hfft;
xn_hat=Xfft(2:Np/2+1);
an_hat=decision(xn_hat,mComplex);
demapBin0 = demapGray(an_hat,mGray,mComplex);
demapBin = double(demapBin0 == '1');


end
