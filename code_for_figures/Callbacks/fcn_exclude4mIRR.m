function [Yr,idx,med_mn_mx]=fcn_exclude4mIRR(Y,thr)
    % only include samples scored by >=10 experts
    Yr=Y(sum(~isnan(Y),2)>=10,:);

    % only include experts who have scored >=thr within this class
    n=nan(size(Yr,2),5);
    for i=1:size(Yr,2) 
        yi=Yr(:,i);        
        for p=0:5
            j=p+1;n(i,j)=sum(yi==p); 
        end
    end   
    min_per_pattern=min(n,[],2); 
    idx=find(min_per_pattern>=thr); 
    Yr=Yr(:,idx); 

    nn=n(idx,:); 
    median(nn(:));
    med_mn_mx=[median(nn(:)) min(nn(:)) max(nn(:))];
end