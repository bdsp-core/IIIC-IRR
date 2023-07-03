%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3. IRR analysis - Calibration and Confusion matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;
addpath('./Callbacks/');

% set figure
figure('units','normalized','position',[.10,.05,.65,.90],'color','w');
ax={subplot('position',[.04,.05,.25,.27]);subplot('position',[.04,.37,.25,.27]);subplot('position',[.04,.69,.25,.27]);subplot('position',[.31,.05,.25,.27]);subplot('position',[.31,.37,.25,.27]);subplot('position',[.31,.69,.25,.27]);subplot('position',[.61,.05,.38,.43]);subplot('position',[.61,.53,.38,.43])};ax=ax([4,3,6,2,5,1,8,7]);
c=[0.635,0.078,0.184;0.85,0.325,0.098;0.929,0.694,0.125;0.466,0.674,0.188;0.301,0.745,0.933;0.000,0.447,0.741];
labels={'Other','Seizure','LPD','GPD','LRDA','GRDA'};

% get data
tmp=load('./Data/Figure3/IRA_labels.mat');
YY=tmp.YY;  

% filter #1: keep raters who voted at least 1000 samples
thr_samples=1E3; 
idx_experts=find(sum(~isnan(YY),1)>=thr_samples)';

% filter #2: remove non-fellow trained raters
idx_experts([15,16,18,21])=[];
YY=YY(:,idx_experts);

% calibration - 20
idx=fcn_exclude4Calibration(YY);Yr=YY(:,idx);
for i=1:length(labels)
    fcn_fig3Calibraiton(Yr,i-1,c,labels,ax{i}); 
end

% pIRR
[P,PairwiseComparisons,nij,Pij,C]=fcn_getCM_pairwise(YY);

% mIRR - 30
[Yr,idx,med_mn_mx]=fcn_exclude4mIRR(YY,10);[M,Mk]=fcn_getCM_majority(Yr); 

% figure
fcn_fig3CM(P,'Pairwise IRR (%)',labels([2:6,1]),'Purples',ax{7},1);
fcn_fig3CM(M,'Majority IRR (%)',labels([2:6,1]),'Purples',ax{8},2); 

% export
print(gcf,'-dpng','-r300','./Fig3.png');
