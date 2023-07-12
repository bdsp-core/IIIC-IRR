function [kM,kL,kU]=fcn_getBandCM_kappa(M,Mk) 
    for i=1:size(Mk,2)
        dm(:,i)=diag(Mk{i}); 
    end
    pam =diag(M); 
    pc=1/6; 
    kM=(pam-pc)./(1-pc);
    kM=kM';

    k=(dm-pc)./(1-pc); 
    kL=prctile(k',25); 
    kU=prctile(k',75); 
end