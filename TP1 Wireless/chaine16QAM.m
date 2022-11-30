function[bitsN, bitsChapeauN,an,aChapeauN]=chaine16QAM(M,N,sigma2,g0)
    mComplex=const_M_QAM(M);
    mGray=Gray_M_QAM(M);
    bitsN=genBin(N);
    an=mappingGray(M,bitsN,mGray,mComplex);
    rn=canalAWGN(g0*an,sigma2);
    aChapeauN=decision(rn,mComplex);
    bitsChapeauN=demapGray(aChapeauN,mGray,mComplex);
    
end