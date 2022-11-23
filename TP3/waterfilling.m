function [an,am,P_allocated] = waterfilling(G,N0,B,Pav,N)
an = G/(N0*B);
am=an;
M=length(am);

condition= true ; %Condition which indicate if we continue or stop the waterfilling algorithm
P=N*Pav;

while condition
    inverseLambda=(P+sum(1./am))/M;
    if isempty(find((inverseLambda-1./am)<0)) == false
        am=am(1:end-1);
        M=length(am);
    else 
        condition=false; % Then, we got our ak such as the power of the system is not exceeded
    end   
end 
%power allocated
P_allocated=inverseLambda-1./am

end