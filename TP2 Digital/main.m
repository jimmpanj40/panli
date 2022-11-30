warning('off')
%% Q2
clear
clc

M = 16;
Np=128;
Ncp=16;
SNR0=12; %Normalised noise

h=[0.06, 0.72, 0.54, 0.36, 0.18, 0.114, 0.078, 0.054, 0.033, 0.018, 0.012];
[bitsN,demapBin,an,an_hat]=ChaineOFDM(SNR0,Np,h,Ncp, M);

err=sum(abs(bitsN-demapBin))/(2*(Np-2)); %BER

%% Q3 SER and BER for one value of SNR0
K=10; %making the calculation K times to find the average error
err_bin=zeros(1,K);
err_symb=zeros(1,K);
SNR0=100; %Normalised noise

for i = 1:K
    [bitsN,demapBin,an,an_hat] = ChaineOFDM(SNR0,Np,h,Ncp,M);

    err_symb(i)=nnz(an-an_hat);
    err_bin(i)= sum(abs(bitsN-demapBin));
    
end
moy_err_bin=sum(err_bin)/K/(2*(Np-2))/4
moy_err_symb=sum(err_symb)/K/(2*(Np-2))
%% Q3 bis SER and BER for several values of SNR0
K=10;
err_bin=zeros(1,K);
err_symb=zeros(1,K);

maxdB=20; %Max Normalised noise

moy_err_bin=zeros(1,maxdB+1);
moy_err_symb=zeros(1,maxdB+1);

for j=1:maxdB+1 %make the caculation for SNR from 0 to 21
    for i = 1:K
        [bitsN,demapBin,an,an_hat] = ChaineOFDM(j,Np,h,Ncp,M);

        err_symb(i)= nnz(an-an_hat);%counting the number of error between symbols
        err_bin(i)=sum(abs(bitsN-demapBin)); %counting the number of error between bits

    end
    moy_err_bin(j)=sum(err_bin)/K/(2*(Np-2))/4; %give the average BER 
    moy_err_symb(j)=sum(err_symb)/K/(2*(Np-2)); %give the average SER 
 
end



%%Ploting
semilogy(10*log10(moy_err_bin),'r')
hold on 
semilogy(10*log10(moy_err_symb),'b')
