clear all;
close all;
clc;
format short g;

%% ------------- Task 1: Simulating a Rayleigh channel ----------------- %%

%% Step 1

N = 5000;
sigma2 = 0.5;
X = sigma2 * randn(1,N);
Y = sigma2 * randn(1,N);

figure(1)
subplot(211)
histogram(X)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("X")
title("First i.i.d. zero-mean Gaussian random variables")
subplot(212)
histogram(Y)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("Y")
title("Second i.i.d. zero-mean Gaussian random variables")

% Variance
varX = var(X)
varY = var(Y)

%% Step 2

H = X + Y*j;
varH = var(H)

%% Step 3

modH = abs(H);
mod2H = modH.^2;

% Variance
varModH = var(modH);
varMod2H = var(mod2H);

figure(2)
subplot(211)
histogram(modH)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("module(H)")
title("Module of complex randoms variables of H")
subplot(212)
histogram(mod2H)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("module(H)²")
title("Squared module of complex randoms variables of H")


%% - Task 2 : Implementing the waterfilling power allocation algorithm - %%

%% Step 4

channelN = 128;
sigma2 = 0.5;
X = sigma2 * randn(1,channelN);
Y = sigma2 * randn(1,channelN);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');
Pav = mean(G);

figure(3)
plot(sortedG)
xlabel("Channel gains")
ylabel("Rank of gains values")
legend("G")
title("Sorted channel gains G")

%% Step 5

N0 = 1;
B = 1;
N = 128;

[an, am] = waterfilling(sortedG,N0,B,Pav,N);

%% Step 6
N=1000
Pav=1;
N0 = 1;
B = 1;

X = N0 * randn(1,N);
Y = N0 * randn(1,N);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');


[an, am] = waterfilling(sortedG,N0,B,Pav,N);

rate=sum(log2(1+am*Pav/N0))/length(am)

%% Step 7
N=1000;

N0 = 1;
B = 1;

X = N0 * randn(1,N);
Y = N0 * randn(1,N);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');

SNR_list=10.^([1,3,6,10,13,16]./10);
an_list=zeros(length(SNR_list),length(SNR_list));
am_list=zeros(length(SNR_list),length(SNR_list));
for i=1:length(SNR_list)
    [an,am] = waterfilling(sortedG,N0,B,SNR_list(i),N);
    
end