function fcn_eFig2subplot(eegDir,sample_key,f,ax_eeg,ax_spe,str)
    tmp=load([eegDir,sample_key]);
    eeg=tmp.seg_10sec;ekg=eeg(end,:);
    sdata=tmp.Sdata;s_x=tmp.stimes;s_y=tmp.sfreqs;   
    tto=1;tt1=size(eeg,2);tt=tto:tt1;  
    Fs=200;zScale=1/120;
    gap=NaN(1,size(eeg,2));  
    seg=fcn_bipolar(eeg);
    seg_disp=[seg(1:4,:);gap;seg(5:8,:);gap;seg(9:12,:);gap;seg(13:16,:);gap;seg(17:18,:);gap;ekg];                  
    M=size(seg_disp,1);DCoff=repmat(flipud((1:M)'),1,size(seg_disp,2));
    set(f,'CurrentAxes',ax_eeg);cla(ax_eeg)
    hold(ax_eeg,'on')
        for iSec=1:10
            ta=tto+Fs*(iSec-1);
            line([ta,ta],[0,M+1],'linestyle','--','color',[0.5,0.5,0.5])
        end           
        plot(ax_eeg,tt,zScale*seg_disp(1:end-1,:)+DCoff(1:end-1,:),'k');
        ekg_=seg_disp(end,:);ekg_=(ekg_-mean(ekg_))/(eps+std(ekg_));
        plot(ax_eeg,tt,-.2*ekg_+DCoff(end,:),'r');
        set(ax_eeg,'ytick',1:M,'yticklabel',[],'box','on','ylim',[0,M+1],'xlim',[tto,tt1],'xtick',[],'xticklabel',[])
    hold(ax_eeg,'off')
    
    tc=round(length(s_x)/2);col=[-10,25];
    for iReg=1:4
        set(f,'CurrentAxes',ax_spe{iReg});cla(ax_spe{iReg})
        hold(ax_spe{iReg},'on')      
            spec=sdata{5-iReg,2};colormap jet;
            imagesc(ax_spe{iReg},s_x,s_y,pow2db(spec),col);
            axis(ax_spe{iReg},'xy');  
            plot(ax_spe{iReg},2*[tc,tc],[s_y(1),s_y(end)],'k--','linewidth',1);
            set(ax_spe{iReg},'xtick',[],'ytick',[],'box','on')   
            text(ax_spe{iReg},s_x(10),18,sdata{5-iReg,1},'color','w','fontweight','bold','fontsize',8,'verticalalignment','middle')
            if iReg==4
                text(ax_spe{iReg},s_x(1),20,str,'fontsize',15,'verticalalignment','bottom')
            end
        hold(ax_spe{iReg},'off')
    end 
end
