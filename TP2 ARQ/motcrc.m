function [bitsN] = motcrc(k,N)
% Generation of a binary sequence
useful =randi([0,1],1,k);
crc=randi([0,1],1,N-k-1)
bitsN = [useful 1 crc]; % 1 to the first bits of the CRC

end

