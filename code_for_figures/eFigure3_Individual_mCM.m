%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eFigure 3. Individual majority CM 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;
addpath('./Callbacks/');

% read input - mIRR from IRR
tmp=load('./Data/eFigure3/eFigure3_input.mat','Mk');Mk=tmp.Mk;
pp={'SZ','LPD','GPD','LRDA','GRDA','Other'};

% figure
f=figure('units','normalized','position',[.1,.05,.43,.90],'MenuBar','none','ToolBar','none','color','w');
ax={subplot('position',[0/5*.9,5/6,.175,.160]);subplot('position',[1/5*.9,5/6,.175,.160]);subplot('position',[2/5*.9,5/6,.175,.160]);subplot('position',[3/5*.9,5/6,.175,.160]);subplot('position',[4/5*.9,5/6,.175,.160]);subplot('position',[0/5*.9,4/6,.175,.160]);subplot('position',[1/5*.9,4/6,.175,.160]);subplot('position',[2/5*.9,4/6,.175,.160]);subplot('position',[3/5*.9,4/6,.175,.160]);subplot('position',[4/5*.9,4/6,.175,.160]);subplot('position',[0/5*.9,3/6,.175,.160]);subplot('position',[1/5*.9,3/6,.175,.160]);subplot('position',[2/5*.9,3/6,.175,.160]);subplot('position',[3/5*.9,3/6,.175,.160]);subplot('position',[4/5*.9,3/6,.175,.160]);subplot('position',[0/5*.9,2/6,.175,.160]);subplot('position',[1/5*.9,2/6,.175,.160]);subplot('position',[2/5*.9,2/6,.175,.160]);subplot('position',[3/5*.9,2/6,.175,.160]);subplot('position',[4/5*.9,2/6,.175,.160]);subplot('position',[0/5*.9,1/6,.175,.160]);subplot('position',[1/5*.9,1/6,.175,.160]);subplot('position',[2/5*.9,1/6,.175,.160]);subplot('position',[3/5*.9,1/6,.175,.160]);subplot('position',[4/5*.9,1/6,.175,.160]);subplot('position',[0/5*.9,0/6,.175,.160]);subplot('position',[1/5*.9,0/6,.175,.160]);subplot('position',[2/5*.9,0/6,.175,.160]);subplot('position',[3/5*.9,0/6,.175,.160]);subplot('position',[4/5*.9,0/6,.175,.160]);subplot('position',[0.9,5/6,.10,.16])};

% main
for k=1:size(Mk,2)
    mk=Mk{k};set(f,'CurrentAxes',ax{k});cla(ax{k})
    hold(ax{k},'on')
        imagesc(ax{k},[],[],1-mk,[0 1]);
        text(3.5,0.5,['E',repmat('0',1,2-length(num2str(k))),num2str(k)],'fontsize',12,'verticalalignment','bottom','horizontalalignment','center')
        plot(ax{k},[0.5,6.5,6.5,0.5,0.5],[0.5,0.5,6.5,6.5,0.5],'k-')
        xlim([-0.5,7.5]);ylim([-0.5,7.5]);axis square;axis ij;axis off;colormap(brewermap([],'RdBu'));  
        if k==30
            for kk=1:6
                text(ax{k},kk,6.7,pp{kk},'rotation',30,'horizontalalignment','right','fontsize',6);text(ax{k},6.7,kk,pp{kk},'fontsize',6);
            end
        end
    hold(ax{k},'off')
end

k=31;
set(f,'CurrentAxes',ax{k});cla(ax{k})
hold(ax{k},'on')
    colormap(brewermap([],'RdBu'));
    cs=flipud(brewermap(100,'RdBu'));
    cs=reshape(cs,size(cs,1),1,3);
    imagesc(ax{k},1,(1:size(cs,1)),cs)
    plot(ax{k},[0.5,1.5,1.5,0.5,0.5],[-0.5,-0.5,100.5,100.5,-0.5],'k-')
    text(ax{k},1.6,1,'0.0','fontsize',10,'verticalalignment','top','horizontalalignment','left');
    text(ax{k},1.6,size(cs,1),'1.0','fontsize',10,'verticalalignment','bottom','horizontalalignment','left');
    set(ax{k},'xlim',[0,5],'ylim',[1-50,size(cs,1)+30])
    axis off
hold(ax{k},'off')

print(gcf,'-dpng','-r300','./eFig3.png');
