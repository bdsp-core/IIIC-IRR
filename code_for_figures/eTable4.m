%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eTable 4. Expert IRR for IIIC events.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;
addpath('./Callbacks/');

tmp=load('./Data/Figure3/IRA_labels.mat');
YY=tmp.YY;patterns={'Seizure','LPD','GPD','LRDA','GRDA','Other'};

thr_samples=1E3; 
idx_experts=find(sum(~isnan(YY),1)>=thr_samples)';
idx_experts([15,16,18,21])=[];
YY=YY(:,idx_experts);

[P,~,~,Pij,~]=fcn_getCM_pairwise(YY);
[Mp,Lp,Up]=fcn_getBandCM(P,Pij);
[pM,pL,pU]=fcn_getBandCM_kappa(P,Pij);

[Yr,idx,med_mn_mx]=fcn_exclude4mIRR(YY,10);[M,Mk]=fcn_getCM_majority(Yr);
[Mm,Lm,Um]=fcn_getBandCM(M,Mk);[M,Mk]=fcn_getCM_majority(YY);
[mM,mL,mU]=fcn_getBandCM_kappa(M,Mk);

Mp=round(100*Mp);Lp=round(100*Lp);Up=round(100*Up);pM=round(100*pM);pL=round(100*pL);pU=round(100*pU);Mm=round(100*Mm);Lm=round(100*Lm);Um=round(100*Um);mM=round(100*mM);mL=round(100*mL);mU=round(100*mU);
disp('eTable 4. Expert IRR for IIIC events.')
disp('-------------------------------------------------------')
disp('              pairwise IRR            Majority IRR')
disp('             PA           K          PA           K')
disp('-------------------------------------------------------')
for i=1:length(patterns)
    if i==4
        disp([patterns{i},repmat(' ',1,10-length(patterns{i})),num2str(Mp(i)),'( ',num2str(Lp(i)),',',num2str(Up(i)),')','   ',num2str(pM(i)),'( ',num2str(pL(i)),',',num2str(pU(i)),')','   ',num2str(Mm(i)),'(',num2str(Lm(i)),',',num2str(Um(i)),')','   ',num2str(mM(i)),'(',num2str(mL(i)),',',num2str(mU(i)),')']);
    else
        disp([patterns{i},repmat(' ',1,10-length(patterns{i})),num2str(Mp(i)),'(',num2str(Lp(i)),',',num2str(Up(i)),')','   ',num2str(pM(i)),'(',num2str(pL(i)),',',num2str(pU(i)),')','   ',num2str(Mm(i)),'(',num2str(Lm(i)),',',num2str(Um(i)),')','   ',num2str(mM(i)),'(',num2str(mL(i)),',',num2str(mU(i)),')']);
    end
end
disp('-------------------------------------------------------')
