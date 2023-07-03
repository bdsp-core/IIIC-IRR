function ind=fcn_exclude4Calibration(Y)
    K=5;bin_edges=(0:K)/K;  
    scored=zeros(size(Y,2),K);
    mn=nan(size(Y,2),K);
    for p=0:5
        k=p+1; 
        b_num=sum(Y==p,2);      
        b_den=sum(~isnan(Y),2); 
        b=b_num./b_den;
        
        sample_bin=nan(1,size(Y,1));
        for j=1:K
           bin_left=bin_edges(j);bin_right= bin_edges(j+1);
           sample_bin(b>=bin_left&b<=bin_right)=j;
        end
        for i=1:size(Y,2)
            yi=(Y(:,i))'; 
            for j=1:K
                ind=find(~isnan(yi)&sample_bin==j); 
                scored(i,j)=length(ind); 
            end
            mn(i,k)=min(scored(i,:)); 
        end
    end
    thr=10;
    ind=find(min(mn,[],2)>=thr);     
end
