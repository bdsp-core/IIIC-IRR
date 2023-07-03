function [CM,c]=fcn_getCM(yref,yquery,pp)
    % get confusion matrix, treating yref as "gold standard" and yquery as comparison
    CM=zeros(length(pp),length(pp));c=zeros(length(pp),length(pp));
    for i=1:length(pp)
        patternA=pp(i);
        for j=1:length(pp)  
            patternB=pp(j); 
            n=sum(yref==patternA&yquery==patternB); 
            d=sum(yref==patternA&~isnan(yquery)&~isnan(yref));  
            CM(i,j)=n/d;c(i,j)=d; 
        end
    end
end