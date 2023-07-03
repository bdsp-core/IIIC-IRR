%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 2. Selected EEG Examples for Class Seizure:
% (A) Idealized form of seizure
% (B) Protopattern or partially formed pattern (half Seizure, half "Other")
% (C,D) Edge cases (half Seizure, half one IIIC class)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;

% add tools
addpath('./Callbacks/');

% get input
dataDir='./Data/Figure2/';
files =struct2cell(dir([dataDir,'*.mat']))';files=files(:,1);
pp={'seizure','LPD','GPD','LRDA','GRDA','other'};
gg={'Idealized','Proto','Edge','Edge'};

% set figure
f=figure('units','normalized','position',[0.0516,0.0620,0.6300,0.8000],'MenuBar','none','ToolBar','none','color','w');
Ax={subplot('position',[.05,0.53,0.15,0.10]);subplot('position',[.20,0.53,0.30,0.40]);subplot('position',[.05,0.63,0.15,0.10]);subplot('position',[.05,0.73,0.15,0.10]);subplot('position',[.05,0.83,0.15,0.10]);
    subplot('position',[.54,0.53,0.15,0.10]);subplot('position',[.69,0.53,0.30,0.40]);subplot('position',[.54,0.63,0.15,0.10]);subplot('position',[.54,0.73,0.15,0.10]);subplot('position',[.54,0.83,0.15,0.10]);
    subplot('position',[.05,0.03,0.15,0.10]);subplot('position',[.20,0.03,0.30,0.40]);subplot('position',[.05,0.13,0.15,0.10]);subplot('position',[.05,0.23,0.15,0.10]);subplot('position',[.05,0.33,0.15,0.10]);
    subplot('position',[.54,0.03,0.15,0.10]);subplot('position',[.69,0.03,0.30,0.40]);subplot('position',[.54,0.13,0.15,0.10]);subplot('position',[.54,0.23,0.15,0.10]);subplot('position',[.54,0.33,0.15,0.10])};

for k=1:size(files,1)
    file=strrep(files{k},'.mat','');
    sample_key=file(3:end);sub_idx=file(1);
    tmp=load([dataDir,file],'vv');vv=tmp.vv([2:6,1]);
    fig_subtitle='';
    for kk=1:length(vv)
        if vv(kk)>0
            fig_subtitle=[fig_subtitle,num2str(vv(kk)),' ',pp{kk},', '];
        end
    end
    fig_subtitle=[sub_idx,'. ',gg{k},' - ',fig_subtitle(1:end-2) ];
    
    ax_eeg=Ax{(k-1)*5+2};
    ax_spe=Ax([(k-1)*5+1,(k-1)*5+3:k*5]);
    if k==1
        fcn_fig2subplot(dataDir,file,f,ax_eeg,ax_spe,fig_subtitle,1)
    else
        fcn_fig2subplot(dataDir,file,f,ax_eeg,ax_spe,fig_subtitle,0)
    end
end

% export
print(gcf,'-dpng','-r300','./Fig2.png');
  