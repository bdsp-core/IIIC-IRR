function [M,L,U]=fcn_getBandCM(M,Mk)
    for i=1:size(Mk,2)
        dm(:,i)=diag(Mk{i}); 
    end
    M=diag(M)'; 
    L=prctile(dm',5); 
    U=prctile(dm,95);
end