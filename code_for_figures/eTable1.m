%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eTable1. Patient and data chatacteristics.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;close all;clear;

% read raw data
tmp=load('./Data/eTable1/patientTbl.mat');P=tmp.res;
tmp=load('./Data/eTable1/expertTbl.mat');E=tmp.res;
tmp=load('./Data/eTable1/eegTbl.mat');Z=tmp.res;

% get table entries
disp('eTable 1. Patient and data chatacteristics.')
disp('---------------------------------------------------------------')
% part 1: total number patients 
nPatients=size(P,1); 
disp(['Number of patients:                               ',num2str(nPatients)])

% part 2: experts 
nExperts=size(E,1);
ll_training=cell2mat(E(:,2));
ll_practice=cell2mat(E(:,3));
disp(['Number of experts(fellowship trained):            ',num2str(nExperts)])
disp(['   Length of training(years), mean(range):        ',num2str(round(10*mean(ll_training))/10),'(',num2str(min(ll_training)),',',num2str(max(ll_training)),')'])
disp(['   Length of EEG practice after training:         ',num2str(round(10*mean(ll_practice))/10),'(',num2str(min(ll_practice)),',',num2str(max(ll_practice)),')'])

% part 3: age
Age=cell2mat(P(:,3));
Age_med=nanmedian(Age);Age_IQR=iqr(Age);
ageBins=[0,1;1,5;5,10;10,15;15,20;20,30;30,40;40,50;50,60;60,70;70,80;80,90;90,Inf];
ageGroups={'0-1:#n(%)';'1-5:';'5-10:';'10-15:';'15-20:';'20-30:';'30-40:';'40-50:';'50-60:';'60-70:';'70-80:';'80-90:';'90 and above:'};
disp(' ')
disp(['Patient age(years),median(IQR):                   ',num2str(round(10*Age_med)/10),'(',num2str(round(10*Age_IQR)/10),')'])
nn=zeros(size(ageBins,1),1);
pp=zeros(size(ageBins,1),1);
for k=1:size(ageBins,1)
    nn(k)=sum(Age>=ageBins(k,1)&Age<ageBins(k,2));
    pp(k)=round(1000*nn(k)/nPatients)/10;
    disp([' ',ageGroups{k},repmat(' ',1,49-length(ageGroups{k})),num2str(nn(k)),'(',num2str(pp(k)),'%)'])
end

% Part 4: sex
Sex=P(:,2);
nFemale=sum(ismember(Sex,'Female'));
pFemale=nFemale/nPatients;
disp(' ')
disp(['Female;#n(%):                                     ',num2str(nFemale),'(',num2str(round(100*pFemale)),'%)'])

% Part 5: IIIC distribution
CC=cell2mat(P(:,5:end));
nIIIC=sum(sum(CC(:,2:end),2)>0);pIIIC=nIIIC/nPatients;
pp={'Seizure','LPD','GPD','LRDA','GRDA'};
disp(' ')
disp(['IIIC patterns on EEG; #n(%):                      ',num2str(nIIIC),'(',num2str(round(100*pIIIC)),'%)'])
for i=1:length(pp)
    disp([' ',pp{i},':',repmat(' ',1,48-length(pp{i})),num2str(sum(CC(:,i+1)))])
end

% Part 6: EEG duration and setting
Dur=cell2mat(P(:,4));
Dur_med=nanmedian(Dur);Dur_IQR=iqr(Dur);
disp(' ')
disp(['EEG durations(hours),median(IQR):                 ',num2str(round(10*Dur_med)/10),'(',num2str(round(10*Dur_IQR)/10),')'])

settings=Z(:,end);
nLTM=sum(ismember(settings,'LTM'));pLTM=nLTM/length(settings);
nEMU=sum(ismember(settings,'EMU'));pEMU=nEMU/length(settings);
nEEG=sum(ismember(settings,'EEG'));pEEG=nEEG/length(settings);

disp([' LTM;#n(%):',repmat(' ',1,50-length(' LTM;#n(%):')),num2str(nLTM),'(',num2str(round(100*pLTM)),'%)'])
disp([' EMU:',repmat(' ',1,50-length(' EMU:')),num2str(nEMU),'(',num2str(round(100*pEMU)),'%)'])
disp([' routine EEG:',repmat(' ',1,50-length(' routine EEG:')),num2str(nEEG),'(',num2str(round(100*pEEG)),'%)'])
disp('---------------------------------------------------------------')