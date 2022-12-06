clear all;
close all;
clc;
format short g;

%% Exercice 1 Rayleigh Channel
%% 1.1 h fixed

M = 16;
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
N = M*M;
sigmab2 = 0.5;

% Initialisation of binary sequence, calculation of an and rn
bitsN = genBin(1,N);
an1 = mappingGray(M,bitsN,mGray,mComplex);
h=sqrt(1/2)*randn+1i*sqrt(1/2)*randn;
an2= h*an1; 

%% 1.2  Experimental binary and symbol error rates

g0 = 1;
M = 16;
T = 4*40000;
N=2;

% Normalised SNR
maxDB = 30;
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M - 1))./(3*log2(M)*normalisedNoise); % For M-QAM

symbErrorRateExp = zeros(1,maxDB+1); % init

% Communication chain
mComplex = const_M_QAM(M);
mGray = Gray_M_QAM(M);
binSeq = genBin(1,T);
an = mappingGray(M,binSeq,mGray,mComplex);


% Calculation of the error rate for each dB
for i = 1 : maxDB + 1
    symbError = 0;
    h=sqrt(1/2)*randn(N,T/4)+1i*sqrt(1/2)*randn(N,T/4); 

    an2= h.*an;

    rn=an2+sqrt(sigma2(i)).*randn(N,T/4) + 1i*sqrt(sigma2(i)).*randn(N,T/4); % add noise
    yn = conj(h).*rn./(abs(h).^2);
    anHat = decision(yn,mComplex);

    % Calculating bit and symbols error rate
    for q = 1 : length(an)
        if an(q) ~= anHat(q)
            symbError = symbError + 1;
        end
    end
    symbErrorRateExp(i) = symbError/length(an);
end

% Theoretical curve of error probability AWGN
symbErrorRateAWGN=4*((sqrt(M)-1)/(sqrt(M)))*0.5*erfc(sqrt(normalisedNoise*(3*log2(M))/(M-1))/sqrt(2));


%% Exercice 2 SIMO system - receive diversity


g0 = 1;
M_QAM = 16;
T = 4*40000; %40000 symbols
M=1;

% Normalised SNR
maxDB = 30; 
normalisedNoiseDB = 0 : maxDB;
normalisedNoise = 10.^(normalisedNoiseDB/10);

% Variance calculation
sigma2 = (g0^2*(M_QAM - 1))./(3*log2(M_QAM)*normalisedNoise);

symbErrorRateExp = zeros(1,maxDB+1);

% Communication chain
mComplex = const_M_QAM(M_QAM);
mGray = Gray_M_QAM(M_QAM);
binSeq = genBin(M,T);
an = mappingGray(M_QAM,binSeq,mGray,mComplex);

% N=1
N=1;
for i = 1 : maxDB + 1
    symbError = 0;
    yn=zeros(N,T/4);
    for k=1:T/4
        h=sqrt(1/2)*randn(N,M)+1i*sqrt(1/2)*randn(N,M);

        an2= h*an(:,k);

        rn=an2+sqrt(sigma2(i)).*randn(N,1) + 1i*sqrt(sigma2(i)).*randn(N,1);
        yn(:,k) = h'*rn/(norm(h)^2);
    end
        anHat = decision(yn,mComplex);

        % Calculating bit and symbols error rate
        for q = 1 : length(an)
            if an(q) ~= anHat(q)
                symbError = symbError + 1;
            end
        end
  
        symbErrorRateExp1(i) = symbError/length(an);
end
% N=2
N=2;
for i = 1 : maxDB + 1
    symbError = 0;
    yn=zeros(N,T/4);
    for k=1:T/4
        h=sqrt(1/2)*randn(N,M)+1i*sqrt(1/2)*randn(N,M);

        an2= h*an(:,k);

        rn=an2+sqrt(sigma2(i)).*randn(N,1) + 1i*sqrt(sigma2(i)).*randn(N,1);
        yn(:,k) = h'*rn/(norm(h)^2);
    end
        anHat = decision(yn,mComplex);

        % Calculating bit and symbols error rate
        for q = 1 : length(an)
            if an(q) ~= anHat(q)
                symbError = symbError + 1;
            end
        end
  
        symbErrorRateExp2(i) = symbError/length(an);
end

% N=3
N=3;
for i = 1 : maxDB + 1
    symbError = 0;
    yn=zeros(N,T/4);
    for k=1:T/4
        h=sqrt(1/2)*randn(N,M)+1i*sqrt(1/2)*randn(N,M);

        an2= h*an(:,k);

        rn=an2+sqrt(sigma2(i)).*randn(N,1) + 1i*sqrt(sigma2(i)).*randn(N,1);
        yn(:,k) = h'*rn/(norm(h)^2);
    end
        anHat = decision(yn,mComplex);

        % Calculating bit and symbols error rate
        for q = 1 : length(an)
            if an(q) ~= anHat(q)
                symbError = symbError + 1;
            end
        end
  
        symbErrorRateExp3(i) = symbError/length(an);
end

% N=4
N=4;
for i = 1 : maxDB + 1
    symbError = 0;
    yn=zeros(N,T/4);
    for k=1:T/4
        h=sqrt(1/2)*randn(N,M)+1i*sqrt(1/2)*randn(N,M);

        an2= h*an(:,k);

        rn=an2+sqrt(sigma2(i)).*randn(N,1) + 1i*sqrt(sigma2(i)).*randn(N,1);
        yn(:,k) = h'*rn/(norm(h)^2); %we compute it for all column
    end
        anHat = decision(yn,mComplex);

        % Calculating bit and symbols error rate
        for q = 1 : length(an)
            if an(q) ~= anHat(q)
                symbError = symbError + 1;
            end
        end
  
        symbErrorRateExp4(i) = symbError/length(an);
end
