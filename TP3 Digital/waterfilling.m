function [an,am,P_allocated] = waterfilling(G,N0,B,Pav,N)
an = G/(N0*B);
am=an;
M=length(am);

condition= true ; %Condition which indicate if we continue or stop the waterfilling algorithm
P=N*Pav; %Total power

while condition
    inverseLambda=(P+sum(1./am))/M; 
    if isempty(find((inverseLambda-1./am)<0)) == false %check if inverseLambda-1/ak are all positive
        am=am(1:end-1); % if not, we remove last am
        M=length(am); %we adapt M, the length of am
    else 
        condition=false; % Then, we got our ak such as the power of the system is not exceeded
    end   
end 
P_allocated=inverseLambda-1./am; %power allocated to each channels of gain ak


end