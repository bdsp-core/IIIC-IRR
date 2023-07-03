%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 4. Bias vs Noise Analysis ROC and PR curves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear
 
addpath('./Callbacks/');
load('./Data/Figure4/ExpertPerfCurves.mat');  

f=figure('units','normalized','position',[.01,.00,.3 1],'MenuBar','none','ToolBar','none','color','w');
ax={subplot('position',[.250,.830,.340,.150]);subplot('position',[.250,.671,.340,.150]);subplot('position',[.250,.512,.340,.150]);subplot('position',[.250,.353,.340,.150]);subplot('position',[.250,.194,.340,.150]);subplot('position',[.250,.035,.340,.150]);
    subplot('position',[.630,.830,.340,.150]);subplot('position',[.630,.671,.340,.150]);subplot('position',[.630,.512,.340,.150]);subplot('position',[.630,.353,.340,.150]);subplot('position',[.630,.194,.340,.150]);subplot('position',[.630,.035,.340,.150])};
for sp=1:6
    fcn_fig4subplot(0,sp,Fp_all(sp,:),Se_all(sp,:),PPV_all(sp,:),Fp(sp,:),Se(sp,:),Ppv(sp,:),AUC(sp),AUPRC(sp),ax);     
    fcn_fig4subplot(1,sp,Fp_all(sp,:),Se_all(sp,:),PPV_all(sp,:),Fp(sp,:),Se(sp,:),Ppv(sp,:),AUC(sp),AUPRC(sp),ax); 
end
print(gcf,'-dpng','-r300','./Fig4.png');

