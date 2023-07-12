%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eTable2. EEG labelling rounds.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;

% read raw data
tmp=load('./Data/eTable2/LabelLog.mat');
H=tmp.res;raters=tmp.rater124;rater32=tmp.rater32;Keys=tmp.rounds;Y=tmp.Y;gg=tmp.gg;
idx_R32=NaN(31,1);
for i=1:32;idx_R32(i)=find(ismember(raters,rater32{i})==1);end
idx_R92=setdiff(1:124,idx_R32);

% get round counts 
CC=zeros(1,length(Keys));GG=zeros(size(H,1),1);
for i=1:size(H,1)
    cc=hist(categorical(H{i}(:,3)),Keys);[~,idx]=max(cc); 
    CC(idx)=CC(idx)+1;GG(i)=idx;
end

% get number of raters
idx_Raters=cell(length(Keys),1);
for i=1:length(Keys)
    Yi=Y(GG==i,:);
    idx_Raters{i}=find(sum(~isnan(Yi),1)>0)';
end

% group rounds of the same kind
disp('eTable 2. EEG labelling rounds.')
disp('-----------------------------------------------------')
lut=cell(size(gg,1),3);
for k=1:size(gg,1)
    idx=gg{k,1};lut{k,1}=sum(CC(idx));
    if k==2
        lut{k,2}=3;
        disp([gg{k,2},' ',num2str(lut{k,2}),' raters ',num2str(lut{k,1}),' samples'])
        
    elseif k==6
        lut{k,2}=92;
        disp([gg{k,2},'  ',num2str(lut{k,2}),'+2* raters ',num2str(lut{k,1}),' samples   ',num2str(lut{k,1}),' subtotal'])
        disp('-----------------------------------------------------')
    elseif k==5
        lut{k,2}=length(setdiff(unique(cell2mat(idx_Raters(idx))),idx_R92));
        disp([gg{k,2},' ',num2str(lut{k,2}),' raters ',num2str(lut{k,1}),' samples       ',num2str(sum(cell2mat(lut(1:5,1)))),' subtotal'])
        disp('-----------------------------------------------------')
    elseif k==size(gg,1)
        lut{k,2}=length(setdiff(unique(cell2mat(idx_Raters(idx))),idx_R92));
        disp([gg{k,2},' ',num2str(lut{k,2}),' raters ',num2str(lut{k,1}),' samples      ',num2str(sum(cell2mat(lut(7:end,1)))),' subtotal'])
        disp('-----------------------------------------------------')
    else
        lut{k,2}=length(setdiff(unique(cell2mat(idx_Raters(idx))),idx_R92));
        disp([gg{k,2},' ',num2str(lut{k,2}),' raters ',num2str(lut{k,1}),' samples'])
    end
end
