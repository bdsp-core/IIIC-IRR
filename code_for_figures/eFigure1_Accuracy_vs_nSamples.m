%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eFigure 1. Accuracy as function of number of samples 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;

% read data
addpath('./Callbacks/');
tmp=load('./Data/Figure3/IRA_labels.mat');Y=tmp.YY;nRaters=size(Y,2);

% bootstrap
K=1E4;nnn=NaN(1,nRaters);acc=NaN(K,nRaters);acc_true=NaN(1,nRaters);cc=[0.000,0.447,0.741];
for i=1:nRaters
    y=Y(:,i);yy=Y;yy(:,i)=[];gt=mode(yy,2);idx=(~isnan(y)&~isnan(gt));y=y(idx);gt=gt(idx,:); 
    if ~isempty(y);acc_true(i)=sum(gt==y)/sum(idx);end
    nnn(i)=sum(idx);acc(:,i)=fcn_accBoots(gt,y,K);
end
UU=prctile(acc,97.5);LL=prctile(acc,2.5);MM=acc_true;IQR=prctile(acc,75)-prctile(acc,25);

% figure
N=size(Y,1);
f=figure('units','normalized','position',[.1,.2,.8,.6],'MenuBar','none','ToolBar','none','color','w');
hold on
    xx=log(nnn/N);[~,idx]=sort(xx);xx1=xx(idx);iqr1=IQR(idx);idx1=find(iqr1~=0);xxx=[xx1(idx1),fliplr(xx1(idx1))];yyy=[iqr1(idx1)*0,fliplr(iqr1(idx1))];
    s=patch(xxx,yyy,'r','edgecolor','none');set(s,'FaceAlpha',0.05); 
    plot(xx,MM,'.','markersize',20);plot(xx(idx),IQR(idx),'*','color','r' ,'markersize',5) 
    x=log(nnn/N);a=.05;
    for i=1:length(nnn)
        plot([x(i),x(i)],[LL(i),UU(i)],[x(i)-a,x(i)+a],[LL(i),LL(i)],[x(i)-a,x(i)+a],[UU(i),UU(i)],'color',cc,'linewidth',1)
    end
    for k=[10,100,1E3,1E4]
        plot([log(k/N),log(k/N)],[0.0,1.0],'r--')
        if k<1E3;text(log(k/N)+.2,.3,['K=',num2str(k)],'fontsize',15);end
        if k==1E3;text(log(k/N)+.2,.3,'K=1,000','fontsize',15);end
        if k==1E4;text(log(k/N)+.2,.3,'K=10,000','fontsize',15);end
    end
    plot(0.5,.98,'.','markersize',30,'color',cc);plot([0.5,0.5],[.96,1.00],[0.4,0.6],[.96,.96],'-','color',cc,'linewidth',1);plot(0.50,0.92,'r*','markersize',10,'linewidth',1);
    text(0.80,0.98,'Acc. with 95% CI','fontsize',15);text(0.8,.92,'IQR (Q3-Q1)','fontsize',15);ylabel('Accuracy (leave one out)');xlabel('#Samples scored / #Total (dB)')
    set(gca,'fontsize',15,'box','off','xlim',[-10.5,2.0],'ylim',[0,1],'xtick',-12:2:0,'xticklabel',{'-12dB','-10dB',-8,-6,-4,-2,'0dB'});
hold off

print(gcf,'-dpng','-r300','./eFig1.png');
