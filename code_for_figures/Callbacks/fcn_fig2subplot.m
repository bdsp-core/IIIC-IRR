function fcn_fig2subplot(eegDir,sample_key,f,ax_eeg,ax_spe,label_str,show_flag)
    tmp=load([eegDir,sample_key]); 
    eeg=tmp.seg_10sec;ekg=eeg(end,:);sdata=tmp.Sdata;s_x=tmp.stimes;s_y=tmp.sfreqs;
    Fs=200;zScale=1/120;
    gap=NaN(1,size(eeg,2));
    tt=1:size(eeg,2);
    seg=fcn_bipolar(eeg);
    seg_disp=[seg(1:4,:);gap;seg(5:8,:);gap;seg(9:12,:);gap;seg(13:16,:);gap;seg(17:18,:);gap;ekg];                    
    M=size(seg_disp,1);
    DCoff=repmat(flipud((1:M)'),1,size(seg_disp,2));

    set(f,'CurrentAxes',ax_eeg);cla(ax_eeg)
    hold(ax_eeg,'on')
        text(ax_eeg,5*Fs,0,'t','verticalalignment','top','horizontalalignment','center','fontsize',12)
        if show_flag    
            text(ax_eeg,5*Fs,-1.5,'10-second EEG','verticalalignment','top','horizontalalignment','center','fontsize',10)
        end       
        for iSec=1:10
            ta=1+Fs*(iSec-1);
            line(ax_eeg,[ta ta],[0 M+1],'linestyle','--','color',[.5,.5,.5]);
        end            
        plot(ax_eeg,tt,zScale*seg_disp(1:end-1,:)+DCoff(1:end-1,:),'k');
        ekg_=seg_disp(end,:);ekg_=(ekg_-mean(ekg_))/(eps+std(ekg_));
        plot(ax_eeg,tt,-.2*ekg_+DCoff(end,:),'r');
        set(ax_eeg,'ytick',1:M,'yticklabel',[],'box','on','ylim',[0 M+1],'xlim',[tt(1),tt(end)],'xtick',[],'xticklabel',[]);
        
        dt=10*Fs;a=round(dt*.75);
        xa1=1+[a,a+Fs-1];ya1=[5,5];xa2=1+[a,a];ya2=ya1+[0,100*zScale];
        text(ax_eeg,xa1(1)-Fs/10,mean(ya2),'100\muV','Color','b','FontSize',8,'horizontalalignment','right');
        text(ax_eeg,mean(xa1),4.7,'1 sec','Color','b','FontSize',8,'horizontalalignment','center');       
        line(ax_eeg,xa1,ya1,'LineWidth',1,'Color','b');
        line(ax_eeg,xa2,ya2,'LineWidth',1,'Color','b');            
    hold(ax_eeg,'off')

    tc=round(length(s_x)/2);
    col=[-10,25];
    for iReg=1:4
        spec=sdata{5-iReg,2};colormap jet;
        set(f,'CurrentAxes',ax_spe{iReg});cla(ax_spe{iReg})
        hold(ax_spe{iReg},'on')
            imagesc(ax_spe{iReg},s_x,s_y,pow2db(spec),col);axis(ax_spe{iReg},'xy');
            set(ax_spe{iReg},'xtick',[],'ytick',[],'box','on');
            plot(ax_spe{iReg},[tc,tc],[s_y(1),s_y(end)],'k--','linewidth',1);
            text(ax_spe{iReg},s_x(10),18,sdata{5-iReg,1},'color','w','fontweight','bold','fontsize',10,'verticalalignment','middle')
            if iReg==1
                text(ax_spe{iReg},tc,0,'t','verticalalignment','top','horizontalalignment','center','fontsize',12)
                if show_flag
                    text(ax_spe{iReg},tc,-5,'10-minute spectrograms','verticalalignment','top','horizontalalignment','center','fontsize',10)
                end  
            end
            if iReg==4
                text(ax_spe{iReg},s_x(1),20,label_str,'fontsize',15,'verticalalignment','bottom')
            end
        hold(ax_spe{iReg},'off')
    end       
end
