
%% Q2
clear
clc
M = 16;
Np=128;
Ncp=16;
SNR0=1;
h=[0.06, 0.72, 0.54, 0.36, 0.18, 0.114, 0.078, 0.054, 0.033, 0.018, 0.012];
[bitsN,demapBin,an,an_hat]=ChaineOFDM(SNR0,Np,h,Ncp, M);
err=sum(abs(bitsN-demapBin))/length(bitsN);
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
%% Q3
K=100;
err_bin=0;
err_symb=0;
SNR0=10;

maxdB=20;
for i = 1:K
    [bitsN,demapBin,an,an_hat] = ChaineOFDM(SNR0,Np,h,Ncp,M);

    err_symb=nnz(an-an_hat)/length(an);
    
    err_bin=sum(abs(bitsN-demapBin))/length(demapBin);

    
end
err_bin=err_bin/K
err_symb=err_symb/K




%%

K=20;
err_bin=0;
err_symb=0;
maxDB=12;
BER=zeros(1,maxDB+1);
SER=zeros(1,maxDB+1);
for j=1:maxDB+1
    for i = 1:K
        [bitsN,demapBin,an,an_hat] = ChaineOFDM(j,Np,h,Ncp,M);

        err_bin=sum(abs(bitsN-demapBin))/length(demapBin);
        err_symb=nnz(an-an_hat)/length(an);
        
    end
    
    BER(j)=err_bin/K;
    SER(j)=err_symb/K;
end

%%
semilogy(10*log10(BER),'r')
hold on 
semilogy(10*log10(SER),'b')
