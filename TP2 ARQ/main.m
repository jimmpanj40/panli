

%% TP ARQ - Retransmissions 

%% I.4
n=2078;

Marq=0:20;

% SNR=10=SNR=10dB
SNR1=10;
epsilon1=qfunc((SNR1)^0.5)

Pe1=(1-(1-epsilon1)^2047)*2^(-(2078-2047))
Pc1=(1-epsilon1)^n;
Pd1=1-Pc1;

P_Marq1=Pd1.^Marq*Pe1

% SNR=11dB
SNR2=11;
epsilon2=qfunc((SNR2)^0.5)

Pe2=(1-(1-epsilon2)^2047)*2^(-(2078-2047))
Pc2=(1-epsilon2)^n;
Pd2=1-Pc2;

P_Marq2=Pd2.^Marq*Pe2

%SNR=13dB
SNR3=13;
epsilon3=qfunc((SNR3)^0.5)

Pe3=(1-(1-epsilon3)^2047)*2^(-(2078-2047))
Pc3=(1-epsilon3)^n;
Pd3=1-Pc3;

P_Marq3=Pe3*Pd3.^Marq

figure()
plot(Marq,P_Marq1)
hold on
plot(Marq,P_Marq2)
hold on
plot(Marq,P_Marq3)
xlabel("M_{ARQ} number of retransmissions")
ylabel("P_{Marq}(E) probability not to detect an error ")
title('P_{Marq}(E) probability not to detect an error after M_{ARQ} retransmission for several values of SNR in dB')
legend("SNR=10dB","SNR=11dB","SNR=13dB")
grid on
hold off

%% III ARQ Simulation 
% (a)
k=112;
N=128;
sigma=1;
bitsN=motcrc(k,N);

% (b)
rn= channel(bitsN,1);

%(c)
crcdetect(bitsN,rn,k)
