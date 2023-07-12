%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eTable 3. Numbers of EEG segments scored by experts (top 30).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;
 
% get raw data
tmp=load('./Data/Figure1/Figure1_input.mat');
YY1=tmp.Y;

% get top 30
% filter #1: keep raters who voted at least 1000 samples
thr_samples=1E3; 
idx_experts=find(sum(~isnan(YY1),1)>=thr_samples)';

% filter #2: remove non-fellow trained raters
idx_experts([15,16,18,21])=[];
YY2=YY1(:,idx_experts);

nTotal2=sum(~isnan(YY2),1);
nVotes2=sum(~isnan(YY2),2);

YY3=YY2(nVotes2>=10,:);
nTotal3=sum(~isnan(YY3),1);

res=[nTotal2',nTotal3'];

[~,idx]=sort(nTotal2,'descend');
res=res(idx,:);

disp('eTable 3. Numbers of EEG segments scored by experts (top 30).')
disp('-------------------------------------------------------------')
disp('Expert#    Total# scores    Segments with >=10 votes')
for i=1:size(YY2,2)
    if i<8
        disp([repmat('0',1,2-length(num2str(i))),num2str(i),'         ',num2str(res(i,1)),'            ',num2str(res(i,2))]);
    else
        disp([repmat('0',1,2-length(num2str(i))),num2str(i),'         ',num2str(res(i,1)),'             ',num2str(res(i,2))]);
    end
end
disp('-------------------------------------------------------------')

