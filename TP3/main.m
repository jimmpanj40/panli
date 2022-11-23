clear all;
close all;
clc;
format short g;

%% ------------- Task 1: Simulating a Rayleigh channel ----------------- %%

%% Step 1

N = 5000;
sigma2 = 0.5;
X = sqrt(sigma2) * randn(1,N);
Y = sqrt(sigma2) * randn(1,N);

figure(1)
subplot(211)

histogram(X)
axis([-3 3 0 350])

xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("X")
title("First i.i.d. zero-mean Gaussian random variables")
subplot(212)
histogram(Y)
axis([-3 3 0 350])

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
G = abs(H).^2;

% Variance
varModH = var(modH);
varG = var(G);

figure(2)
subplot(211)
histogram(modH)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("modH=|H|")
title("Module of complex randoms variables of H")
subplot(212)
histogram(G)
xlabel("Gaussian random variable")
ylabel("Number of samples")
legend("G=|H|^2")
title("Squared module of complex randoms variables of H")


%% - Task 2 : Implementing the waterfilling power allocation algorithm - %%

%% Step 4

N = 128;
sigma2 = 0.5;
X = sigma2 * randn(1,N);
Y = sigma2 * randn(1,N);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');
Pav=mean(G);
figure(3)
plot(sortedG)
xlabel("Rank of gains values")
ylabel("Channel gains")
legend("G")
title("Sorted channel gains G")

%% Step 5

N0 = 1;
B = 1;
N = 128;

[an, am,P_allocated] = waterfilling(sortedG,N0,B,Pav,N);


figure(4)
subplot(211)
axis([0 N 0 5])
bar(an)
axis([0 N 0 max(an)])
xlabel("Rank of gains value")
ylabel("Gain")
legend("Entry")


subplot(212)
bar(am)
axis([0 length(an) 0 max(an)])
xlabel("Rank of gains value")
ylabel("Gain")
legend("Output")

figure(5)
subplot(211)

axis([0 length(an) 0 max(1./an)])
bar(fliplr(1./an))
axis([0 N 0 max(1./an)])
xlabel("Rank of gains value")
ylabel("Gain")

hold on
bar([zeros(1,length(an)-length(am)) fliplr(1./am)])
axis([0 length(an) 0 max(1./an)])
xlabel("Rank of gains value")
ylabel("1/an")
legend("Entry","Output")

subplot(212)
axis([0 length(an) 0 20])
bar(fliplr(1./an))
axis([0 N 0 max(1./an)])
xlabel("Rank of gains value")
ylabel("Gain")

hold on
bar([zeros(1,length(an)-length(am)) fliplr(1./am)])
axis([0 length(an) 0 20])
xlabel("Rank of gains value")
ylabel("1/an")
legend("Entry","Output")

%Power allocated 
figure(6)
subplot(212)
bar(fliplr(P_allocated))
xlabel("Rank of the channel m")
ylabel("P_allocated to the channel m")

subplot(211)
bar(fliplr(1./am))
xlabel("Rank of the channel m")
ylabel("1/am")


%% Step 6
N2=1000
Pav=1;
N0 = 1;
B = 1;

X = N0 * randn(1,N2);
Y = N0 * randn(1,N2);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');


[an, am] = waterfilling(sortedG,N0,B,Pav,N2);

rate=sum(log2(1+am*Pav/N0))/length(am)

%% Step 7
N2=1000;

N0 = 1;
B = 1;

X = N0 * randn(1,N2);
Y = N0 * randn(1,N2);
H = X + Y*1i;
G = abs(H).^2;
sortedG = sort(G,'descend');

SNR_list=10.^([1,3,6,10,13,16]./10);
an_list=zeros(length(SNR_list),length(SNR_list));
am_list=zeros(length(SNR_list),length(SNR_list));
for i=1:length(SNR_list)
    [an,am] = waterfilling(sortedG,N0,B,SNR_list(i),N2);
    
end