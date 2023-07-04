%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2Figure 2. Selected EEG Examples for idealized,proto- and edge-cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;

% add tools
addpath('./Callbacks/');

% set figure
f=figure('units','normalized','position',[0.0000,0.0463,1.0000,0.9269],'MenuBar','none','ToolBar','none','color','w');
Ax={subplot('position',[.090,0.770,0.080,0.035]);subplot('position',[.170,0.770,0.130,0.140]);subplot('position',[.090,0.805,0.080,0.035]);subplot('position',[.090,0.840,0.080,0.035]);subplot('position',[.090,0.875,0.080,0.035]);
    subplot('position',[.320,0.770,0.080,0.035]);subplot('position',[.400,0.770,0.130,0.140]);subplot('position',[.320,0.805,0.080,0.035]);subplot('position',[.320,0.840,0.080,0.035]);subplot('position',[.320,0.875,0.080,0.035]); 
    subplot('position',[.550,0.770,0.080,0.035]);subplot('position',[.630,0.770,0.130,0.140]);subplot('position',[.550,0.805,0.080,0.035]);subplot('position',[.550,0.840,0.080,0.035]);subplot('position',[.550,0.875,0.080,0.035]);
    subplot('position',[.780,0.770,0.080,0.035]);subplot('position',[.860,0.770,0.130,0.140]);subplot('position',[.780,0.805,0.080,0.035]);subplot('position',[.780,0.840,0.080,0.035]);subplot('position',[.780,0.875,0.080,0.035]);
    subplot('position',[.090,0.580,0.080,0.035]);subplot('position',[.170,0.580,0.130,0.140]);subplot('position',[.090,0.615,0.080,0.035]);subplot('position',[.090,0.650,0.080,0.035]);subplot('position',[.090,0.685,0.080,0.035]);
    subplot('position',[.320,0.580,0.080,0.035]);subplot('position',[.400,0.580,0.130,0.140]);subplot('position',[.320,0.615,0.080,0.035]);subplot('position',[.320,0.650,0.080,0.035]);subplot('position',[.320,0.685,0.080,0.035]);
    subplot('position',[.550,0.580,0.080,0.035]);subplot('position',[.630,0.580,0.130,0.140]);subplot('position',[.550,0.615,0.080,0.035]);subplot('position',[.550,0.650,0.080,0.035]);subplot('position',[.550,0.685,0.080,0.035]);
    subplot('position',[.780,0.580,0.080,0.035]);subplot('position',[.860,0.580,0.130,0.140]);subplot('position',[.780,0.615,0.080,0.035]);subplot('position',[.780,0.650,0.080,0.035]);subplot('position',[.780,0.685,0.080,0.035]);
    subplot('position',[.090,0.390,0.080,0.035]);subplot('position',[.170,0.390,0.130,0.140]);subplot('position',[.090,0.425,0.080,0.035]);subplot('position',[.090,0.460,0.080,0.035]);subplot('position',[.090,0.495,0.080,0.035]);
    subplot('position',[.320,0.390,0.080,0.035]);subplot('position',[.400,0.390,0.130,0.140]);subplot('position',[.320,0.425,0.080,0.035]);subplot('position',[.320,0.460,0.080,0.035]);subplot('position',[.320,0.495,0.080,0.035]);
    subplot('position',[.550,0.390,0.080,0.035]);subplot('position',[.630,0.390,0.130,0.140]);subplot('position',[.550,0.425,0.080,0.035]);subplot('position',[.550,0.460,0.080,0.035]);subplot('position',[.550,0.495,0.080,0.035]);
    subplot('position',[.780,0.390,0.080,0.035]);subplot('position',[.860,0.390,0.130,0.140]);subplot('position',[.780,0.425,0.080,0.035]);subplot('position',[.780,0.460,0.080,0.035]);subplot('position',[.780,0.495,0.080,0.035]);
    subplot('position',[.090,0.200,0.080,0.035]);subplot('position',[.170,0.200,0.130,0.140]);subplot('position',[.090,0.235,0.080,0.035]);subplot('position',[.090,0.270,0.080,0.035]);subplot('position',[.090,0.305,0.080,0.035]);
    subplot('position',[.320,0.200,0.080,0.035]);subplot('position',[.400,0.200,0.130,0.140]);subplot('position',[.320,0.235,0.080,0.035]);subplot('position',[.320,0.270,0.080,0.035]);subplot('position',[.320,0.305,0.080,0.035]);
    subplot('position',[.550,0.200,0.080,0.035]);subplot('position',[.630,0.200,0.130,0.140]);subplot('position',[.550,0.235,0.080,0.035]);subplot('position',[.550,0.270,0.080,0.035]);subplot('position',[.550,0.305,0.080,0.035]);
    subplot('position',[.780,0.200,0.080,0.035]);subplot('position',[.860,0.200,0.130,0.140]);subplot('position',[.780,0.235,0.080,0.035]);subplot('position',[.780,0.270,0.080,0.035]);subplot('position',[.780,0.305,0.080,0.035]);
    subplot('position',[.090,0.010,0.080,0.035]);subplot('position',[.170,0.010,0.130,0.140]);subplot('position',[.090,0.045,0.080,0.035]);subplot('position',[.090,0.080,0.080,0.035]);subplot('position',[.090,0.115,0.080,0.035]);
    subplot('position',[.320,0.010,0.080,0.035]);subplot('position',[.400,0.010,0.130,0.140]);subplot('position',[.320,0.045,0.080,0.035]);subplot('position',[.320,0.080,0.080,0.035]);subplot('position',[.320,0.115,0.080,0.035]);
    subplot('position',[.550,0.010,0.080,0.035]);subplot('position',[.630,0.010,0.130,0.140]);subplot('position',[.550,0.045,0.080,0.035]);subplot('position',[.550,0.080,0.080,0.035]);subplot('position',[.550,0.115,0.080,0.035]);
    subplot('position',[.780,0.010,0.080,0.035]);subplot('position',[.860,0.010,0.130,0.140]);subplot('position',[.780,0.045,0.080,0.035]);subplot('position',[.780,0.080,0.080,0.035]);subplot('position',[.780,0.115,0.080,0.035])}; 

