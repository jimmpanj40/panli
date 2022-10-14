function [OFDM] = ChaineOFDM(SNR0,Np,h,Ncp, M)
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
an=mappingGray(M,bitsN,mGray,mComplex)
xn=an'
Xfft=ifft(xn,Np)

end
