function [bitsN,bitsn2,an,an_hat] = chainCom(sigma2,N,M)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    mComplex = const_M_QAM(M);
    mGray = Gray_M_QAM(M);
    bitsN = genBin(N);
    an = mappingGray(M,bitsN,mGray,mComplex);
    rn = canalAWGN(an,sigma2);
    an_hat = decision(rn,mComplex);
    bitsn2 = demapGray(an_hat,mGray,mComplex);
    bitsn2 = double(bitsn2 == '1');
end