% read samples
dataDir='./Data/eFigure2/';
files =struct2cell(dir([dataDir,'*.mat']))';files=files(:,1);
pp={'Seizure','LPD','GPD','LRDA','GRDA','Other'};
gg={'A. Idealized','B. Proto','C. Edge','D. Edge'};
for k=1:size(files,1)   
    file=strrep(files{k},'.mat','');
    sample_key=file(3:end);sub_idx=file(1);
    tmp=load([dataDir,file],'vv');vv=tmp.vv([2:6,1]);
    score_str='';
    for kk=1:length(vv)
        if vv(kk)>0
            score_str=[score_str,num2str(vv(kk)),' ',pp{kk},', '];
        end
    end
    score_str=score_str(1:end-2);
    if k==15;score_str=strrep(score_str,'Seizure','xx');score_str=strrep(score_str,'LRDA','Seizure');score_str=strrep(score_str,'xx','LRDA');end 
    if k==19;score_str=strrep(score_str,'Seizure','xx');score_str=strrep(score_str,'GRDA','Seizure');score_str=strrep(score_str,'xx','GRDA');end
    if k==20;score_str=strrep(score_str,'LPD','xx');score_str=strrep(score_str,'GRDA','LPD');score_str=strrep(score_str,'xx','GRDA');end
    
    ax_eeg=Ax{(k-1)*5+2};ax_spe=Ax([(k-1)*5+1,(k-1)*5+3:k*5]); 
    fcn_eFig2subplot(dataDir,file,f,ax_eeg,ax_spe,score_str)  
    
    if mod(k,4)==1;text(ax_eeg,-12*200,13,pp{1+floor(k/4)},'fontsize',20);end
    if k<5;text(ax_eeg,2*200,35,gg{k},'fontsize',20,'horizontalalignment','center');end
end

print(gcf,'-dpng','-r300','eFig2.png');
