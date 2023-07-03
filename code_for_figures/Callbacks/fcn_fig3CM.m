function fcn_fig3CM(Mx,titleStr,labels,colorStr,ax,jj)
    set(gcf,'CurrentAxes',ax);cla(ax)
    hold(ax,'on');
        x=1:6;yy=[-1,7];
        imagesc(ax,x,x,Mx,[0 1])
        for i=0:7
           xx=[i,i]-0.5;
           plot(ax,xx,yy,'k',yy,xx,'k');
        end
        for i=1:6
            for j=1:6
                n=round(Mx(i,j)*100);
                if n>10;xx=j-.2;else;xx=j-0.1;end;yy=i;
                if n<=50;text(ax,xx,yy,num2str(n),'color','k','fontsize',20);else;text(ax,xx,yy,num2str(n),'color','w','fontsize',20);end
            end
        end     
        axis ij;axis square;box off;colormap(ax,brewermap([],colorStr))
        set(ax,'xlim',[.5 6.5],'ylim',[.5 6.5],'TickLength',[0,0],'xtick',1:6,'ytick',1:6,'xticklabels',labels,'yticklabels',labels)
        if jj==1
            set(ax,'xtick',1:6,'ytick',1:6,'xticklabels',[],'yticklabels',labels)
            text(ax,0,0.25,'B','fontsize',25)
        else
            text(ax,0,0.25,'C','fontsize',25)
        end
        title(titleStr);
    hold(ax,'off');
end
