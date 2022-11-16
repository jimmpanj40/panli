function [bitsN,demapBin,an,an_hat] = ChaineOFDM(SNR0,Np,h,Ncp, M)
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);

bitsN=genBin(2*(Np-2)); %generating Np-4 bits. Np=256 so len=252

    an=mappingGray(M,bitsN,mGray,mComplex);% QAM Modulation. len=252%4=63
    xn=[0 an 0 fliplr(conj(an))];%hermitian symmetry
    Xifft=ifft(xn);% Inverse Fourier Transforming
    Xc=[Xifft(end-(Ncp-1):end) Xifft]; %Adding cyclic prefix
    Yc=conv(Xc,h);%Filtering 
    Yc=Yc(1:Np+Ncp);


    Yc2=canalAWGN(Yc,(M - 1)./(3*log2(M)*SNR0));%adding noise
    Y=Yc2(Ncp+1:end);%removing the cyclic prefix
    Yfft=fft(Y);%Fast Fourier Transform for Y

    Hfft=fft(h,Np);%%Fast Fourier Transform for H
    Xfft=Yfft./Hfft;%Frequency Equalization
    xn_hat=Xfft(2:Np/2);%Inverse hermitian symmetry
    an_hat=decision(xn_hat,mComplex);%Decision
    demapBin0 = demapGray(an_hat,mGray,mComplex); %demapping
    demapBin = double(demapBin0 == '1'); %converting to double




end
