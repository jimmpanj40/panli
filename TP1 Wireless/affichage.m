%% 1 Rayleigh Channel
% 1.1 h fixed

% Initialisation of the scale
x1 = real(an1(:));
y1 = imag(an1(:));

x2 = real(an2(:));
y2 = imag(an2(:));
z = mGray(:);

% adding Gray code
for k = 1 : M
    text(x(k)-0.6,y(k)+0.3,...
        dec2base(z(k),2,log2(M)),'Color',[1 0 0]);
end

figure()
scatter(x1,y1,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);
title('Representation of Gray mapping');
xlabel('I');
ylabel('Q');
grid on
legend('QAM')

figure()
scatter(x2,y2,50,'r*');          
axis([-sqrt(M)*sqrt(2) sqrt(M)*sqrt(2) -sqrt(M)*sqrt(2) sqrt(M)*sqrt(2)]);
title('Representation of Gray mapping');
xlabel('I');
ylabel('Q');
grid on
legend('QAM after rotation du to h')

%% 1.2

% dessiner les points de la constellation


figure()
hold on;

scatter(x_an,y_an,50,'m*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

scatter(x_anHat,y_anHat,50,'r');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% figure parameters
title('Representation of an and ân sequences');
xlabel('I');
ylabel('Q');
legend('an','ân')
grid on

%% Question 3 Experimental binary and symbol error rates

figure()
semilogy(normalisedNoiseDB,symbErrorRateExp)
hold on
semilogy(normalisedNoiseDB,symbErrorRateExpAWGN)

title("Experimental error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Symbol error rate")
ylim([0.0001 1.1])
legend('Rayleigh','AWGN')

%% Question 4 Theoretical curve of error probability
figure()
semilogy(normalisedNoiseDB,binErrorRateTh)
hold on
semilogy(normalisedNoiseDB,symbErrorRateTh)
title("Theoretical error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Bit error rate")
%ylim([0 1.6])
legend("Bit error rate","Symbol error rate")
