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
h=sqrt(1/2)*rand+j*sqrt(1/2)*rand;
an2= h*an1;

%% 1.2 

N = M*4;
sigmab2 = 0.5;

h=sqrt(1/2)*rand(1,N/4)+j*sqrt(1/2)*rand(1,N/4);


% Initialisation of binary sequence, calculation of an and rn
bitsN = genBin(N);
an1 = mappingGray(M,bitsN,mGray,mComplex);
an2= h.*an1;
yn = h'.*canalAWGN(an2,sigmab2)/abs(h);


% Calculating ân
an2 = decision(yn,mComplex);

x_an2 = real(an2(:));
y_an2 = imag(an2(:));

x_an = real(an1(:));
y_an = imag(an1(:));

% demapping
bitsn2 = demapGray(an2,mGray,mComplex);
bitsn2 = double(bitsn2 == '1');



%% Question 3 Experimental binary and symbol error rates

g0 = 1;
M = 16;
N = 4*10000;

% Normalised SNR
maxDB = 30;
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M - 1))./(3*log2(M)*normalisedNoise);

binErrorRateExp = zeros(1,13);
symbErrorRateExp = zeros(1,13);

% Communication chain
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(N);
an = mappingGray(M,binSeq,mGray,mComplex);

h=sqrt(1/2)*rand(1,N/4)+j*sqrt(1/2)*rand(1,N/4);
an2= h.*an;

% Calculation of the error rate for each dB
for i = 1 : maxDB + 1
    symbError = 0;
    rn=an2+sqrt(sigma2(i)).*randn(N/4,1) + j*sqrt(sigma2(i)).*randn(N/4,1);
    yn = conj(h)./(abs(h).^2).*rn;
    anHat = decision(yn,mComplex);

    % Calculating bit and symbols error rate
    for q = 1 : length(an)
        if an(q) ~= anHat(q)
            symbError = symbError + 1;
        end
    end
    
    
    symbErrorRateExp(i) = symbError/length(an);
end

%AWGN
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(N);
an = mappingGray(M,binSeq,mGray,mComplex);
for i = 1 : maxDB + 1
    symbErrorAWGN = 0;
    
    % Recalculating with new sigma2
    %rn = canalAWGN(an,sigma2(i));
    %anHat = decision(rn,mComplex);
    %demapBinSeq = demapGray(anHat,mGray,mComplex);
    %demapBinSeq = double(demapBinSeq == '1');
    
    [demapBinSeq,anHat] = chainCom(sigma2(i),N,M,binSeq,an);
    
    % Calculating bit and symbols error rate
    for j = 1 : length(an)
        if an(j) ~= anHat(j)
            symbErrorAWGN = symbErrorAWGN + 1;
        end
    end
    symbErrorRateExpAWGN(i) = symbErrorAWGN/length(an);
end


%% Question 4 Theoretical curve of error probability

% Calculating theoretical error probability
binErrorRateTh=4*((sqrt(M)-1)/(sqrt(M)*log2(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));
symbErrorRateTh=binErrorRateTh*log2(M);

%% Question 5 Complementary exercices
