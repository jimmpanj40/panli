function [bitsN,demapBin,an,an_hat] = ChaineOFDM(SNR0,Np,h,Ncp, M)
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);

bitsN=genBin(2*(Np-2)); %generate Np-4 bits. Np=256 so len=252
an=mappingGray(M,bitsN,mGray,mComplex);% QAM Modulation. len=252%4=63
xn=[0 an 0 fliplr(conj(an))];%
Xifft=ifft(xn);
Xc=[Xifft(end-(Ncp-1):end) Xifft];
Yc=filter(h,1,Xc);
Yc=Yc(1:Np+Ncp);
Yc2=canalAWGN(Yc,(M - 1)./(3*log2(M)*SNR0));
Y=Yc(Ncp+1:end);
Yfft=fft(Y,Np);
Hfft=fft(h,Np);
Xfft=Yfft./Hfft;
xn_hat=Xfft(2:Np/2);
an_hat=decision(xn_hat,mComplex);
demapBin0 = demapGray(an_hat,mGray,mComplex);
demapBin = double(demapBin0 == '1');




end
