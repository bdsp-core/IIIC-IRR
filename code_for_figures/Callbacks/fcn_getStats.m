function [pats,c,p]=fcn_getStats(Y,keys,V,tag,verbose)
    pats=cell(size(Y,1),1);
    for i=1:size(Y,1)
        x=split(keys{i},'_');
        pats{i}=x{2};
    end
    pats=unique(pats);
    
    raters=find(sum(~isnan(Y),1)>0);
    %y=mode(Y,2);
    [~,y]=max(V(:,[2:6,1]),[],2);
    y(y==6)=0;
    
    c=hist(y,0:5);c=c([2:6,1])';
    p=round(1E3*c/sum(c))/10;
    
    if verbose
        str1=[tag,': ',num2str(length(raters)),' raters ',num2str(length(pats)),' patients ',num2str(length(y)),' samples'];
        str2=['SZ     ',num2str(c(1)),' (',num2str(p(1)),'%)'];
        str3=['LPD    ',num2str(c(2)),' (',num2str(p(2)),'%)'];
        str4=['GPD    ',num2str(c(3)),' (',num2str(p(3)),'%)'];
        str5=['LRDA   ',num2str(c(4)),' (',num2str(p(4)),'%)'];
        str6=['GRDA   ',num2str(c(5)),' (',num2str(p(5)),'%)'];
        str7=['Other  ',num2str(c(6)),' (',num2str(p(6)),'%)'];
        disp('-----------------------------------------------------')
        disp(str1);disp(str2);disp(str3);disp(str4);disp(str5);disp(str6);disp(str7)
    end
end