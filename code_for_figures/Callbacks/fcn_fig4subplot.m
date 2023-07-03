function fcn_fig4subplot(curveType,sp,Fp,Se,PPV,fp,se,ppv,auc,auprc,ax)
    labels={'Seizure','LPD','GPD','LRDA','GRDA','Other'};
    c=[0.635,0.078,0.184;0.850,0.325,0.098;0.929,0.694,0.125;0.466,0.674,0.188;0.301,0.745,0.933;0.000,0.447,0.741];
    if curveType==0
        set(gcf,'CurrentAxes',ax{sp});cla(ax{sp})
        hold(ax{sp},'on');
            if sp==1
                text(ax{sp},-20,113.5,'A','fontsize',15)
            end
            plot(ax{sp},fp,se,'k--','linewidth',2); 
            scatter(ax{sp},Fp,Se,30,c(sp,:),'filled');
            text(ax{sp},10,20,['AUROC ' num2str(round(auc*100)) '%']);
            h=text(ax{sp},-90,50,labels{sp},'fontsize',15);
            h.Rotation=90;
            if sp==6
                set(ax{sp},'xtick',0:20:100,'ytick',0:20:100,'xlim',[-5,105],'ylim',[0,105]);
                xlabel('FPR'); 
            else
                set(ax{sp},'xtick',0:20:100,'xticklabel','','ytick',0:20:100,'xlim',[-5,105],'ylim',[0,105]); 
            end
            ylabel('TPR');axis square;grid on;box off;   
        hold(ax{sp},'off');  
    else
        set(gcf,'CurrentAxes',ax{sp+6});cla(ax{sp+6})
        hold(ax{sp+6},'on');
            if sp==1
                text(ax{sp+6},-20,113.5,'B','fontsize',15)
            end
            plot(ax{sp+6},se,ppv,'k--','linewidth',2); 
            scatter(ax{sp+6},Se,PPV,30,c(sp,:),'filled','marker','v');
            text(ax{sp+6},10,20,['AUPRC ' num2str(round(auprc*100)) '%']); 
            if sp==6
                set(ax{sp+6},'xtick',0:20:100,'ytick',0:20:100,'xlim',[-5,105],'ylim',[0,105]);
                xlabel('TPR'); 
            else
                set(ax{sp+6},'xtick',0:20:100,'xticklabel','','ytick',0:20:100,'xlim',[-5,105],'ylim',[0,105]);
            end
            ylabel('PPV');
            axis square;grid on;box off;
        hold(ax{sp+6},'off'); 
    end
end
