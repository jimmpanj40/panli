%% Exercice  1 Rayleigh Channel
%% 1.1 h fixed
% Initialisation of the scale
x = real(mComplex(:));
y = imag(mComplex(:));
z = mGray(:);


% Initialisation of the scale
x1 = real(an1(:));
y1 = imag(an1(:));

x2 = real(an2(:));
y2 = imag(an2(:));

% adding Gray code
for k = 1 : M
    text(x(k)-0.6,y(k)+0.3,...
        dec2base(z(k),2,log2(M)),'Color',[1 0 0]);
end


figure()
scatter(x2,y2,50,'r*');          
axis([-sqrt(M)*sqrt(2) sqrt(M)*sqrt(2) -sqrt(M)*sqrt(2) sqrt(M)*sqrt(2)]);
title('Representation of Gray mapping');
xlabel('I');
ylabel('Q');
grid on
legend('QAM after rotation du to h')

%% 1.2

figure()
semilogy(normalisedNoiseDB,symbErrorRateAWGN) 
hold on
semilogy(normalisedNoiseDB,symbErrorRateExp1)


title("SISO Experimental error rate curve ")
xlabel("Normalised SNR in dB")
ylabel(" Symbol error rate")
ylim([0.0001 1.1])
legend('Rayleigh','AWGN')

%% Exercice 2

figure()
semilogy(normalisedNoiseDB,symbErrorRateExp2)
hold on
semilogy(normalisedNoiseDB,symbErrorRateExp3)
hold on
semilogy(normalisedNoiseDB,symbErrorRateExp4)
hold off

title("SIMO Experimental error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Symbol error rate")
ylim([0.0001 1.1])
legend('N=2','N=3','N=4')

%% Exercice 3
