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

H = X + Y*j; %Complex random signal
varH = var(H)

%% Step 3

modH = abs(H);
G = abs(H).^2; % Gain of our complex random signal

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
sortedG = sort(G,'descend'); % sorting the gains
Pav=mean(G); % Power average = mean gain
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

[an, am,P_allocated] = waterfilling(sortedG,N0,B,Pav,N); %waterfilling power allocation


figure(4) %entry
subplot(211)
axis([0 N 0 5])
bar(an)
axis([0 N 0 max(an)])
xlabel("Rank of gains value")
ylabel("Gain")
legend("Entry")


subplot(212)%output after waterfilling
bar(am)
axis([0 length(an) 0 max(an)])
xlabel("Rank of gains value")
ylabel("Gain")
legend("Output")

figure(5) % plotting with water level explanation
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

%Power allocated  : showing relation between the power allocated and the
%inverse of the gain
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


[an, am, P_allocated] = waterfilling(sortedG,N0,B,Pav,N2);

av_rate=sum(log2(1+am.*P_allocated/N0))/length(am) %average rate

%% Step 7
N2=1000;
Pav_list_dB=[1,3 6 10 13 16]; % Pav=SNR here
Pav_list= 10.^(Pav_list_dB/10)
N0 = 1;
B = 1;

X = N0 * randn(1,N2);
Y = N0 * randn(1,N2);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');
sum_rate=zeros(1,length(Pav_list));

for i=1:length(Pav_list) % calculation of the average rate for each SNR
    [an, am, P_allocated] = waterfilling(sortedG,N0,B,Pav_list(i),N2);
    sum_rate(i)=sum(log2(1+am.*P_allocated/N0))/length(am)/B
end

figure(7)
plot(Pav_list_dB,sum_rate)
xlabel("SNR in dB")
ylabel("Sum rate in  bps/Hz")
title("Sum rate (bps/Hz) in function of SNR (dB)")

%% Step 8

N_list=[16,64,128,256,512,1024,2048,4096]; 
Pav=1;
N0 = 1;
B = 1;


sum_rate=zeros(1,length(N_list));

for i=1:length(N_list) % calculation of the average rate for each N
    X = N0 * randn(1,N_list(i));
    Y = N0 * randn(1,N_list(i));
    H = X + Y*j;
    G = abs(H).^2;
    sortedG = sort(G,'descend');
    [an, am, P_allocated] = waterfilling(sortedG,N0,B,Pav,N_list(i));
    sum_rate(i)=sum(log2(1+am.*P_allocated/N0))/length(am)/B
end

figure(7)
plot(N_list,sum_rate)
xlabel("Number of samples N")
ylabel("Sum rate in bps/Hz")
title("Sum rate (bps/Hz) in function of N")


%% Step 9

N_opt=1024; %This value of N is good according to step 8
Pav=1;
N0 = 1;
B = 1;

X = N0 * randn(1,N_opt);
Y = N0 * randn(1,N_opt);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');

sum_rate_eq=sum(log2(1+sortedG*Pav/N0))/length(am) %the power allocated is Pav=Ptotal/N

%% Step 10


N_opt=1024;
Pav_list_dB=[1 3 6 10 13 16]; % Pav=SNR here
Pav_list= 10.^(Pav_list_dB/10)
N0 = 1;
B = 1;

X = N0 * randn(1,N2);
Y = N0 * randn(1,N2);
H = X + Y*j;
G = abs(H).^2;
sortedG = sort(G,'descend');
sum_rate_water=zeros(1,length(Pav_list));
sum_rate_equal=zeros(1,length(Pav_list));

for i=1:length(Pav_list)
    [an, am, P_allocated] = waterfilling(sortedG,N0,B,Pav_list(i),N2);
    sum_rate_water(i)=sum(log2(1+am.*P_allocated/N0))/length(am)/B %waterfilling sum rate
    sum_rate_equal(i)=sum(log2(1+am.*Pav_list(i)/N0))/length(am)/B %equal power allocation sum rate
end

figure(8)
plot(Pav_list_dB,sum_rate_water)
hold on 
plot(Pav_list_dB,sum_rate_equal)

xlabel("SNR in dB")
ylabel("Sum rate in  bps/Hz")
title("Sum rate (bps/Hz) in function of SNR (dB)")
legend('waterfilling algorithm power allocation','equal power allocation')