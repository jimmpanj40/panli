function [ACK] = crcdetect(in,out,k)
%canalAWGN Summary of this function goes here
% Creation of the noise with a real and an imaginary part
ACK=1;
out2=sign(abs(out2)-0.5)
err=sum(abs(in(end-k:end)-out2(end-k:end)))
if err==0
    ACK=0;
end
end

