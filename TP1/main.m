clear all;
close all;
clc;
format short g;

%% Constellation M-QAM

% Initialisation of the constellation size, its complex and gray code
% M is the size of the constellation
% mComplex : matrix containing complex symbols
% mGray : matrix containing Gray code
M = 16;
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);

% Initialisation of the scale
x = real(mComplex(:));
y = imag(mComplex(:));
z = mGray(:);

% new figure
figure(1)
hold on
% Plot constellation's points
scatter(x,y,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% adding Gray code
for k = 1 : M
    text(x(k)-0.6,y(k)+0.3,...
        dec2base(z(k),2,log2(M)),'Color',[1 0 0]);
end

% parametres figure
title('Gray coding of M-QAM');
xlabel('I');
ylabel('Q');
grid on

%---------AWGN------------

% Definition of varation and sequence's size
N = 64;
sigmab2 = 0.5;

% Initialisation of binary sequence, calculation of an and rn
bitsN = genBin(N)
an = mappingGray(M,bitsN,mGray,mComplex)
rn = canalAWGN(an,sigmab2)

% Initialisation of the scale
x_rn = real(rn(:));
y_rn = imag(rn(:));

% new figure
figure(2)

% dessiner les points de la constellation
scatter(x_rn,y_rn,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% parametres figure
title('Representation of rn sequence');
xlabel('I');
ylabel('Q');
grid on

%-----------Receiver------------

% Calculating ân
an2 = decision(rn,mComplex)

figure(3)
hold on;
x_an2 = real(an2(:));
y_an2 = imag(an2(:));

x_an = real(an(:));
y_an = imag(an(:));

scatter(x_an,y_an,50,'m*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

scatter(x_an2,y_an2,50,'r');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

scatter(x_rn,y_rn,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% figure parameters
title('Representation of an, rn and ân sequences');
xlabel('I');
ylabel('Q');
legend('an','ân','rn')
grid on

% demapping
bitsn2 = demapGray(an2,mGray,mComplex)
bitsn2 = double(bitsn2 == '1');


%% Question 3

clear all;
close all;
clc;
format short g;

g0 = 1;
M = 16;
N = 32768;

% Normalised SNR
maxDB = 25;
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M^2 - 1))./(6*log2(M)*normalisedNoise);

binErrorRateExp = zeros(1,13);
symbErrorRateExp = zeros(1,13);

mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(N);
an = mappingGray(M,binSeq,mGray,mComplex);

% Calculation of the error rate for each dB
for i = 1 : maxDB + 1
    binError = 0;
    symbError = 0;
    
    % Recalculating with new sigma2
    rn = canalAWGN(an,sigma2(i));
    anHat = decision(rn,mComplex);
    demapBinSeq = demapGray(anHat,mGray,mComplex);
    demapBinSeq = double(demapBinSeq == '1');
    
    for j = 1 : length(an)
        if an(j) ~= anHat(j)
            symbError = symbError + 1;
        end
    end
    
    for k = 1 : length(binSeq)
        if binSeq(k) ~= demapBinSeq(k)
            binError = binError + 1;
        end
    end
    
    binErrorRateExp(i) = binError/length(binSeq);
    symbErrorRateExp(i) = symbError/length(an);
end

figure()
semilogy(normalisedNoiseDB,binErrorRateExp)
hold on
semilogy(normalisedNoiseDB,symbErrorRateExp)
title("Error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Bit error rate")
ylim([0.0001 1])
legend("Bit error rate","Symbol error rate")

%%
binErrorRateTh=4*((sqrt(M)-1)/(sqrt(M)*log2(M)))*0.5*erfc(sqrt(normalisedNoise*6*log2(M)/(M^2-1))/sqrt(2));
symbErrorRateTh=binErrorRateTh*log2(M);
figure()
semilogy(normalisedNoiseDB,binErrorRateTh)
hold on
semilogy(normalisedNoiseDB,symbErrorRateTh)
title("Theorical error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Bit error rate")
ylim([0 1.6])
legend("Bit error rate","Symbol error rate")
