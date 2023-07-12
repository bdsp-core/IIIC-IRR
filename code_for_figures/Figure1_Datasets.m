%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 1. Datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;
addpath('./Callbacks/');

labels={'Other','Seizure','LPD','GPD','LRDA','GRDA'};

% get raw data
tmp=load('./Data/Figure1/Figure1_input.mat');
YY1=tmp.Y;Keys1=tmp.keys;VV1=tmp.V;
pats1=fcn_getStats(YY1,Keys1,VV1,'Dataset 1',0);
disp('-----------------------------------------------------')
str1=['Dataset 1: ',num2str(size(YY1,2)),' experts ',num2str(length(pats1)),' patients ',num2str(size(YY1,1)),' samples '];
disp(str1);

% filter #1: keep raters who voted at least 1000 samples
thr_samples=1E3; 
idx_experts=find(sum(~isnan(YY1),1)>=thr_samples)';

% filter #2: remove non-fellow trained raters
idx_experts([15,16,18,21])=[];
YY2=YY1(:,idx_experts);
Keys2=Keys1;
VV2=VV1;
[pats2,c2]=fcn_getStats(YY2,Keys2,VV2,'Dataset 2',0);
disp('-----------------------------------------------------')
disp('Restricted to raters who are experts and have labeled >=1000 samples')
str1=['Dataset 2: ',num2str(size(YY2,2)),' experts ',num2str(length(pats2)),' patients ',num2str(size(YY2,1)),' samples '];
str2=[num2str(c2(2)),' | ',num2str(c2(3)),' | ',num2str(c2(4)),' | ',num2str(c2(5)),' | ',num2str(c2(6)),' | ',num2str(c2(1))];
disp(str1);disp(str2);

% calibration - 20
[idx,med_mn_mx]=fcn_exclude4Calibration(YY2);YY3=YY2(:,idx);
disp('-----------------------------------------------------')
disp('Restricted to experts who labeled >=10 samples x 5 probability bins/class')
disp('Dataset 3: Calibration analysis')
str1=[num2str(length(idx)),' experts '];
str2=['#samples/bin: ',num2str(med_mn_mx(1)),' (',num2str(med_mn_mx(2)),',',num2str(med_mn_mx(3)),')'];
disp(str1);disp(str2)

[P,PairwiseComparisons,nij,Pij,C,med_mn_mx]=fcn_getCM_pairwise(YY2);
disp('-----------------------------------------------------')
disp('Restricted to experts who labeled >=100 samples in common/class')
disp('Dataset 4: Pairwise IRR analysis')
str1=[num2str(size(PairwiseComparisons,1)),' experts ',num2str(length(nij)),' expert pairs '];
str2=['#samples/class: ',num2str(med_mn_mx(1)),' (',num2str(med_mn_mx(2)),',',num2str(med_mn_mx(3)),')'];
disp(str1);disp(str2)

% mIRR - 30
[Yr,idx,med_mn_mx]=fcn_exclude4mIRR(YY2,10);[M,Mk]=fcn_getCM_majority(Yr); 
disp('-----------------------------------------------------')
disp('Restricted to experts who labeled >=10 samples/class')
disp('Dataset 5: Majority IRR and noise-bias analysis')
str1=[num2str(length(Mk)),' experts '];
str2=['#samples/class: ',num2str(med_mn_mx(1)),' (',num2str(med_mn_mx(2)),',',num2str(med_mn_mx(3)),')'];
disp(str1);disp(str2)
disp('-----------------------------------------------------')
