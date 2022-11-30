function [rn] = canalAWGN(an,sigmab2)
%canalAWGN Summary of this function goes here
% Creation of the noise with a real and an imaginary part
N = length(an);
bn = sqrt(sigmab2).*randn(N,1) + j*sqrt(sigmab2).*randn(N,1);
rn = an + bn';
size(rn)
end

