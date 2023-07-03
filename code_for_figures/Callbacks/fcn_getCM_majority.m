function [M,Mk]=fcn_getCM_majority(Y)
    yref=mode(Y,2); % correct answer - majority vote
    refNo=0;pp=[1:5,0];M=zeros(6,6);ct=0; 
    for k=1:size(Y,2)
        if k ~= refNo
            yk=Y(:,k);            
            mk=fcn_getCM(yref,yk,pp);
        end
          if sum(isnan(mk(:)))==0
              M=M + mk; 
              Mk{k}=mk; 
              ct=ct+1; 
          end
    end
    M=M/ct; 
end