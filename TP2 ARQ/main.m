

%% TP ARQ - Retransmissions 

%% I.4
n=2078;

Marq=0:20;

% SNR =10=SNR=10dB
SNR1=10;
epsilon1=qfunc((SNR1)^0.5)
Pe1=(1-(1-epsilon1)^2047)*2^(-(2078-2047))

Pc1=(1-epsilon1)^n;
Pd1=1-Pc1;
P_Marq1=(Pe1*(1-Pe1.^Marq)/(Pe1+Pc1)) + Pd1.^Marq

% SNR=100W=20dB
SNR2=100;
epsilon1=qfunc((SNR2)^0.5)
Pe2=(1-(1-epsilon1)^2047)*2^(-(2078-2047))
Pc2=(1-epsilon2)^n;
Pd2=1-Pc2;
P_Marq2=(Pe2*(1-Pe2.^Marq)/(Pe2+Pc2)) + Pd2.^Marq

%SNR=1000W=30dB
SNR3=1000;
epsilon1=qfunc((SNR3)^0.5)
Pe3=(1-(1-epsilon3)^2047)*2^(-(2078-2047))
Pc3=(1-epsilon3)^n;
Pd3=1-Pc3;
P_Marq3=(Pe3*(1-Pe3.^Marq)/(Pe3+Pc3)) + Pd3.^Marq

figure()
plot(Marq,P_Marq1)
hold on
plot(Marq,P_Marq2)
hold on
plot(Marq,P_Marq3)
title('P_{Marq}(E) in function of M_{arq} for several values of SNR in dB')
legend("SNR=10dB","SNR=20dB","SNR=30dB")
hold off

%%

