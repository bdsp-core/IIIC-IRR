function acc=fcn_accBoots(gt,y,K)
    N=length(gt);acc=NaN(K,1);
    for i=1:K
        idx=randsample(N,N,1);
        gt_k=gt(idx);y_k=y(idx);
        acc(i)=sum(y_k==gt_k)/N;
    end
end