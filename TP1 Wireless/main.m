clear all;
close all;
clc;
format short g;

%% 1 Rayleigh Channel
%% 1.1 h fixed

M = 16;
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
N = M*M;
sigmab2 = 0.5;

% Initialisation of binary sequence, calculation of an and rn
bitsN = genBin(N);
an1 = mappingGray(M,bitsN,mGray,mComplex);
h=sqrt(1/2)*randn+1i*sqrt(1/2)*randn;
an2= h*an1;

%% 1.2  Experimental binary and symbol error rates

g0 = 1;
M = 16;
T = 4*40000;
N=1;

% Normalised SNR
maxDB = 30;
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M - 1))./(3*log2(M)*normalisedNoise);

symbErrorRateExp = zeros(1,maxDB+1);

% Communication chain
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(T);
an = mappingGray(M,binSeq,mGray,mComplex);


% Calculation of the error rate for each dB
for i = 1 : maxDB + 1
    symbError = 0;
    h=sqrt(1/2)*randn(N,T/4)+1i*sqrt(1/2)*randn(N,T/4);

    an2= h.*an;

    rn=an2+sqrt(sigma2(i)).*randn(1,T/4) + 1i*sqrt(sigma2(i)).*randn(1,T/4);
    yn = conj(h).*rn./(abs(h).^2);
    anHat = decision(yn,mComplex);

    % Calculating bit and symbols error rate
    for q = 1 : length(an)
        if an(q) ~= anHat(q)
            symbError = symbError + 1;
        end
    end
    
    symbError
    symbErrorRateExp(i) = symbError/length(an);
end

% Theoretical curve of error probability AWGN
symbErrorRateAWGN=4*((sqrt(M)-1)/(sqrt(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));


%% Question 4 Theoretical curve of error probability

% Calculating theoretical error probability
binErrorRateTh=4*((sqrt(M)-1)/(sqrt(M)*log2(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));
symbErrorRateTh=binErrorRateTh*log2(M);

%% Question 5 Complementary exercices
