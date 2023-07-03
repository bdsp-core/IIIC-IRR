function [THRESH,N_in_bin]=fcn_fig3Calibraiton(Y,p,c,labels,ax)
    b_num=sum(Y==p,2);b_den=sum(~isnan(Y),2); 

    % limit to samples with at least 10 votes in total
    ind=find(b_den>=10); 
    b_den=b_den(ind);b_num=b_num(ind); 
    b=b_num./(eps+b_den);
    Yr=Y(ind,:); 

    % limit to experts with at least 1000 samples scored
    n_scored=sum(~isnan(Yr),1); 
    Yr=Yr(:,n_scored>=1000); 
    
    Ne=size(Yr,2);K=5;bin_edges=(0:K)/K;
    n=NaN(Ne,K);N_in_bin=NaN(Ne,K);
    for i=1:Ne        
        yi=Yr(:,i);  
        for j=1:K
           bin_left=bin_edges(j);
           bin_right= bin_edges(j+1);
           bin_center(j)=(bin_left + bin_right)/2; 
           ind=find(b>bin_left&b<=bin_right&~isnan(yi)); 
           n(i,j)=100*sum(yi(ind)==p)/length(ind); 
           if length(ind)<10
               n(i,j)=nan; 
           end
           N_in_bin(i,j)=length(ind); 
        end
    end

    % fit simple model to expert's data
    ns=[];th=linspace(-20,20,1000); 
    THRESH=NaN(1,size(n,1));
    for k=1:size(n,1)
        yy=n(k,:);idx1=find(~isnan(yy));yy=[0,yy(idx1),100];
        xx=[0,100*bin_center(idx1),100];          
        best=inf;best_th=0; 
        for j=1:length(th) 
            pr=min(xx/100,(1-0.001)); 
            z=log((pr)./(1-pr))+th(j); 
            yh=100./(1+exp(-z)); 
            C=sum((yy-yh).^2); 
            if C<best 
                best=C;
                best_th=th(j);                     
            end
        end    
        xxi=linspace(0,100,100);
        pr=xxi/100; 
        z=log((pr)./(1-pr)) + best_th;
        yh=100./(1+exp(-z));
        ns(k,:)=yh; 
        THRESH(k)=best_th; 
    end
 
    % cali inex
    x=linspace(eps,1-eps,100);s=NaN(size(THRESH));
    for j=1:size(THRESH,2)
       th=THRESH(j);z=log(x./(1-x))+th;y=1./(1+exp(-z));d=y-x;a=trapz(x,d); 
       s(j)=a/0.5; 
    end

    % plot
    Sp=p;if p==0;Sp=6;end
    thr_ll=-0.6073;z=log(x./(1-x)) + thr_ll; 
    y_ll=100./(1+exp(-z)); 

    thr_uu=0.6073;z=log(x./(1-x)) + thr_uu; 
    y_uu=100./(1+exp(-z)); 

    set(gcf,'CurrentAxes',ax); cla(ax)
    hold(ax,'on'); 
        x=linspace(0,100,100);
        xxx=[x,fliplr(x)];yyy=[y_uu,fliplr(y_ll)];
        ss=fill(ax,xxx,yyy,'k','edgecolor','none'); 
        set(ss,'FaceAlpha',0.2); 
        plot(ax,x,ns,100*bin_center,n,'x','linewidth',2,'color',c(Sp,:)); 
        plot(ax,x,ns,'linewidth',2,'color',c(Sp,:)); 
        axis square;axis([0 100 0 100]);grid on;        
        if p==0
            text(ax,5,90,labels{1},'fontsize',20)
        else
            text(ax,5,90,labels{p+1},'fontsize',20)
        end
        if p==0||p==5
             set(ax,'xtick',0:20:100,'xticklabels',0:20:100); 
             xlabel('group probability (%)') 
        else
             set(ax,'xtick',0:20:100,'xticklabels',cell(1,6)); 
        end
        if p==1||p==3||p==5
             set(ax,'ytick',0:20:100); 
             ylabel('individual probability (%)')
        else
             set(ax,'ytick',0:20:100,'yticklabels',cell(1,6)); 
        end
        if p==1
            text(ax,-10,107,'A','fontsize',25)
        end
        drawnow
    hold(ax,'off'); 
end